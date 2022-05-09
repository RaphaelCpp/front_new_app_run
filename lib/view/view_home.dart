
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
  Duration duration = Duration();
 
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
 
  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 25),
            ),
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );
 
  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'H'),
      buildTimeCard(time: minutes, header: 'Min'),
      buildTimeCard(time: seconds, header: 'Sec'),
    ]);
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
                    child: Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false).logout();
                      Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginView()));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/100"),
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
                    backgroundColor: Color.fromARGB(255, 50, 245, 160),
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
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "32,4 km",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text("km parcourus")
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                      
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
              
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            buildTime(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Temps de course")
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 1,
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * .9,
                child: Text(
                  "Statistiques mensuel",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    backgroundColor: Color.fromARGB(255, 50, 245, 160),
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
                        height: MediaQuery.of(context).size.height * .2,
                        width: MediaQuery.of(context).size.width * .4,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "32,4 km",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            Text("km parcourus")
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          children: [
                            buildTime(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text("Temp de course")
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}