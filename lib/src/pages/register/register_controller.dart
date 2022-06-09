import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pf/src/models/user.dart';
import 'package:pf/src/providers/users_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async{
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastName = lastNameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email,name, lastName, phone, password,confirmPassword)){

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: 'Registrando');

      User user = User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        sessionToken: password,
      );


      Response response = await usersProvider.create(user);

      print('RESPONSE: ${response.body}');

      Get.snackbar('Formulario válido', 'Estás listo para enviar la peticion Http');
    }

  }

  bool isValidForm(
      String email,
      String name,
      String lastName,
      String phone,
      String password,
      String confirmPassword){

    if(email.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar el email');
      return false;
    }

    if(!GetUtils.isEmail(email)){
      Get.snackbar('Formulario no válido', 'El email no es válido');
      return false;
    }

    if(name.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu nombre');
      return false;
    }

    if(lastName.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu apellido');
      return false;
    }

    if(phone.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar tu número telefónico');
      return false;
    }

    if(password.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes ingresar el password');
      return false;
    }

    if(confirmPassword.isEmpty){
      Get.snackbar('Formulario no válido', 'Debes confirmar el password');
      return false;
    }

    if(password != confirmPassword){
      Get.snackbar('Formulario no válido', 'Los password no coinciden');
      return false;
    }
    return true;
  }

  Future selectImage(ImageSource imageSource) async{
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null){
      imageFile = File(image.path);
      update();
    }

  }

  void showAlertDialog(BuildContext context){
    Widget galeryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(
            color: Colors.black
          ),
        )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera);
        },
        child: Text(
          'GALERIA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    AlertDialog alertDialog = AlertDialog(
      title:Text('Selecciona una opcion'),
      actions: [
        galeryButton,
        cameraButton
      ],
    );
    
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    });
  }

}