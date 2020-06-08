import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  bool visible = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    setState(() {
      visible = true;
    });
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    var url = 'http://localhost/flu_app/register_user.php';
    var data = {'name': name, 'email': email, 'password': password};
    var response = await http.post(url, body: json.encode(data));
    var message = jsonDecode(response.body);

    if(response.statusCode == 200){
      setState(() {
        visible = false;
      });
    }
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('Enregistrement', style: TextStyle(fontSize: 21),),
              ),
              Divider(),
              Container(
                width: 280,
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: nameController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Entrez votre nom'),
                ),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: emailController,
                  autocorrect: true,
                  decoration: InputDecoration(hintText: 'Entrez votre email'),
                ),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: passwordController,
                  autocorrect: true,
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'Entrez votre mot de passe'),
                ),
              ),
              RaisedButton(
                onPressed: userRegistration,
                color: Colors.green,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: Text("S'incrire"),
              ),
              Visibility(
                visible: visible,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30),
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

