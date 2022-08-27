import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/appUtils.dart';
import 'package:ghose_travels/src/widgets/card/customCardWidget.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

class DashboardPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Dashboard',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      backgroundColor: white,
      body: Row(
        children: [
          Container(
            child: DrawerComponent().customDrawer(context),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: size.width / 2.5,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _menuUi('Customers', '23,434'),
                              _menuUi('Total Orders', '734'),
                            ],
                          ),
                          Row(
                            children: [
                              _menuUi('Pending', '432'),
                              _menuUi('Shipped', '54'),
                            ],
                          ),
                          Row(
                            children: [
                              _menuUi('Completed', '12'),
                              _menuUi('Cancelled', '23'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _menuUi(title, content) {
    return Expanded(
      child: CustomCardWidget(
        color: grey.shade200,
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KText(
              text: title,
              fontSize: 20,
            ),
            sizeH20,
            KText(
              text: content,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: blueGrey,
            ),
          ],
        ),
      ),
    );
  }
}
