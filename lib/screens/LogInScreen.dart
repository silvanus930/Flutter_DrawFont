import 'package:hebrew/components/primary_button.dart';
import 'package:hebrew/constants.dart';
import 'package:hebrew/screens/AlphaListScreen.dart';
import 'package:flutter/material.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 2),
              Image.asset(
                "assets/images/logo1.png",
                height: 200,
                width: 200,
              ),
              Spacer(),
              PrimaryButton(
                text: "Let's Start!",
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AlphaListScreen(),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
