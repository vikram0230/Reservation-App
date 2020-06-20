import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reservationapp/Utilities/Reservation.dart';

bool legitUser = false;
List<Reservation> reservationList = [];

class DatabaseHelper{
  DatabaseHelper();
  DatabaseHelper._privateConstructor();
  static final instance = DatabaseHelper._privateConstructor();
  String path;
  static final _dbName = "reservation_database.db";
  static final _dbVersion = 1;
  static final _reservationTableName = 'reservation';
  static final _loginTableName = 'login';

  static Database _database;
  Future<Database> get database async{
    if(_database!=null)  return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    path = join(documentsDirectory.path,_dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  FutureOr<void> _onCreate (Database db, int version){
    db.execute(
      '''
      CREATE TABLE $_reservationTableName(
      sno INTEGER PRIMARY KEY,
      name TEXT,
      phoneno TEXT,
      email TEXT,
      dob TEXT,
      reservedate TEXT)
      '''
    );
    db.execute(
    '''
    CREATE TABLE $_loginTableName(
    username TEXT,
    password TEXT)
    '''
    );
  }

  Future insert(Map<String,dynamic> row, String tableName) async{
    Database db = await instance.database;
    int index = await db.insert(tableName, row);
    print(index);
  }

  Future<int> update(Map<String, dynamic> row, ref) async{
    Database db = await instance.database;
    return await db.update(_reservationTableName, row, where: 'sno == ?', whereArgs: [ref]);
  }

  Future delete(reference, referenceArg, tableName) async{
    Database db = await instance.database;
    return await db.delete(tableName, where: '$reference == ?', whereArgs: [referenceArg]);
  }

  Future deleteLoginTable() async{
    Database db = await instance.database;
    return await db.execute('DROP TABLE $_loginTableName');
  }

  Future deleteReservationTable() async{
    Database db = await instance.database;
    return await db.execute('DROP TABLE $_reservationTableName');
  }

  Future isLegitUser(String userName, String password) async  {
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(_loginTableName);
    for(var i in data){
      if(i['username'] == userName && i['password'] == password)
        legitUser = true;
    }
  }

  Future getReservation() async{
    Database db = await instance.database;
    List<Map<String, dynamic>> data = await db.query(_reservationTableName);
    reservationList = [];
    for(var i in data){
      print(i);
      Reservation reservation = Reservation();
      reservation.sno = i['sno'];
      reservation.name = i['name'];
      reservation.phoneNo = i['phoneno'];
      reservation.email = i['email'];
      reservation.dob = i['dob'];
      reservation.reserveDate = i['reservedate'];
      reservationList.add(reservation);
    }
    return data;
  }

  Future addOwner(String userName, String password) async{
    await insert({
      'username' : userName,
      'password' : password
    }, _loginTableName);
  }
  
  Future addReservation(Reservation reservation) async{
    insert({
      'name' : reservation.name,
      'phoneno' : reservation.phoneNo,
      'email' : reservation.email,
      'dob' : reservation.dob,
      'reservedate' : reservation.reserveDate
    }, _reservationTableName);
  }

  Future updateReservation(Reservation reservation) async{
    await update({
      'name' : reservation.name,
      'phoneno' : reservation.phoneNo,
      'email' : reservation.email,
      'dob' : reservation.dob,
      'reservedate' : reservation.reserveDate
    }, reservation.sno);
  }

  Future deleteOwner(String username) async{
    await delete('username', username, _loginTableName);
  }

  Future deleteReservation(int sno) async{
    await delete('sno', sno, _reservationTableName);
  }
}