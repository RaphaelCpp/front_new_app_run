
        
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:running_app/view/view_openMap.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
 
class ListRun extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ListRunState();
}
 
class ListRunState extends State<ListRun> {
  static int page = 1;
  ScrollController _sc = new ScrollController();
  bool isLoading = false;
  static List users = [];
  final dio = new Dio();
  final storage = new FlutterSecureStorage();


  @override
  void initState() {
    _getMoreData(page);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
  }


  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historique des courses"),
      ),
      body: Container(
        child: _buildList(),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
 
  Widget _buildList() {

    return ListView.builder(
      
      itemCount: users.length, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        DateTime? date = DateTime.tryParse(users[index]['created_at']);
        late final user_id = users[index]['id'];
        
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return ListTile(

             key: UniqueKey(),
            title: Row(
              children: <Widget>[
                const ImageIcon(
                AssetImage("images/troph.png"),
                size: 40,
              ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("n°"+users[index]['id'].toString(), style: TextStyle(fontSize: 12)),
                    Text((users[index]['time'] +" / "+ users[index]['km'].toString() + "km")),
                    SizedBox(height: 10),
                    Text(DateFormat('dd-MM-yyyy – kk:mm').format(date!), style: const TextStyle(fontSize: 12)),
                    RaisedButton(  
                  child: Text("afficher ma course", style: TextStyle(fontSize: 15),),  
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OpenMap(latlong: json.decode(users[index]['lat_long'])),
                      ),
                    );
                  },  
                  color: Colors.white,  
                  textColor: Colors.green,  
                  padding: EdgeInsets.all(8.0),  
                  splashColor: Colors.grey,  
                    )
                  ],
                  
                )
              ],
            )
          );
        }
      },
      controller: _sc,
    );
  }

  void _getMoreData(int index,) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      String? userId = await storage.read(key: 'userId');
      var url = "http://10.0.2.2:8000/api/run/${userId}?page=${page}";
      final response = await dio.get(url);
      print(userId.toString());
      List tList = [];
      for (int i = 0; i < response.data['data'].length; i++) {
        tList.add(response.data['data'][i]);
      }
 
      setState(() {
        isLoading = false;
        users.addAll(tList);
        page++;
      });
    }
  }
 
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
 
}