import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/main.dart';
import 'package:running_app/services/auth.dart';
import 'package:running_app/view/view_mapping.dart';
import 'package:running_app/view/view_register.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController =
      TextEditingController(text: "raph.admin@gmail.com");
  TextEditingController _passwordController =
      TextEditingController(text: "password");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/run.jpg'), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red.shade500.withOpacity(0.8),
                Colors.blueGrey.shade900.withOpacity(0.8),
                Colors.black.withOpacity(0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  Text(
                    'Uberrun',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.15,
                        fontFamily: 'Poppins',
                        shadows: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.26,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: _emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'please enter valid email' : null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blueGrey.withOpacity(0.8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'Adresse mail',
                          hintStyle: TextStyle(color: Colors.white),
                          icon: Icon(Icons.mail_outline, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextFormField(
                      controller: _passwordController,
                      validator: (value) =>
                          value!.isEmpty ? 'please enter valid password' : null,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.blueGrey.withOpacity(0.8),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: 'Mot de passe',
                          hintStyle: TextStyle(color: Colors.white),
                          icon: Icon(Icons.lock_outline, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(231, 76, 60, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(2, 2),
                          blurRadius: 3,
                        )
                      ],
                    ),
                    child: Center(
                      child: FlatButton(
                        minWidth: double.infinity,
                        color: Color.fromRGBO(231, 76, 60, 1),
                        child: Text('CONNEXION',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        onPressed: () {
                          Map creds = {
                            'email': _emailController.text,
                            'password': _passwordController.text,
                          };
                          if (_formKey.currentState!.validate()) {
                            Provider.of<Auth>(context, listen: false)
                                .login(creds: creds);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => BottomNavBar()));
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03),
                    child: Center(
                      child: Text(
                        'Pas encore inscrit ? Créer un compte',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
