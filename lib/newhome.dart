import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String combained = "";
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 60,
              child: TextField(
                controller: controller1,
              ),
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: TextField(
                controller: controller2,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  combained = controller1.text + controller2.text;
                });
              },
              child: Container(
                width: 100,
                height: 60,
                color: Colors.amber,
              ),
            ),
            Text("Combained String = $combained")
          ],
        ),
      ),
    );
  }
}
