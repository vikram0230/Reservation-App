import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp/Screens/Home.dart';
import 'package:reservationapp/Utilities/CustomTextField.dart';
import 'package:reservationapp/Utilities/DatabaseHelper.dart';
import 'package:reservationapp/Utilities/Reservation.dart';

class AddReservation extends StatefulWidget {
  static String id = 'add';
  @override
  _AddReservationState createState() => _AddReservationState();
}

class _AddReservationState extends State<AddReservation> {
  Reservation reservation = Reservation();
  DateTime _reserveDate;
  DateTime _dob;
  List<CustomTextField> textFields = [
    CustomTextField(labelText: 'Name',icon: Icon(Icons.person, color: Color.fromRGBO(0, 183, 212, 0.6),),caps: TextCapitalization.words,),
    CustomTextField(labelText: 'Phone Number',icon: Icon(Icons.phone, color: Color.fromRGBO(0, 183, 212, 0.6),),inputType: TextInputType.phone, caps: TextCapitalization.none,),
    CustomTextField(labelText: 'Email',icon: Icon(Icons.email, color: Color.fromRGBO(0, 183, 212, 0.6),),inputType: TextInputType.emailAddress, caps: TextCapitalization.none,),
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(0, 183, 212, 1),
          title: Text('Add Reservation'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: <Widget>[
              Column(
                children: textFields,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromRGBO(0, 183, 212, 1),),
                    borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('DOB',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 183, 212, 1),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.width*0.6,
                          height:100,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            maximumDate: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value){
                              _dob = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color.fromRGBO(0, 183, 212, 1),),
                      borderRadius: BorderRadius.all(Radius.circular(5))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Reservation Date',
                          style: TextStyle(
                            color: Color.fromRGBO(0, 183, 212, 1),
                            fontSize: 17,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: size.width*0.6,
                          height:100,
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now().add(Duration(days: 1)),
                            minimumDate: DateTime.now(),
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value){
                              _reserveDate = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: OutlineButton(
                    onPressed: (){
                      //TODO: Alert Dialog
                      Navigator.pop(context);
                    },
                    borderSide: BorderSide(color: Color.fromRGBO(0, 183, 212, 1),width: 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    textColor: Color.fromRGBO(0, 183, 212, 1),
                    child: Container(
                      child: Text('Cancel'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                  child: RaisedButton(
                    onPressed: (){
                      reservation.name = textFields[0].valuePassed;
                      reservation.phoneNo = textFields[1].valuePassed;
                      reservation.email = textFields[2].valuePassed;
                      reservation.dob = _dob.day.toString() + '-' + _dob.month.toString() + '-' + _dob.year.toString();
                      reservation.reserveDate = _reserveDate.day.toString() + '-' + _reserveDate.month.toString() + '-' + _reserveDate.year.toString();
                      DatabaseHelper database = DatabaseHelper();
                      database.addReservation(reservation);
                      Navigator.popAndPushNamed(context, Home.id);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                    textColor: Colors.white,
                    color: Color.fromRGBO(0, 183, 212, 1),
                    child: Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


