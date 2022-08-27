// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/configs/appColors.dart';
import 'package:ghose_travels/src/configs/apputils.dart';
import 'package:ghose_travels/src/widgets/buttons/primaryButton.dart';
import 'package:ghose_travels/src/widgets/formfield/numberFormField.dart';
import 'package:ghose_travels/src/widgets/kText/kText.dart';

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
          width: size.width / 2,
          child: Center(
            child: ListView(
              children: [
                SizedBox(
                  height: size.height / 2.5,
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
                      Get.snackbar('Opps!!', 'Phone number cannot be empty!!');
                    }
                    if (phoneTextC.text.isNotEmpty) {
                      if (phoneTextC.text != phone) {
                        Get.snackbar('Opps!!', 'Phone number invalid!!');
                      }
                    }
                    if (passwordTextC.text.isEmpty) {
                      Get.snackbar('Opps!!', 'Password cannot be empty!!');
                    }
                    if (passwordTextC.text.isNotEmpty) {
                      if (passwordTextC.text != password) {
                        Get.snackbar('Opps!!', 'Password invalid!!');
                      }
                    }

                    if (phoneTextC.text == phone &&
                        passwordTextC.text == password) {
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
