import 'package:get/get.dart';
import 'package:ghose_travels/src/service/users_service.dart';

class UsersController extends GetxController {
  var allUsersList = <Map<String, dynamic>>[].obs;

  getAllUsers() async {
    var temp = await UsersService().getAllUsers();

    if (temp != null) {
      allUsersList.clear();
      for (int i = 0; i < temp.length; i++) {
        allUsersList.add(temp[i].data());
      }
    }
  }
}
