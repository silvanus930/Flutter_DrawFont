import 'package:hebrew/constants.dart';
import 'package:flutter/material.dart';

import 'DrawSpellScreen.dart';

class AlphaListScreen extends StatelessWidget {
  Widget myWidget(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            //mainAxisExtent: 10,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: alpha.length - 1,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(5),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  //borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: EdgeInsets.all(5),
                color: kOrange,
                minWidth: double.infinity,
                height: double.infinity,
                elevation: 5,
                hoverElevation: 5,
                onPressed: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawSpellScreen(
                          index: index,
                          isEdit: false,
                        ),
                      ));
                }),
                child: Text(
                  alpha[index],
                  style: TextStyle(color: Colors.white, fontSize: 70),
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return myWidget(context);
  }
}
