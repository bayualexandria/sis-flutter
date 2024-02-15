import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/controllers/auth/authentication.dart';
import 'package:getx/pages/auth/login_page.dart';
import 'package:getx/pages/home.dart';

class Middleware extends StatelessWidget {
  const Middleware({super.key});

  @override
  Widget build(BuildContext context) {
    Authentication authentication = Get.find();
    final token = authentication.hasToken();
    return FutureBuilder(
        future: authentication.hasToken(),
        builder: (context, snapshoot) {
          if (token == true) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        });
  }
}
