import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghose_travels/src/components/home/drawerComponent.dart';
import 'package:ghose_travels/src/controllers/BaseController/baseController.dart';
import 'package:ghose_travels/src/widgets/white_space/vertical_space.dart';

class UsersScreen extends StatelessWidget with BaseController {
  UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    return Scaffold(
      body: Row(
        children: [
          Container(
            child: DrawerComponent().customDrawer(context),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Obx(
                () {
                  return SizedBox(
                    width: width * 50,
                    child: ListView(
                      shrinkWrap: true,
                      primary: false,
                      // scrollDirection: Axis.vertical,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalSpace(height: height * 10),
                        const Text(
                          "All users",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const VerticalSpace(height: 20),
                        // Divider(),
                        SizedBox(
                          width: width * 40,
                          child: ListView.builder(
                              // scrollDirection: Axis.vertical,
                              // physics: AlwaysScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: usersController.allUsersList.length,
                              itemBuilder: (context, i) {
                                var temp = usersController.allUsersList[i];
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(temp['name']),
                                    subtitle: Text(temp['email']),
                                    trailing: const Icon(Icons.person),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
