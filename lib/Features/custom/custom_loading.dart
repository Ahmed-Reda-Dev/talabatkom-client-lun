import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomLoadingIndicator extends StatelessWidget {
  CustomLoadingIndicator({Color? color, Key? key}) : super(key: key);
  final Color color = HexColor('#F5504C');
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      size: 25,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: color,
          ),
        );
      },
    );
  }
}
