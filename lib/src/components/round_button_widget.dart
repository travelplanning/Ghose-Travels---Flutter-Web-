import 'package:flutter/material.dart';

class RoundButtonWidget extends StatelessWidget {
  const RoundButtonWidget({
    Key? key,
    required this.labelText,
    this.primaryColor = Colors.white,
    required this.backgroundColor,
    required this.icon,
    this.width = 200,
    required this.function,
  }) : super(key: key);
  //
  final String labelText;
  final Color primaryColor;
  final Color backgroundColor;
  final IconData icon;
  final double width;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 200,
      child: OutlinedButton.icon(
        onPressed: () {
          function();
        },
        label: Text(labelText),
        icon: Icon(
          icon,
        ),
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          backgroundColor: backgroundColor,
          shape: const StadiumBorder(),
          // side: BorderSide(),
        ),
      ),
    );
  }
}
