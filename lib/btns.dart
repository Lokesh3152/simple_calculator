import 'package:flutter/material.dart';

class Mybtn extends StatelessWidget {
  final color;
  final textcolor;
  final String btntext;
  final btntapped;
  final longpressd;

  const Mybtn(
      {this.color,
      this.textcolor,
      this.btntext,
      this.btntapped,
      this.longpressd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btntapped,
      onLongPress: longpressd,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                btntext,
                style: TextStyle(fontSize: 24, color: textcolor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
