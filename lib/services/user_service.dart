import 'package:dio/dio.dart';

import '../models/user.dart';

class UserService {
  final Dio dio = Dio();

  Future<UserModel> fetchUser(int id) async {
    final response = await dio.get("https://fakestoreapi.com/users/$id");

    return UserModel.fromJson(response.data);
  }
}
