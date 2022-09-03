import 'package:flutter/material.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
import 'package:intl/intl.dart';

class CustomGridCard extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? editOnTap;
  final void Function()? deleteOnTap;
  final String? title1;
  final String? title2;
  final int? itemLength;
  final dateTime;

  final Widget? isMoreOption;

  final String image;

  CustomGridCard({
    required this.onTap,
    required this.editOnTap,
    required this.deleteOnTap,
    required this.title1,
    required this.title2,
    this.itemLength,
    this.isMoreOption,
    required this.dateTime,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CustomCardWidget(
      color: white,
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  image,
                  width: size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // CachedNetworkImageWidget(
              //   imageUrl: item.imageLink,
              // ),

              Positioned(
                left: 10,
                top: 0,
                child: IconButton(
                  onPressed: editOnTap,
                  icon: Icon(
                    Icons.edit,
                    color: buttonColorBlue,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                right: 10,
                top: 0,
                child: IconButton(
                  onPressed: deleteOnTap,
                  icon: Icon(
                    Icons.delete,
                    color: redAccent,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          sizeH10,
          Padding(
            padding: paddingH10,
            child: KText(
              text: itemLength == null
                  ? title2 == ''
                      ? title1
                      : '$title1 ($title2)'
                  : '$title1($itemLength) ($title2)',
              fontSize: 18,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
            ),
          ),
          sizeH10,
          Padding(
            padding: paddingH10,
            child: Row(
              children: [
                KText(
                  text: DateFormat.yMMMd().format(dateTime.toDate()),
                  fontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                ),
                Spacer(),
                KText(
                  text: DateFormat.jm().format(
                    dateTime.toDate(),
                  ),
                  fontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w600,
                ),
              isMoreOption == null
                    ? Container():    Spacer(),
                isMoreOption == null
                    ? Container()
                    : Container(
                        child: isMoreOption,
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
