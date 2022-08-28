import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  final double height;
  const VerticalSpace({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
