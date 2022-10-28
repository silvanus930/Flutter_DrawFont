import 'package:hebrew/constants.dart';
import 'package:hebrew/global.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'AlphaMapScreen.dart';

class DrawSpellScreen extends StatefulWidget {
  const DrawSpellScreen({
    Key? key,
    required this.index,
    required this.isEdit,
  }) : super(key: key);

  final int index;
  final bool isEdit;

  @override
  _DrawSpellState createState() => _DrawSpellState();
}

class _DrawSpellState extends State<DrawSpellScreen> {
  PainterController _controller = _newController();
  Color _color = globalColor;
  double _brushWidth = globalBrushWidth;
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
    _controller.drawColor = globalColor;
    _controller.thickness = globalBrushWidth;
    if (!widget.isEdit) global_init();
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
                  body: new Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        new Flexible(child: new StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return new Container(
                              height: 40,
                              child: new Slider(
                                value: _controller.thickness,
                                onChanged: (double value) => setState(() {
                                  _controller.thickness = value;
                                  globalBrushWidth = value;
                                }),
                                min: 1.0,
                                max: 20.0,
                                activeColor: Colors.white,
                              ));
                        })),
                        new ColorPicker(
                          showLabel: false,
                          pickerColor: pickerColor,
                          onColorChanged: (Color c) => pickerColor = c,
                        )
                      ])));
            }))
        .then((_) {
      setState(() {
        _color = pickerColor;
        controller.drawColor = _color;
        globalColor = pickerColor;
      });
    });
  }

  void _showImageMap() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return AlphaMapScreen();
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
                          pictureDetails[_index] = new AlphaImage_Info(
                              pictureDetails: _controller.finish(),
                              index: _index);
                          if (!widget.isEdit) {
                            if (_index == alpha.length - 2)
                              _showImageMap();
                            else {
                              _index++;
                              _controller = _newController();
                              _controller.drawColor = globalColor;
                              _controller.thickness = globalBrushWidth;
                            }
                          } else {
                            _showImageMap();
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
