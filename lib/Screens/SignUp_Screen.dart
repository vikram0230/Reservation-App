import 'package:flutter/material.dart';
import 'package:reservationapp/Screens/Home.dart';
import 'package:reservationapp/Screens/Login_Screen.dart';
import 'package:reservationapp/Utilities/DatabaseHelper.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String userName;
  String password;
  String confirmPassword;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 183, 212, 1),
          title: Text('SignUp'),
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
                  ),
                ),
                TextField(
                  onChanged: (value){
                    confirmPassword = value;
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: Colors.white,),
                    hintText: 'Confirm Password',
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
                RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: (){
                    DatabaseHelper database = DatabaseHelper();
                    if(password == confirmPassword && userName != null && password != null){
                      database.addOwner(userName, password);
                      Navigator.pushNamed(context, Home.id);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                    child: Text('Register',
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
                    Text('Already have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    FlatButton(
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                      child: Text('Login',
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
