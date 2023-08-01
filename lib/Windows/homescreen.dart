import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class windowsHome extends StatefulWidget {
  String sunrise;
  String phase;
  int saamam;
  windowsHome(
      {super.key,
      required this.phase,
      required this.saamam,
      required this.sunrise});

  @override
  State<windowsHome> createState() =>
      _windowsHomeState(saamam: saamam, sunrise: sunrise, phase: phase);
}

class _windowsHomeState extends State<windowsHome> {
  String sunrise;
  String phase;
  int saamam;
  _windowsHomeState(
      {required this.phase, required this.saamam, required this.sunrise});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBird();
  }

  String thuyil = "";
  String saavu = "";
  String saavuhumor = '';
  String thuyilhumor = '';
  String thuyilbootham = "";
  String saavubootham = "";
  String thuyilpostion = "";
  String saavupostion = "";
  String thuyilAatharam = "";
  String saavuAatharam = "";

  String findday(int i) {
    print(i);
    print(DateTime.sunday);
    String day = "";

    if (day == DateTime.sunday) {
      day = 'sunday';
    } else if (day == DateTime.monday)
      day = 'monday';
    else if (day == DateTime.tuesday) {
      day = 'tuesday';
    } else if (day == DateTime.wednesday) {
      day = 'wednesday';
    } else if (day == DateTime.thursday) {
      day = 'thursday';
    } else if (day == DateTime.friday) {
      day = 'friday';
    } else if (day == DateTime.saturday) {
      day = "saturday";
    }

    return day;
  }

  loadThuyilAatharam() async {
    final Response = await http.get(Uri.parse(
        "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/bootham/aatharam/$phase/$thuyilbootham.json"));

    if (Response.statusCode == 200) {
      var data = json.decode(Response.body);
      print(data);
      setState(() {
        thuyilAatharam = data["aatharam"];
        thuyilpostion = data["disease"];
      });
    }
    /*DatabaseReference db = FirebaseDatabase.instance.ref();
    print(thuyilbootham);
    print(saavubootham);
    db
        .child("dataset/bootham/aatharam//$phase/$thuyilbootham")
        .get()
        .then((result) {
      print(result.value);
      setState(() {
        thuyilAatharam = result.child("aatharam").value.toString();
        thuyilpostion = result.child("disease").value.toString();
      });
    });*/
  }

  loadsaavuaathram() async {
    final Response = await http.get(Uri.parse(
        "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/bootham/aatharam/$phase/$saavubootham.json"));

    if (Response.statusCode == 200) {
      var data = json.decode(Response.body);
      print(data);
      setState(() {
        saavuAatharam = data["aatharam"];
        saavupostion = data["disease"];
      });
    }

    /* DatabaseReference db = FirebaseDatabase.instance.ref();
    db
        .child("dataset/bootham/aatharam/$phase/$saavubootham")
        .get()
        .then((result) {
      print(result.value);
      setState(() {
        saavuAatharam = result.child("aatharam").value.toString();
        saavupostion = result.child("disease").value.toString();
      });
    });*/
  }

  loadBird() async {
    //  DatabaseReference db = FirebaseDatabase.instance.ref();
    String day =
        DateFormat('EEEE').format(DateTime.now()).toString().toLowerCase();
    print(phase);
    print(day);
    print(saamam);

    final Response = await http.get(Uri.parse(
        "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/$phase/$day/$saamam.json"));

    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      print(js);
      if (js != null) {
        setState(() {
          saavu = js["saavu"];
          thuyil = js["thuyil"];
          loadbotham();
        });
      }
    }

    /* db
        .child("dataset")
        .child(phase)
        .child(day)
        .child(saamam.toString())
        .get()
        .then((result) {
      // print(value.value);
      saavu = result.child("saavu").value.toString();
      setState(() {
        saavu = result.child("saavu").value.toString();
        thuyil = result.child("thuyil").value.toString();
      });
      // loadbotham();
    });*/
  }

  loadbotham() async {
    final Response1 = await http.get(Uri.parse(
        "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/bootham/$phase/$thuyil.json"));

    if (Response1.statusCode == 200) {
      var tem = json.decode(Response1.body);
      setState(() {
        thuyilbootham = tem; //Response1.body;
      });

      final result1 = await http.get(Uri.parse(
          "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/humours/$thuyilbootham.json"));

      if (result1.statusCode == 200) {
        var ts = json.decode(result1.body);
        setState(() {
          // thuyilbootham = Response1.body;
          print(ts);
          thuyilhumor = ts; //ts[thuyilbootham].toString();
          loadThuyilAatharam();
        });
      }
    }

    final Response2 = await http.get(Uri.parse(
        "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/bootham/$phase/$saavu.json"));

    if (Response2.statusCode == 200) {
      var tem = json.decode(Response2.body);

      setState(() {
        saavubootham = tem; //Response2.body;
      });

      final result2 = await http.get(Uri.parse(
          "https://panchapatchi-calculator-default-rtdb.firebaseio.com/dataset/humours/$saavubootham.json"));

      if (result2.statusCode == 200) {
        var ts = json.decode(result2.body);

        setState(() {
          // thuyilbootham = Response1.body;
          //print(ts[saavubootham]);
          saavuhumor = ts;
          loadsaavuaathram();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    double w = MediaQuery.of(context).size.width;
    double wc = 1536;
    

    final sun = DateTime.parse(sunrise);
    String sunvalue = DateFormat("hh:mm:kk").format(sun);
    String consultingtime = DateFormat("hh:mm:kk a").format(currentDate);
    final formattedDate = DateFormat('EEEE, dd MMMM').format(currentDate);
    String saamamText;
    if (saamam > 10)
      saamamText = (saamam - 10).toString();
    else
      saamamText = saamam.toString();
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Image.asset(
              "assets/background/Image.png",
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 30,
            bottom: 0,
            right: (500 * w / wc),
            left: (500 * w / wc),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "PANCHAPATCHI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 21),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      loadBird();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff32333E)),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 10,
                            left: 5,
                            height: 120,
                            child: Image.asset(
                              "assets/background/sun.png",
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                            top: 120,
                            left: 40,
                            child: Column(
                              children: [
                                Text("sunrise",
                                    style: TextStyle(
                                        color: Colors.white54,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400)),
                                Text(sunvalue,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )),
                        Positioned(
                          right: 70,
                          top: 40,
                          child: Text(saamamText,
                              style: TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Positioned(
                          right: 50,
                          top: 85,
                          child: Text("saamam",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white54,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Positioned(
                            left: 20,
                            right: 20,
                            bottom: 10,
                            child: Text("|",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white54,
                                    fontWeight: FontWeight.w400))),
                        Positioned(
                            top: 120,
                            right: 30,
                            child: Column(
                              children: [
                                Text("consulting time",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.white54,
                                        fontWeight: FontWeight.w400)),
                                Text(consultingtime,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                              ],
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/background/line.png"),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            valueBlock("assets/background/sun.png",
                                "moon phase", "Waxing"),
                            valueBlock("assets/background/sun.png", "Bootham",
                                "$saavuhumor\n$thuyilhumor"),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            valueBlock(
                                "assets/background/sun.png", "Thuyil", thuyil),
                            valueBlock(
                                "assets/background/sun.png", "Saavu", saavu),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/background/line.png"),
                  if (thuyilAatharam != "")
                    diseaseCard(thuyilbootham, thuyilAatharam, thuyilpostion),
                  if (saavuAatharam != "")
                    diseaseCard(saavubootham, saavuAatharam, saavupostion),
                  if (thuyilAatharam == "")
                    Container(
                      height: 300,
                      alignment: Alignment.center,
                      child: LoadingAnimationWidget.threeArchedCircle(
                          color: Colors.white, size: 25),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget valueBlock(String asset, String heading, String value) {
    return Container(
      width: 150,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: Image.asset(
              asset,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading,
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 13,
                      fontWeight: FontWeight.w400)),
              Text(value,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          )
        ],
      ),
    );
  }

  Widget diseaseCard(String bird, String aatharam, String position) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 170,
      constraints: BoxConstraints(maxWidth: 600),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xff232329),
                Color.fromARGB(255, 37, 39, 46),
              ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Expected Aathram   :  ",
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                    fontSize: 13.5,
                  )),
              Text("$aatharam",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 13.5,
                  )),
            ],
          ),
          Image.asset("assets/background/line.png"),
          SizedBox(
            height: 9,
          ),
          Text(
            "Expected Region of Pathology",
            style: TextStyle(
                color: const Color.fromARGB(255, 212, 210, 210),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$bird",
            style: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$position",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }
}
