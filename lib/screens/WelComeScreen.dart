import 'package:hebrew/screens/LogInScreen.dart';
import 'package:flutter/material.dart';

class WelComeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset("assets/images/splash.png",
                width: double.infinity, height: double.infinity),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 250, 0, 0),
              child: Center(
                widthFactor: 100,
                heightFactor: 200,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  color: Color.fromARGB(255, 21, 110, 194),
                  minWidth: 100,
                  height: 100,
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogInScreen(),
                      ),
                    );
                  }),
                  child: Icon(
                    Icons.book,
                    size: 70,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
