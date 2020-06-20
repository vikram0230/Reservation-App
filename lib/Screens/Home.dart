import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reservationapp/Screens/Add_Reservation_Screen.dart';
import 'package:reservationapp/Utilities/DatabaseHelper.dart';
import 'package:loading_animations/loading_animations.dart';
import 'Edit_Screen.dart';

class Home extends StatefulWidget {
  static String id = 'home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper database = DatabaseHelper();
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
          title: Text('Home'),
        ),
        backgroundColor: Colors.grey[200],
        body: FutureBuilder(
          future: database.getReservation(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Center(
                child: LoadingBouncingGrid.circle(
                  size: 60,
                  duration: Duration(milliseconds: 500),
                  backgroundColor: Color.fromRGBO(0, 183, 212, 1),
                ),
              );
            }
            return ListView.builder(
              itemCount: reservationList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Container(
                    child: ListTile(
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditReservation(reservation: reservationList[index],),),),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Text(reservationList[index].name,
                                overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  width: size.width * 0.45,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.phone, size: 20,),
                                    Text(reservationList[index].phoneNo)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('DOB: ${reservationList[index].dob}',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.calendar_today, size: 14,),
                              SizedBox(width: 5,),
                              Text(reservationList[index].reserveDate,
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AddReservation.id),
          child: Icon(
            Icons.add,
            size: 30,
          ),
          backgroundColor: Color.fromRGBO(0, 183, 212, 1),
        ),
      ),
    );
  }
}
