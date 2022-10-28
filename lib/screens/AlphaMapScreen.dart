import 'dart:typed_data';
import 'package:hebrew/screens/PrintScreen.dart';
import 'package:hebrew/screens/WelComeScreen.dart';

import 'DrawSpellScreen.dart';
import 'package:hebrew/constants.dart';
import 'package:hebrew/global.dart';
import 'package:flutter/material.dart';

class AlphaMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: pictureDetails.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(5),
                          child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                              //color: kOrange,
                              minWidth: double.infinity,
                              height: double.infinity,
                              onPressed: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DrawSpellScreen(
                                        index: pictureDetails[index].index,
                                        isEdit: true,
                                      ),
                                    ));
                              }),
                              child: new FutureBuilder<Uint8List>(
                                future: pictureDetails[index]
                                    .pictureDetails
                                    ?.toPNG(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Uint8List> snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.done:
                                      if (snapshot.hasError) {
                                        return new Text(
                                            'Error: ${snapshot.error}');
                                      } else {
                                        return Image.memory(snapshot.data!);
                                      }
                                    default:
                                      return new Container(
                                        child: Text(alpha[index],
                                            style: TextStyle(
                                                color:
                                                    Color.fromARGB(26, 0, 0, 0),
                                                fontSize: 70)),
                                        alignment: Alignment.center,
                                      );
                                  }
                                },
                              )));
                    },
                  ),
                ),
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelComeScreen(),
                                ),
                              )
                            },
                            backgroundColor: kGreen,
                            child: Icon(
                              Icons.home,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          FloatingActionButton(
                            onPressed: () => {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrintScreen(),
                                ),
                              )
                            },
                            backgroundColor: kGreen,
                            child: Icon(
                              Icons.book,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          FloatingActionButton(
                            onPressed: () => {},
                            backgroundColor: kGreen,
                            child: Icon(
                              Icons.library_books,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))
                ])
              ],
            )));
  }
}
