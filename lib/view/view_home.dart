import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:running_app/view/view_login.dart';
import 'package:running_app/services/auth.dart';
import 'package:intl/intl.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    Provider.of<Auth>(context, listen: false).tryToken(token: token);
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: Consumer<Auth>(builder: (context, auth, child) {

           String getDate() {
            var date = auth.user.created;
            var dateParse = DateTime.parse(date);
            var formattedDate = "membre depuis : ${dateParse.day}/${dateParse.month}/${dateParse.year}";
            return formattedDate.toString();
          }
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FlatButton(
                    child: 
                    Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false).logout();
                    },
                  ),
                ],
              ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 30,
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          auth.user.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.08,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        Text(
                          auth.user.email,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        
                        Text(
                          getDate(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.03,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ]),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 1,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                child: Text(
                  "Statistiques du compte",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: Column(
                          children: [Text("32,4 km"), Text("km parcourus")],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [Text("cc")],
                  )
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}