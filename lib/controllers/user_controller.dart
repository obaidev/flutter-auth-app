import 'package:get/get.dart';

class UserController extends GetxController {
  final role = ''.obs;
  final name = ''.obs;

  void setUser(String userRole, String userName) {
    name.value = userName;
    role.value = userRole;
  }

  void clear() {
    role.value = '';
    name.value = '';
  }
}

final userController = Get.put(UserController());
