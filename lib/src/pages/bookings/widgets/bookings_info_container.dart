import 'package:flutter/material.dart';

class BookingsInfoContainer extends StatelessWidget {
  const BookingsInfoContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.number,
    required this.categoryName,
    required this.function,
  }) : super(key: key);

  final String number;
  final String categoryName;
  final Function function;

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(7),
        height: 100,
        // width: width * 10,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              categoryName,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
