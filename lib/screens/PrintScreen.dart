import 'dart:typed_data';

import 'package:hebrew/constants.dart';
import 'package:hebrew/global.dart';
import 'package:hebrew/screens/AlphaMapScreen.dart';
import 'package:hebrew/screens/WelComeScreen.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintScreen extends StatefulWidget {
  @override
  _PrintScreenState createState() => _PrintScreenState();
}

class _PrintScreenState extends State<PrintScreen> {
  final GlobalKey<State<StatefulWidget>> _printKey = GlobalKey();
  final _mTextInputController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  List<AlphaImage_Info> stringfromImage = [];
  int minFont = 4;
  int maxFont = 20;
  static const currentFont = 5;

  @override
  void initState() {
    super.initState();
    _stringToImage("yyzzyyzzyyyzzzzyzyzyzyzyyzyzyzy");
  }

  List<Widget> buildLetterImages() {
    List<Widget> list = [];
    for (int i = 0; i < stringfromImage.length; i++) {
      list.add(new FutureBuilder<Uint8List>(
        future: stringfromImage[i].pictureDetails?.toPNG(),
        builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasError) {
                return new Text('Error: ${snapshot.error}');
              } else {
                if (stringfromImage[i].index == alpha.length - 1)
                  return SizedBox(
                    width: 10,
                  );
                return Image.memory(
                  snapshot.data!,
                  width: 40,
                  height: 40,
                );
              }
            default:
              return new Container(
                child: Text(alpha[stringfromImage[i].index],
                    style: TextStyle(
                        color: Color.fromARGB(26, 0, 0, 0), fontSize: 40)),
                alignment: Alignment.center,
              );
          }
        },
      ));
    }
    return list;
  }

  void _printScreen() {
    Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final doc = pw.Document();

      final image = await WidgetWraper.fromKey(
        key: _printKey,
        pixelRatio: 2.0,
      );

      doc.addPage(pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Expanded(
                child: pw.Image(image),
              ),
            );
          }));

      return doc.save();
    });
  }

  void _stringToImage(String value) {
    setState(() {
      stringfromImage = [];
      for (var val in value.split('')) {
        int diff = val.codeUnitAt(0) - 'a'.codeUnitAt(0);
        if (val == ' ') diff = alpha.length - 1;
        stringfromImage.add(new AlphaImage_Info(
            pictureDetails: pictureDetails[diff].pictureDetails, index: diff));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 120, 10, 10),
              child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: buildLetterImages()),
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: FloatingActionButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WelComeScreen(),
                                  ),
                                ),
                              },
                              backgroundColor: kOrange,
                              child: Icon(
                                Icons.home,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: FloatingActionButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AlphaMapScreen(),
                                  ),
                                ),
                              },
                              backgroundColor: kOrange,
                              child: Icon(
                                Icons.sort_by_alpha,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(flex: 1),
                          Padding(
                            padding: EdgeInsets.all(0),
                            child: FloatingActionButton(
                              onPressed: _printScreen,
                              //onPressed: () => {},
                              backgroundColor: kOrange,
                              child: Icon(
                                Icons.print,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 39,
                      child: TextField(
                        autofocus: true,
                        focusNode: myFocusNode,
                        controller: _mTextInputController,
                        onChanged: (value) {
                          setState(() {
                            stringfromImage = [];
                            for (var val in value.split('')) {
                              int diff = val.codeUnitAt(0) - 'a'.codeUnitAt(0);
                              if (val == ' ') diff = alpha.length - 1;
                              stringfromImage.add(new AlphaImage_Info(
                                  pictureDetails:
                                      pictureDetails[diff].pictureDetails,
                                  index: diff));
                            }
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            _mTextInputController.clear();
                            myFocusNode.requestFocus();
                          });
                        },
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: FloatingActionButton(
                            onPressed: () => {Navigator.of(context).pop()},
                            backgroundColor: kGreen,
                            child: Icon(
                              Icons.text_decrease,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: FloatingActionButton(
                            onPressed: () => {},
                            backgroundColor: kGreen,
                            child: Icon(
                              Icons.text_increase,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
