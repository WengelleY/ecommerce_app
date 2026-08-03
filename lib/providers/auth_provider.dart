import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  String? _token;

  bool _isLoading = false;

  String? _errorMessage;

  String? get token => _token;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;

    notifyListeners();

    try {
      _token = await _authService.login(username, password);
    } catch (e) {
      _errorMessage = "Login failed.";
    }

    _isLoading = false;

    notifyListeners();
  }
}
