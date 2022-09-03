// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/widgets/buttons/primaryButton.dart';
import 'package:ghose_travels/src/widgets/formfield/numberFormField.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';
import 'package:ghose_travels/src/widgets/snackbar/snackbar.dart';

class LoginPage extends StatelessWidget {
  final phoneTextC = TextEditingController();
  var passwordTextC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setApplicationSwitcherDescription(
        ApplicationSwitcherDescription(
      label: 'Login',
      primaryColor: Theme.of(context).primaryColor.value,
    ));
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width < 900 ? size.width / 1.1 : size.width / 2,
          child: Center(
            child: ListView(
              children: [
                size.width < 900 ? sizeH20 : sizeW10,
                SizedBox(
                    height: size.width < 900 ? 100 : 200,
                    child: Image.asset(
                      'assets/img/logo.png',
                    )),
                SizedBox(
                  height: size.width < 900 ? 30 : size.height / 6,
                ),
                KText(text: 'Phone *'),
                sizeH10,
                customNumberFormField(
                  controller: phoneTextC,
                  isIconHide: true,
                  hintText: 'Phone Number',
                  textColor: grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                sizeH20,
                KText(text: 'Password *'),
                sizeH10,
                customNumberFormField(
                  controller: passwordTextC,
                  isIconHide: true,
                  hintText: 'Password',
                  textColor: grey,
                  borderRadius: BorderRadius.circular(5),
                ),
                sizeH20,
                primaryButton(
                  buttonName: 'Login',
                  onTap: () {
                    var phone = '123456';
                    var password = '123456';
                    if (phoneTextC.text.isEmpty) {
                      snackBarWidget(
                          message: 'Phone number cannot be empty!!',
                          isRed: true);
                    }
                    if (phoneTextC.text.isNotEmpty) {
                      if (phoneTextC.text != phone) {
                        snackBarWidget(
                            message: '''Phone number dosen't match!!''',
                            isRed: true);
                      }
                    }
                    if (passwordTextC.text.isEmpty) {
                      snackBarWidget(
                          message: 'Password cannot be empty!!', isRed: true);
                    }
                    if (passwordTextC.text.isNotEmpty) {
                      if (passwordTextC.text != password) {
                        snackBarWidget(
                            message: '''Password dosen't match!!''',
                            isRed: true);
                      }
                    }

                    if (phoneTextC.text == phone &&
                        passwordTextC.text == password) {
                      snackBarWidget(message: 'Login Success!!', isRed: false);
                      Get.offAllNamed('/dashboard');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
