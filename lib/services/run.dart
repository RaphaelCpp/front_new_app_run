import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:running_app/services/dio.dart';

class Run extends ChangeNotifier {

  void getRun() async {
    
    try {
      Dio.Response response = await dio().get('/run');
      print(response.data.toString());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void SaveRun({required Map creds}) async {
    try {
      Dio.Response response = await dio().post('/run', data: creds);
      print(response.data.toString());
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}