import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/services/auth.dart';
import 'package:running_app/view/view_register.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late String _deviceName;


  @override
  void initState(){
    getDeviceName();
    super.initState();
  }


    void getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceName = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceName = iosInfo.utsname.machine;
      }
    } catch (e) {
      print(e);
    }
  }


  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
       child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              validator: (value) => value!.isEmpty ? 'please enter valid email' : null
            ),
            TextFormField(
                controller: _passwordController,
                validator: (value) => value!.isEmpty ? 'please enter valid password' : null
            ),
            SizedBox(height: 10,),
            FlatButton(
              minWidth: double.infinity,
              color: Colors.blue,
              child: Text('Login', style: TextStyle(color: Colors.white)),
              onPressed: (){
                Map creds = {
                  'email' : _emailController.text,
                  'password' : _passwordController.text,
                  'device_name' : _deviceName ?? 'unknown',
                };
                if(_formKey.currentState!.validate()){
                  Provider.of<Auth>(context, listen: false).login(creds: creds);
                  Navigator.pop(context);
                }
              },
            ),
            FlatButton(
              minWidth: double.infinity,
              color: Colors.blue,
              child: Text('Create account', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>RegisterView()));
              },
            )
          ],
        ),
      ),
    )
    );
  }
}
