import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      "https://fakestoreapi.com/auth/login",

      data: {"username": username, "password": password},
    );

    return response.data["token"];
  }
}
