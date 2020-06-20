import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp/Screens/Home.dart';
import 'package:reservationapp/Utilities/CustomTextField.dart';
import 'package:reservationapp/Utilities/DatabaseHelper.dart';
import 'package:reservationapp/Utilities/Reservation.dart';

class EditReservation extends StatefulWidget {
  static String id = 'edit';
  EditReservation({this.reservation});
  final Reservation reservation;
  @override
  _EditReservationState createState() => _EditReservationState();
}

class _EditReservationState extends State<EditReservation> {
  String _name;
  String _phoneNo;
  String _email;
  DateTime _reserveDate;
  DateTime _dob;
  DatabaseHelper database = DatabaseHelper();
  List<CustomTextField> textFields = [];
  DateTime usableDOB;
  DateTime usableDOR;
  var args;

  @override
  void initState() {
    super.initState();
//    args = ModalRoute.of(context).settings.arguments;
    textFields = [
      CustomTextField(labelText: 'Name',icon: Icon(Icons.person, color: Color.fromRGBO(0, 183, 212, 0.6),),caps: TextCapitalization.words,initialText: widget.reservation.name,),
      CustomTextField(labelText: 'Phone Number',icon: Icon(Icons.phone, color: Color.fromRGBO(0, 183, 212, 0.6),),inputType: TextInputType.phone, caps: TextCapitalization.none,initialText: widget.reservation.phoneNo,),
      CustomTextField(labelText: 'Email',icon: Icon(Icons.email, color: Color.fromRGBO(0, 183, 212, 0.6),),inputType: TextInputType.emailAddress, caps: TextCapitalization.none,initialText: widget.reservation.email,),
    ];
    String day1 = widget.reservation.dob.substring(0,widget.reservation.dob.indexOf('-'));
    String month1 = widget.reservation.dob.substring(widget.reservation.dob.indexOf('-')+1, widget.reservation.dob.lastIndexOf('-'));
    String year1 = widget.reservation.dob.substring(widget.reservation.dob.lastIndexOf('-')+1);
    if(day1.length == 1)
      day1 = '0' + day1;
    if(month1.length == 1)
      month1 = '0' + month1;
    usableDOB = DateTime.parse(year1 + month1 + day1);
    String day2 = widget.reservation.reserveDate.substring(0,widget.reservation.reserveDate.indexOf('-'));
    String month2 = widget.reservation.reserveDate.substring(widget.reservation.reserveDate.indexOf('-')+1, widget.reservation.reserveDate.lastIndexOf('-'));
    String year2 = widget.reservation.reserveDate.substring(widget.reservation.reserveDate.lastIndexOf('-')+1);
    if(day2.length == 1)
      day2 = '0' + day2;
    if(month2.length == 1)
      month2 = '0' + month2;
    usableDOR = DateTime.parse(year2 + month2 + day2);
  }

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
          title: Text('Edit Reservation'),
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
                            initialDateTime: usableDOB,
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
                            initialDateTime: usableDOR,
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 130),
                child: OutlineButton(
                  onPressed: (){
                    showDialog(context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Center(child: Text('Delete')),
                        content: Text('Do you really want to delete?'),
                        actions: <Widget>[
                          FlatButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                          FlatButton(
                            onPressed: (){
                              database.deleteReservation(widget.reservation.sno);
                              Navigator.popAndPushNamed(context, Home.id);
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      );
                    });
                  },
                  textColor: Colors.red,
                  child: Text('Delete'),
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
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
                      _name = textFields[0].valuePassed;
                      _phoneNo = textFields[1].valuePassed;
                      _email = textFields[2].valuePassed;
                      if(_name != null)
                        widget.reservation.name = _name;
                      if(_phoneNo != null)
                        widget.reservation.phoneNo = _phoneNo;
                      if(_email != null)
                        widget.reservation.email = _email;
                      if(_dob != null)
                        widget.reservation.dob = _dob.day.toString() + '-' + _dob.month.toString() + '-' + _dob.year.toString();
                      if(_reserveDate != null)
                        widget.reservation.reserveDate = _reserveDate.day.toString() + '-' + _reserveDate.month.toString() + '-' + _reserveDate.year.toString();
                      database.updateReservation(widget.reservation);
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
