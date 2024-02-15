import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:getx/controllers/auth/authentication.dart';
import 'package:getx/models/users/user_model.dart';
import 'package:getx/utils/repositories/reporitories.dart';

class UserController {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();
  final repositori = APIEndPoints().baseUrl;
  Authentication authentication = Authentication();

  Future<UserModel?> user() async {
    final token = await storage.read(key: 'token');
    final noInduk = await storage.read(key: 'no_induk');
    try {
      final response = await dio.get('$repositori/user/$noInduk',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': '4lex@ndr!413 $token',
              },
              followRedirects: false,
              validateStatus: (status) {
                return status! < 500;
              }));
      // print(response.data['data']);

      if (response.data['data'] != null) {
        UserModel user = UserModel.fromJson(response.data['data']);
        return user;
      }
      if (response.data['message'] == 'Token tidak valid') {
        authentication.removeToken();
      } else {
        return null;
      }
    } on DioException catch (e) {
      throw Exception(e.toString());
    }
    return null;
  }
}
