import 'package:consultation/models/user_model.dart';
import 'package:consultation/services/auth_services.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final AuthService _authService;
  User? _user;
  bool _isLoading = false;

  AuthViewModel() : _authService = AuthService();

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;

  Future<void> checkAuthState() async {
    _user = await _authService.getCurrentUser();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
  _setLoading(true);
  try {
    _user = await _authService.login(email, password);
    notifyListeners();
    return _user != null;
  } finally {
    _setLoading(false);
  }
}

  Future<bool> register({
    required String email,
    required String password,
    required String studentId,
    required String name,
    required String phone,
  }) async {
    _setLoading(true);
    try {
      _user = await _authService.register(
        email: email,
        password: password,
        studentId: studentId,
        name: name,
        phone: phone,
      );
      notifyListeners();
      return _user != null;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _user = null;
    notifyListeners();
  }

  Future<void> updateUserData({String? name, String? phone}) async {
    if (_user == null) return;
    
    _user = _user!.copyWith(
      name: name,
      phone: phone,
    );
    
    await _authService.updateUserData(_user!);
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}