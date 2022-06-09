import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pf/src/models/user.dart';
import 'package:pf/src/pages/home/home_page.dart';
import 'package:pf/src/pages/login/login_page.dart';
import 'package:pf/src/pages/register/register_page.dart';
import 'package:pf/src/pages/roles/roles_page.dart';

User userSession = User.fromJson(GetStorage().read('key') ??{});

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO:implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Delivery VR',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id != null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/roles', page: () => RolesPage()),
      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: ColorScheme(
          secondary: Colors.amberAccent,
          primary: Colors.amber,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          onSecondary: Colors.grey,
          background: Colors.grey
        )
      ),
      navigatorKey: Get.key,
    );
  }
}
