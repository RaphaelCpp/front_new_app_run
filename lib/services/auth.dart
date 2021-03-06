import 'dart:convert';

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:running_app/services/dio.dart';
import 'package:running_app/models/user.dart';
import 'package:running_app/view/view_home.dart';

class Auth extends ChangeNotifier {
  bool _isLoggedIn = false;
  late User _user;
  late String _token;
  late final _userId;

  late BuildContext context;

  bool get authenticated => _isLoggedIn;
  User get user => _user;

  final storage = const FlutterSecureStorage();

  void register({required Map creds}) async {
    try {
      Dio.Response response = await dio().post('/register', data: creds);
      print(response.data.toString());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void login({required Map creds}) async {
    try {
      Dio.Response response = await dio().post('/login', data: creds);
      String token = response.data['access_token'].toString();
      tryToken(token: token);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void tryToken({required String? token}) async {
    if (token == null) {
      return;
    } else {
      try {
        Dio.Response response = await dio().post('/profile',
        options: Dio.Options(headers: {'Authorization': 'Bearer $token'}));
        _isLoggedIn = true;
        _user = User.fromJson(response.data);
        _token = token;
        _userId = response.data['id'].toString();
        storeToken(token: token, userId: _userId);
        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken({required String token, required String userId}) async {
    storage.write(key: 'token', value: token);
    storage.write(key: 'userId', value: userId);
  }

  void logout() async {
    try {
      Dio.Response response = await dio().post('/logout',
      options: Dio.Options(headers: {'Authorization': 'Bearer $_token'}));
      cleanUp();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void cleanUp() async {
    _isLoggedIn = false;
    await storage.deleteAll();
  
  }
}