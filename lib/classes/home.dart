import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'package:test_project/localization/language_constants.dart';

class Home {
  int _id;
  String _body;

  Home(this._id, this._body);

  int get id => _id;
  String get body => _body;

  Home.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._body = map['body'];
  }
}

class HomeProvider with ChangeNotifier {
  List<Home> _homes = [];
  List<Home> get homes {
    return [..._homes];
  }

  // ***This method does not update data when change languages***
  Future<void> getHomeData(Database database, context) async {
    String query =
    (getTranslated(context, "language") == "fa")?
    "SELECT * FROM home_fa"
    : "SELECT * FROM home_en";

    var res = await database.rawQuery(query);
    Home model = res.isNotEmpty ? Home.fromMapObject(res.first) : null;
    _homes.add(model);
    notifyListeners();
  }
}