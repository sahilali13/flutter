// ignore_for_file: avoid_init_to_null, unnecessary_null_comparison

import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token = null;
  DateTime? _expiryDate = null;
  String? _userId = null;
  Timer? _authTimer = null;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> _authenticate(
      String? _email, String? _password, String _urlSegment) async {
    final _url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:$_urlSegment?key=AIzaSyBlyVQkafvTn5YK2uyM3V93WQOz_tq3NSc');
    try {
      final _response = await http.post(
        _url,
        body: json.encode(
          {
            'email': _email,
            'password': _password,
            'returnSecureToken': true,
          },
        ),
      );
      final _responseData = json.decode(_response.body);
      if (_responseData['error'] != null) {
        throw HttpException(_responseData['error']['message']);
      }
      _token = _responseData['idToken'];
      _userId = _responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            _responseData['expiresIn'],
          ),
        ),
      );
      _autoLogout();
      notifyListeners();
      final _prefs = await SharedPreferences.getInstance();
      final _userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate!.toIso8601String(),
        },
      );
      _prefs.setString('userData', _userData);
    } catch (_error) {
      rethrow;
    }
  }

  Future<void> signup(String? _email, String? _password) async {
    return _authenticate(_email, _password, 'signUp');
  }

  Future<void> login(String? _email, String? _password) async {
    return _authenticate(_email, _password, 'signInWithPassword');
  }

  Future<bool> tryAutoLogin() async {
    final _prefs = await SharedPreferences.getInstance();
    if (!_prefs.containsKey('userData')) {
      return false;
    }
    final _extractedUserData = json
        .decode(_prefs.getString('userData') as String) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(_extractedUserData['expiryDate'] as String);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = _extractedUserData['token'] as String;
    _userId = _extractedUserData['userId'] as String;
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final _timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: _timeToExpiry), logout);
  }
}
