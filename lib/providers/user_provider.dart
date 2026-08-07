import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _userService = UserService();

  UserModel? _user;

  bool _isLoading = false;

  String? _errorMessage;

  UserModel? get user => _user;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> fetchUser(int id) async {
    try {
      _isLoading = true;

      _errorMessage = null;

      notifyListeners();

      _user = await _userService.fetchUser(id);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;

    notifyListeners();
  }
}
