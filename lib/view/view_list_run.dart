// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class ListRun extends StatefulWidget {
//   const ListRun({Key? key}) : super(key: key);
//   @override
//   _ListRunState createState() => _ListRunState();
// }

// class _ListRunState extends State<ListRun> {

//   List myList = [];
//   ScrollController _scrollController = ScrollController();
//   int _maxCurrentList = 5;
//   static int page = 0;
//   @override
//   void initState(){
//     fetchData();

//     super.initState();
//     _scrollController.addListener(() {
//       if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
//         _extendList();
//       }
//      });
//   }
//   fetchData() async {
//     var url = "http://10.0.2.2:8000/api/run/";
//     var response = await http.get(Uri.parse(url));
//     if(response.statusCode == 200){
//       var items = json.decode(response.body);
//       print(items);
//       setState(() {
//         myList = items;
//       });
//     }else{
//       setState(() {
//         myList = [];
//       });
//     }
//   }
  
//   _extendList(){
//     for(int i = _maxCurrentList; i < _maxCurrentList + 5; i++){
//       fetchData();
//     }
//     _maxCurrentList = _maxCurrentList + 5;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: getBody(),
//     );
//   }
//   Widget getBody(){
//     return ListView.builder(      
//         controller: _scrollController,
//         itemExtent: 80,
//         itemBuilder: (context, index){
//           if(index == myList.length){
//             return CupertinoActivityIndicator();
//           }
//           return getCard(myList[index]);
//         },
//         itemCount: myList.length + 1,
//       );
//   }
//       Widget getCard(item){
//         var km = item['km'];
//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ListTile(
//               title: Row(
//                 children: <Widget>[
//                   Container(
//                     width: 50,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: const Color(0xff7c94b6),
//                       borderRadius: BorderRadius.circular(30)
//                       ),
//                   ),
//                   SizedBox(width: 20,),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(km.toString(), style: TextStyle(fontSize: 10)),
//                       SizedBox(height: 10,),
//                       Text("hdghzj", style: TextStyle(fontSize: 10)),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       }
// }
        
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
 
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
  @override
  void initState() {
    this._getMoreData(page);
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels ==
          _sc.position.maxScrollExtent) {
        _getMoreData(page);
      }
    });
  }

  void test() {
    print("hello");
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
        title: const Text("Lazy Load Large List"),
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
        if (index == users.length) {
          return _buildProgressIndicator();
        } else {
          return ListTile(
            title: Row(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff7c94b6),
                    borderRadius: BorderRadius.circular(30)
                    ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(users[index]['id'].toString(), style: TextStyle(fontSize: 10)),
                    Text((users[index]['time'] +" / "+ users[index]['km'].toString() + "km")),
                    SizedBox(height: 10),
                    Text(DateFormat('dd-MM-yyyy – kk:mm').format(date!), style: const TextStyle(fontSize: 10)),
                    RaisedButton(  
                  child: Text("Click Here", style: TextStyle(fontSize: 20),),  
                  onPressed: test,  
                  color: Colors.red,  
                  textColor: Colors.yellow,  
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
  
  void _getMoreData(int index) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      var url = "http://10.0.2.2:8000/api/run?page=${page}";
      final response = await dio.get(url);
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