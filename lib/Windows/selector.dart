import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:panthapatchi/Windows/homescreen.dart';
import 'package:panthapatchi/Windows/login.dart';
import 'package:panthapatchi/homescreen.dart';
import 'package:panthapatchi/newhome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class windowSelector extends StatefulWidget {
  const windowSelector({super.key});

  @override
  State<windowSelector> createState() => _windowSelectorState();
}

class _windowSelectorState extends State<windowSelector> {
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
  loadLocation(DateTime dt) async {
    final Response = await http
        .get(Uri.parse("https://api.seeip.org/geoip?callback=getgeoip"));
    if (Response.statusCode == 200) {
      String temp = Response.body.replaceAll("getgeoip({", "{");
      temp = temp.replaceAll(");", "");

      final formatter = DateFormat('yyyy-MM-dd');
      String datesting = formatter.format(dt);
      var data = json.decode(temp);
      final sunrise = await http.get(Uri.parse(
          "https://api.sunrise-sunset.org/json?lat=${data["latitude"]}&lng=${data["longitude"]}&formatted=0&date=$datesting"));
      print(sunrise.statusCode);
      print(sunrise.body);
      if (sunrise.statusCode == 200) {
        var sun = json.decode(sunrise.body);
        DateTime time = DateTime.parse(sun['results']['sunrise']);
        print(time.toLocal());
        print(dt);
        for (int i = 1; i <= 10; i++) {
          print(i);
          Duration duration = Duration(hours: 2, minutes: 22) * (i);
          DateTime secondtime = time.toLocal().add(duration);
          if (time.toLocal().isBefore(dt) && dt.isBefore(secondtime)) {
            setState(() {
              print("Current saamam is  : $i");
              sunrisetime = time.toLocal().toString();
              saamam = i;
            });

            if (calculateMoonAge(dt) < 14)
              phase = "waxing";
            else {
              phase = ("waning");
            }
            setState(() {
              isLoading = false;
            });
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => windowsHome(
                      saamam: saamam,
                      phase: phase,
                      sunrise: sunrisetime,
                    )));
            break;
          }
        }

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
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                        onTap: () async {
                          DateTime actual = DateTime.now();

                          final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              //initialEntryMode: DatePickerEntryMode.input,
                              lastDate: DateTime.now());

                          if (pickedDate != null) {}

                          final TimeOfDay? pickedTime = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());

                          if (pickedDate != null && pickedTime != null) {
                            DateTime temp = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );

                            onDateandtime(temp);
                          }
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
                ))
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
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => windowsLOgin()));
                },
                child: Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              ))
        ],
      ),
    ));
  }

  onDateandtime(DateTime dt) {
    setState(() {
      isLoading = true;
    });
    loadLocation(dt);
  }
}
