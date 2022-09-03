import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/apputils.dart';

class CustomCardWidget extends StatelessWidget {
  final Color color;

  final Widget child;
  final double? height;
  final double? width;
  final Alignment? alignment;
  final double? elevation;
  final BorderRadiusGeometry? borderRadius;
  final void Function()? onTap;
  final bool? isPaddingOn;
  final bool? isStack;

  final BoxBorder? border;

  CustomCardWidget({
    required this.color,
    required this.child,
    this.height,
    this.width,
    this.alignment,
    this.onTap,
    this.isPaddingOn,
    this.elevation,
    this.isStack,
    this.borderRadius,
    this.border,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: isPaddingOn == true ? paddingH10 : EdgeInsets.all(0),
        child: Card(
          elevation: elevation == null ? 2 : elevation,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius != null
                ? borderRadius as BorderRadiusGeometry
                : borderRCircular5,
          ),
          child: Container(
            height: height,
            width: width,
            alignment: alignment,
            decoration: BoxDecoration(
              borderRadius: borderRCircular5,
              border: border,
              color: color,
            ),
            child: isStack == true
                ? Stack(
                    children: [
                      child,
                    ],
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
