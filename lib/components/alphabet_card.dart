import 'package:flutter/material.dart';

import '../screens/DrawSpellScreen.dart';

class AlphabetCard extends StatelessWidget {
  const AlphabetCard({
    Key? key,
    required this.alphaName,
    required this.alphaId,
  }) : super(key: key);

  final String alphaName;
  final int alphaId;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        //margin: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DrawSpellScreen(
                  index: alphaId,
                  isEdit: false,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFFEBA350),
                  child: Text(
                    alphaName,
                    style: TextStyle(fontSize: 36, color: Colors.white),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  alphaName,
                  style: TextStyle(color: Color(0xFF1CA4C1)),
                ),
              ),
            ],
          ),
        ));
  }
}
