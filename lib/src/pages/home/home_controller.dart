import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pf/src/models/user.dart';


class HomeController extends GetxController{
  User user = User.fromJson(GetStorage().read('user') ?? {});
  
  HomeController(){
    print('Usuario de sesión: ${user.toJson()}');

  }

  void signOut() {
    GetStorage().remove('User');
    Get.offNamedUntil('/', (route) => false);

  }

}