import 'package:flutter/material.dart';
import 'package:reservationapp/Screens/Login_Screen.dart';
import 'package:reservationapp/Screens/SignUp_Screen.dart';
import 'package:reservationapp/Screens/Home.dart';
import 'package:reservationapp/Screens/Add_Reservation_Screen.dart';
import 'package:reservationapp/Screens/Edit_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id : (context) => LoginScreen(),
        SignUpScreen.id : (context)  => SignUpScreen(),
        Home.id :  (context) => Home(),
        AddReservation.id : (context) => AddReservation(),
        EditReservation.id : (context) => EditReservation(),
      },
    );
  }
}
