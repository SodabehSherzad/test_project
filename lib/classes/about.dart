import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class About {
  //these variables are for category table
  int _id;
  String _name, _body;

//Constructor
  About(this._id, this._name, this._body);

  int get id => _id;
  String get name => _name;
  String get body => _body;

  About.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._body = map['body'];
  }
}

class AboutPro with ChangeNotifier {
  List<About> _about;
  List<About> get about {
    return [..._about];
  }

  //for multi rows
  Future<void> getData(Database database) async {
    String query = "SELECT * FROM about_fa";
    var res = await database.rawQuery(query);
    List<About> list = res.isNotEmpty
        ? res.map((e) => About.fromMapObject(e)).toList()
        : [];
    _about = list;
    notifyListeners();
  }
}