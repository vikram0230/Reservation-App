import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp/Screens/Home.dart';
import 'package:reservationapp/Screens/SignUp_Screen.dart';
import 'package:reservationapp/Utilities/DatabaseHelper.dart';

class LoginScreen extends StatefulWidget {
  static String id = '/';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userName;
  String password;
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 183, 212, 1),
          title: Text('Login'),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(25),
            height: size.height * 0.4,
            width: size.width *  0.8,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 183, 212, 1),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextField(
                  onChanged: (value){
                    userName = value;
                  },
                  controller: _userNameController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: Colors.white,),
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.white60,),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                TextField(
                  onChanged: (value){
                    password = value;
                  },
                  controller: _passwordController,
                  cursorColor: Colors.white,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white,),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.white60,),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
//                    errorText: 'Error',
                  ),
                ),
                RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () async{
                    DatabaseHelper database = DatabaseHelper();
                    legitUser = false;
                    await database.isLegitUser(userName, password);
                    if(legitUser){
//                      _userNameController.clear();
//                      _passwordController.clear();
                      legitUser = false;
                      setState(() {
                        print('Reloaded');
                      });
                      Navigator.pushNamed(context, Home.id);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    child: Text('Login',
                      style: TextStyle(color: Color.fromRGBO(0, 183, 212, 1)),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3),),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Don\'t have an account?',
                    style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpScreen())),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Text('Signup',
                        style:
                        TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
