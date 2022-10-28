import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hebrew/constants.dart';
import 'package:hebrew/global.dart';
import 'package:painter/painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class DrawSpell_Orign extends StatefulWidget {
  const DrawSpell_Orign({
    Key? key,
    required this.index,
    required this.isEdit,
  }) : super(key: key);

  final int index;
  final bool isEdit;

  @override
  _DrawSpellState createState() => _DrawSpellState();
}

class _DrawSpellState extends State<DrawSpell_Orign> {
  PainterController _controller = _newController();
  Color _color = new Color.fromARGB(255, 0, 0, 0);
  late int _index = widget.index;

  static PainterController _newController() {
    PainterController controller = new PainterController();
    controller.thickness = 5.0;
    controller.drawColor = Colors.black54;
    controller.backgroundColor = Colors.white60;
    return controller;
  }

  @override
  void initState() {
    super.initState();
  }

  void _pickColor(PainterController controller) {
    Color pickerColor = _color;
    Navigator.of(context)
        .push(new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                  appBar: new AppBar(
                    title: const Text('Pick color'),
                  ),
                  body: new Container(
                      alignment: Alignment.center,
                      child: Column(children: [
                        new Flexible(child: new StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return new Container(
                              child: new Slider(
                            value: _controller.thickness,
                            onChanged: (double value) => setState(() {
                              _controller.thickness = value;
                            }),
                            min: 1.0,
                            max: 20.0,
                            activeColor: Colors.white,
                          ));
                        })),
                        new ColorPicker(
                          pickerColor: pickerColor,
                          onColorChanged: (Color c) => pickerColor = c,
                        )
                      ])));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
        controller.drawColor = _color;
      });
    });
  }

  void _show(List<AlphaImage_Info> pictures, BuildContext context) {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new Scaffold(
          appBar: new AppBar(
            title: const Text('View your image'),
          ),
          body: new Container(
            alignment: Alignment.center,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: pictures.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                    padding: EdgeInsets.all(5),
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                        //color: kOrange,
                        minWidth: double.infinity,
                        height: double.infinity,
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrawSpell_Orign(
                                  index: pictures[index].index,
                                  isEdit: true,
                                ),
                                //builder: (context) => ExamplePage(),
                              ));
                        }),
                        child: new FutureBuilder<Uint8List>(
                          future: pictures[index].pictureDetails?.toPNG(),
                          builder: (BuildContext context,
                              AsyncSnapshot<Uint8List> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.done:
                                if (snapshot.hasError) {
                                  return new Text('Error: ${snapshot.error}');
                                } else {
                                  return Image.memory(snapshot.data!);
                                }
                              default:
                                return new Container(
                                    child: new FractionallySizedBox(
                                  widthFactor: 0.1,
                                  child: new AspectRatio(
                                      aspectRatio: 1.0,
                                      child: new CircularProgressIndicator()),
                                  alignment: Alignment.center,
                                ));
                            }
                          },
                        )));
              },
            ),
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: FloatingActionButton(
                      onPressed: () => {
                        setState(
                          () {
                            _controller.clear();
                          },
                        )
                      },
                      backgroundColor: kBlue,
                      child: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(flex: 1),
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: FloatingActionButton(
                      onPressed: () => {_pickColor(_controller)},
                      backgroundColor: kGreen,
                      child: Icon(
                        Icons.edit,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Image.asset(
                  //   alpha_images[_index],
                  //   height: MediaQuery.of(context).size.width,
                  //   width: double.infinity,
                  // ),
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    child: Text(
                      alpha[_index],
                      style: TextStyle(color: Colors.red, fontSize: 270),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 300,
                    child: new Painter(_controller),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(0),
                    child: FloatingActionButton(
                      onPressed: () => {Navigator.of(context).pop()},
                      backgroundColor: kOrange,
                      child: Icon(
                        Icons.backspace,
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
                        setState(() {
                          if (_index < alpha.length - 1) {
                            _index++;
                            _controller = _newController();
                          } else {}
                        }),
                      },
                      backgroundColor: kOrange,
                      child: Icon(
                        Icons.skip_next_rounded,
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
                        setState(() {
                          if (!widget.isEdit) {
                            pictureDetails.add(new AlphaImage_Info(
                                pictureDetails: _controller.finish(),
                                index: _index));
                            if (_index == alpha.length - 1)
                              _show(pictureDetails, context);
                            else {
                              _index++;
                              _controller = _newController();
                            }
                          } else {
                            pictureDetails[widget.index] = new AlphaImage_Info(
                                pictureDetails: _controller.finish(),
                                index: widget.index);
                            _show(pictureDetails, context);
                          }
                        }),
                      },
                      backgroundColor: kRed,
                      child: Icon(
                        Icons.save,
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
      )),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Chats"),
      actions: [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
      ],
    );
  }
}
