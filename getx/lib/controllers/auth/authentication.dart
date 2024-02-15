import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:getx/pages/auth/login_page.dart';
import 'package:getx/pages/home.dart';
import 'package:getx/utils/repositories/reporitories.dart';

class Authentication extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;

  Future<void> loginEndPoint() async {
    Map body = {'username': username.text, 'password': password.text};
    try {
      final response = await dio.post('$repositori/login',
          data: body,
          options: Options(
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      // print(response.data['token']);
      if (response.data['status'] == 400) {
        final username = response.data['message']['username'] ?? '';
        final password = response.data['message']['password'] ?? '';

        Get.snackbar(
          'message',
          '$username \n$password',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 193, 193),
          colorText: Colors.red,
          titleText: const Text(
            'Pesan Error',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
          ),
        );
        return response.data['message'];
      }
      if (response.data['status'] == 401) {
        Get.snackbar('message', response.data['message'],
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: const Color.fromARGB(255, 255, 193, 193),
            colorText: Colors.red,
            titleText: const Text(
              'Pesan Error',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ));
        return response.data['message'];
      }
      await storage.write(key: 'token', value: response.data['token']);
      await storage.write(
          key: 'no_induk', value: response.data['user']['no_induk']);
      Get.off(const HomePage());
      return response.data;
    } catch (e) {
      return e.printError();
    }
  }

  Future<String?> token() async {
    final response = await storage.read(key: 'token');
    return response;
  }

  Future<bool> hasToken() async {
    var value = await storage.read(key: 'token');
    if (value != null) {
      Get.off(const HomePage());
      return true;
    } else {
      Get.off(const LoginPage());
      return false;
    }
  }

  Future removeToken() async {
    var token = await storage.deleteAll();

    Get.off(const LoginPage());
    return token;
  }
}
