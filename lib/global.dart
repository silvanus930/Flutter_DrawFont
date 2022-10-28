import 'package:hebrew/constants.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';

class AlphaImage_Info {
  final PictureDetails? pictureDetails;
  final int index;

  const AlphaImage_Info({
    required this.pictureDetails,
    required this.index,
  });
}

List<AlphaImage_Info> pictureDetails = [];

Color globalColor = Colors.black38;
double globalBrushWidth = 5.0;

void global_init() {
  for (int i = 0; i < alpha.length; i++) {
    pictureDetails.add(new AlphaImage_Info(pictureDetails: null, index: i));
  }
}
