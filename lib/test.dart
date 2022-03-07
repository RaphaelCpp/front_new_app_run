import 'dart:convert';
import 'package:http/http.dart' as http;

class Test {
  String baseUrl = "http://running-back.test/api/user";
  Future<List> postLogin() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return Future.error("Server Error");
      }
    } catch (e) {
      return Future.error(e);
    }
  }

}