import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:pf/src/environment/environment.dart';
import 'package:pf/src/models/response_api.dart';
import 'package:pf/src/models/user.dart';

class UsersProvider extends GetConnect{
  String url = Environment.API_URL + 'api/users';
  
  Future<Response> create(User user) async {
    Response response = await post(
        '$url/create',
        user.toJson(),
        headers:{
          'Content-Type': 'application/json'
        }
    );//esperar hasta que el servidor nos retorne la respuesta -async y await

    return response;
  }

  Future<ResponseApi> createUserWithImage(User user, File image) async{
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });
    Response response = await post('$url/createWithImage', form);

    if(response.body == null){
      Get.snackbar('Error en la petición', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers:{
          'Content-Type': 'application/json'
        }
    );//esperar hasta que el servidor nos retorne la respuesta -async y await

    if(response.body == null){
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);

    return responseApi;
  }

}