import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:running_app/services/auth.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmartionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }

  void dispose(){
    _emailController.dispose();
    _nameController.dispose();
    _passwordConfirmartionController.dispose();
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
              controller: _nameController,
              validator: (value) => value!.isEmpty ? 'please enter valid name' : null
            ),
            TextFormField(
                controller: _emailController,
                validator: (value) => value!.isEmpty ? 'please enter valid email' : null
            ),
            TextFormField(
                controller: _passwordController,
                validator: (value) => value!.isEmpty ? 'please enter valid password' : null
            ),
            TextFormField(
                controller: _passwordConfirmartionController,
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
                  'name' : _nameController.text,
                  'password' : _passwordController.text,
                  'password_confirmation' : _passwordConfirmartionController.text,
                };
                if(_formKey.currentState!.validate()){
                  Provider.of<Auth>(context, listen: false).register(creds: creds);
                  Navigator.pop(context);
                }
              },
            )
          ],
        ),
      ),
    )
    );
  }
}

class RegisterVIew {
}
