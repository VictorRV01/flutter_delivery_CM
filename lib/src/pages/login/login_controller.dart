import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pf/src/models/response_api.dart';
import 'package:pf/src/providers/users_provider.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage(){
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)){
      ResponseApi responseApi = await usersProvider.login(email, password);
      print('Response Api: ${responseApi.toJson()}');

      if(responseApi.success == true){
        GetStorage().write('user', responseApi.data);
        //goToHomePage();
        goToRolesPage();
        Get.snackbar('Login exitoso', 'Haz iniciado sesion');
      }
      else{
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }

    }

  }

  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false);
  }
  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  bool isValidForm(String email, String password){

    if(email.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar el email');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no válido', 'El email no es válido');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar el password');
      return false;
    }

    return true;
  }
  
}