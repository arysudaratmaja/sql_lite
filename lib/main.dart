import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// change `flutter_database` to whatever your project name is
import 'database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF091D35),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 50,left: 10,right: 10),
              child:
              Image.asset('images/1.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35,bottom: 50),
              child: Text(
                'SQL Lite',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    height: 0,
                    color: Colors.white,
                    fontSize: 100,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Color(0xFFf15199),
                  child: Text(
                    'Insert',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _insert();
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                )),
            Container(
                margin: EdgeInsets.only(top:20, left: 30, right: 30),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Color(0xFFf15199),
                  child: Text(
                    'Query',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _query();
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                )),
            Container(
                margin: EdgeInsets.only(top:20, left: 30, right: 30),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Color(0xFFf15199),
                  child: Text(
                    'Update',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _update();
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                )),
            Container(
                margin: EdgeInsets.only(top:20, left: 30, right: 30),
                child: RaisedButton(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  color: Color(0xFFf15199),
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        height: 1,
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () {
                    _delete();
                  },
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                )),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: 'Bob',
      DatabaseHelper.columnAge: 23
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: 1,
      DatabaseHelper.columnName: 'Mary',
      DatabaseHelper.columnAge: 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
