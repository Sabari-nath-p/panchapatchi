import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:panthapatchi/homescreen.dart';
import 'package:panthapatchi/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class selectorDart extends StatefulWidget {
  const selectorDart({super.key});

  @override
  State<selectorDart> createState() => _selectorDartState();
}

class _selectorDartState extends State<selectorDart> {
  double calculateMoonAge(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    final currentTime = date.microsecondsSinceEpoch;

    final timeOfNewMoon =
        DateTime.utc(2000, 1, 6, 18, 14); // UTC time of a known new moon
    final timeSinceNewMoon = currentTime - timeOfNewMoon.microsecondsSinceEpoch;
    final daysSinceNewMoon =
        (timeSinceNewMoon / (24 * 60 * 60 * 1000000)).floor();

    final synodicMonth =
        29.53058867; // Average length of the synodic month in days

    final daysIntoCycle = daysSinceNewMoon % synodicMonth;

    final moonAge = (daysIntoCycle / synodicMonth) * 29.53;

    return moonAge;
  }

  int saamam = -1;
  String sunrisetime = "";
  String phase = "";
  bool isLoading = false;
  loadLocation() async {
    final Response = await http
        .get(Uri.parse("https://api.seeip.org/geoip?callback=getgeoip"));
    if (Response.statusCode == 200) {
      String temp = Response.body.replaceAll("getgeoip({", "{");
      temp = temp.replaceAll(");", "");
      //print(temp);
      var data = json.decode(temp);
      final sunrise = await http.get(Uri.parse(
          "https://api.sunrise-sunset.org/json?lat=${data["latitude"]}&lng=${data["longitude"]}&formatted=0"));
      //  print(sunrise.statusCode);
      if (sunrise.statusCode == 200) {
        // print(sunrise.body);
        var sun = json.decode(sunrise.body);
        DateTime time = DateTime.parse(sun['results']['sunrise']);
        print(time.toLocal());

        for (int i = 1; i <= 10; i++) {
          DateTime;
          Duration duration = Duration(hours: 2, minutes: 22) * (i);
          DateTime secondtime = time.toLocal().add(duration);
          if (time.toLocal().isBefore(DateTime.now()) &&
              DateTime.now().isBefore(secondtime)) {
            setState(() {
              print("Current saamam is  : $i");
              sunrisetime = time.toLocal().toString();
              saamam = i;
            });

            if (calculateMoonAge(DateTime.now()) < 14)
              phase = "waxing";
            else {
              phase = ("waning");
            }
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => homeScreen(
                      saamam: saamam,
                      phase: phase,
                      sunrise: sunrisetime,
                    )));
            break;
          }
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  findmoonStage() {}

  @override
  Widget build(BuildContext context) {
    var format = DateFormat(' h : m : s ');
    var dateString = format.format(DateTime.now());
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/background/splashbg.png",
                fit: BoxFit.fill,
              )),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 30, top: 100),
                  child: Image.asset(
                    "assets/background/logo_trans.png",
                    width: 350,
                    height: 350,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 320,
                  child: Text("PANCHAPATCHI\nSaasthram",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w600,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                      "Predict your possible pathology according to panchapatchi saasthram",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    loadLocation();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 40),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        gradient: LinearGradient(colors: [
                          Color(0xff484B5B),
                          Color(0xff2C2D35),
                        ])),
                    child: (isLoading)
                        ? LoadingAnimationWidget.threeArchedCircle(
                            color: Colors.white, size: 40)
                        : Icon(
                            Icons.arrow_right,
                            size: 45,
                            color: Colors.white,
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Click Here to Predict")
              ],
            ),
          ),
          Positioned(
              top: 30,
              right: 30,
              child: InkWell(
                onTap: () async {
                  final pref = await SharedPreferences.getInstance();
                  pref.setString("LOGIN", "OUT");
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => signup()));
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              )),
          Positioned(
              top: 30,
              right: 80,
              child: InkWell(
                onTap: () async {
                  launchUrl(
                      Uri.parse(
                        "https://www.mediafire.com/file/hnx7vdl62luos3m/setup.exe",
                      ),
                      mode: LaunchMode.externalNonBrowserApplication);
                },
                child: Icon(
                  Icons.download,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    ));
  }
}