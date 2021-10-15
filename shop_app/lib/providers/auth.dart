import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String? _token;
  // ignore: avoid_init_to_null
  DateTime? _expiryDate = null;
  late String? _userId;

  bool get isAuth {
    // ignore: unnecessary_null_comparison
    return token != null;
  }

  String? get token {
    // ignore: unnecessary_null_comparison
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        // ignore: unnecessary_null_comparison
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
      notifyListeners();
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

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
  }
}
