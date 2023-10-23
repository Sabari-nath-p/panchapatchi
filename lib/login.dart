import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:panthapatchi/selector.dart';
import 'package:panthapatchi/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class signup extends StatefulWidget {
  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController nameText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController emailText = TextEditingController();

  bool isLoading = false;
  bool isLogin = true;
  double fem = 0;
  double ffem = 0;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    fem = MediaQuery.of(context).size.width / baseWidth;
    ffem = fem * 0.8;
    return Scaffold(
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Container(
          // loginTBL (9:229)
          //  padding: EdgeInsets.fromLTRB(25 * fem, 26 * fem, 25 * fem, 256 * fem),
          padding: EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(60 * fem),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // letsgetstartedJjg (9:232)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 19 * fem),
                  child: Text(
                    'Panchapatchi  Predictor',
                    textAlign: TextAlign.center,
                    style: SafeGoogleFont(
                      'Poppins',
                      fontSize: 24 * ffem,
                      fontWeight: FontWeight.w500,
                      height: 1.5 * ffem / fem,
                      color: Color(0xff0a0d14),
                    ),
                  ),
                ),
                Container(
                  // frame162519a2z (9:230)
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // letsgetstartedJjg (9:232)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 19 * fem),
                        child: Text(
                          'Lets Get Started',
                          textAlign: TextAlign.center,
                          style: SafeGoogleFont(
                            'Poppins',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w500,
                            height: 1.5 * ffem / fem,
                            color: Color(0xff0a0d14),
                          ),
                        ),
                      ),
                      Container(
                        // inputfieldcVU (9:234)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 10 * fem),
                        padding: EdgeInsets.fromLTRB(
                            20 * fem, 22 * fem, 10.5 * fem, 22 * fem),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xfff9fafb),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                // frame511037SE (9:235)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                child: Icon(
                                  Icons.email,
                                  color: Colors.black54,
                                )),
                            Expanded(
                                child: TextField(
                              controller: emailText,
                              style: mystyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                isCollapsed: true,
                                hintText: "Sign in User ID",
                                hintStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238 * ffem / fem,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        // inputfieldcVU (9:234)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 10 * fem),
                        padding: EdgeInsets.fromLTRB(
                            20 * fem, 22 * fem, 10 * fem, 22 * fem),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xfff9fafb),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                // frame511037SE (9:235)

                                margin: EdgeInsets.only(right: 10),
                                child: Icon(Icons.password)),
                            Expanded(
                                child: TextField(
                              controller: passwordText,
                              obscureText: true,
                              style: mystyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                isDense: true,
                                isCollapsed: true,
                                hintText: "Enter Password",
                                hintStyle: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 16 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238 * ffem / fem,
                                  color: Color(0xff979797),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                      if (!isLogin)
                        Container(
                          // inputfieldcVU (9:234)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 19 * fem),
                          padding: EdgeInsets.fromLTRB(
                              20 * fem, 22 * fem, 83.5 * fem, 22 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xfff9fafb),
                            borderRadius: BorderRadius.circular(20 * fem),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  // frame511037SE (9:235)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 10 * fem, 0 * fem),
                                  width: 18 * fem,
                                  height: 14.32 * fem,
                                  child: Icon(Icons.near_me)),
                              Expanded(
                                  child: TextField(
                                controller: nameText,
                                style: mystyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  isCollapsed: true,
                                  hintText: "Enter Name",
                                  hintStyle: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 16 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.6000000238 * ffem / fem,
                                    color: Color(0xff979797),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                      if (isLogin)
                        InkWell(
                          onTap: () {
                            if (passwordText.text.isNotEmpty &&
                                emailText.text.isNotEmpty) {
                              tryLog(emailText.text.trim(),
                                  passwordText.text.trim());
                            } else {
                              Fluttertoast.showToast(msg: "Please fill");
                            }
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: (isLoading)
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white, size: 25)
                                : Text(
                                    "sign In",
                                    style:
                                        mystyle(color: Colors.white, size: 23),
                                  ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black),
                          ),
                        ),
                      if (!isLogin)
                        InkWell(
                          onTap: () {
                            if (nameText.text.length < 4) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a valid name");
                            } else if (passwordText.text.length < 8) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please enter valid password \nMinimum 8 charater");
                            } else if (!emailText.text.contains("@")) {
                              Fluttertoast.showToast(
                                  msg: "Please enter a valid email");
                            } else {
                              tryReg(
                                  nameText.text.trim(),
                                  emailText.text.trim(),
                                  passwordText.text.trim());
                            }
                          },
                          child: Container(
                            width: 200,
                            height: 50,
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: (isLoading)
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white, size: 25)
                                : Text(
                                    "Sign Up",
                                    style:
                                        mystyle(color: Colors.white, size: 23),
                                  ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      if (!isLogin)
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already Have an Account?',
                                style: mystyle(size: 14),
                              ),
                              Text(
                                ' ',
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.7000001272 * ffem / fem,
                                  color: Color(0xff767a8a),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(
                                  'Sign in',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.7000001272 * ffem / fem,
                                    color: Color(0xff1f7ae0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (isLogin)
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'you, didn\'t have an account?',
                                style: mystyle(size: 14),
                              ),
                              Text(
                                ' ',
                                style: SafeGoogleFont(
                                  'Poppins',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w500,
                                  height: 1.7000001272 * ffem / fem,
                                  color: Color(0xff767a8a),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isLogin = !isLogin;
                                  });
                                },
                                child: Text(
                                  'Sign up',
                                  style: SafeGoogleFont(
                                    'Poppins',
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.7000001272 * ffem / fem,
                                    color: Color(0xff1f7ae0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  mystyle({Color color = const Color(0xff979797), double size = 16}) {
    return SafeGoogleFont(
      'Poppins',
      fontSize: size * ffem,
      fontWeight: FontWeight.w500,
      height: 1.6000000238 * ffem / fem,
      color: color,
    );
  }

  /* sendlogin(String email, String password) {
    setState(() {
      isLoading = true;
    });
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    users.doc(email).get().then((value) async {
      if (value.exists) {
        if (password == value.get("password").toString()) {
          print(value.data());
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("LOGIN", "IN");
          pref.setString("EMAIL", email);
          pref.setString("PASSWORD", password);
          pref.setString("NAME", value.get("name").toString());
          // if (value.get("admin").exists)
          // pref.setString("ISADMIN", value.get("admin").toString());
          //Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "Sucessfully Logined");
        } else {
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(msg: "Login failed , invalid Credential");
        }
      } else {
        Fluttertoast.showToast(msg: "Login failed , invalid Credential");
        setState(() {
          isLoading = false;
        });
      }
    });
  }*/

  tryLog(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    //   FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//    firebaseAuth
    //   .signInWithEmailAndPassword(email: email, password: password)
    //    .then((value) async {

    final Response = await http.get(Uri.parse(
        "https://panchapatchi-calculator-default-rtdb.firebaseio.com/user/${email.split("@")[0]}.json"));

    if (Response.statusCode == 200) {
      var jdata = json.decode(Response.body);
      if (jdata != null) {
        print(jdata);
        print(Response.body);

        if (password == jdata["password"]) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("LOGIN", "IN");
          pref.setString("EMAIL", email);
          pref.setString("PASSWORD", password);
          print("working");
          // if (value.get("admin").exists)
          // pref.setString("ISADMIN", value.get("admin").toString());
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => selectorDart()));
          // Fluttertoast.showToast(msg: "Sucessfully Logined");
          //   print(value);
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print("unknown 1");
      print(Response.body);
      setState(() {
        isLoading = false;
      });
    }
  }

  tryReg(String name, String email, String password) async {
    setState(() {
      isLoading = true;
    });
    final Response = await http.patch(
        Uri.parse(
            "https://panchapatchi-calculator-default-rtdb.firebaseio.com/user.json"),
        body: jsonEncode(({
          "${email.split("@")[0]}": {"name": name, "password": password}
        })));

    if (Response.statusCode == 200) {
      print(Response.body);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("LOGIN", "IN");
      pref.setString("EMAIL", email);
      pref.setString("PASSWORD", password);
      print("working");
      // if (value.get("admin").exists)
      // pref.setString("ISADMIN", value.get("admin").toString());
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => selectorDart()));
      // Fluttertoast.showToast(msg: "Sucessfully Logined");
      //   print(value);
      setState(() {
        isLoading = false;
      });
    } else {
      print("unkonw");
      print(Response.statusCode);
      print(Response.body);
      setState(() {
        isLoading = false;
      });
    }
  }
}
