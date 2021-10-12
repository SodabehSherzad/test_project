import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Category {
  //these variables are for category table
  int _category_id;
  String _name, _image;

//Constructor
  Category(this._category_id, this._name, this._image);

  int get category_id => _category_id;
  String get name => _name;
  String get image => _image;

  Category.fromMapObject(Map<String, dynamic> map) {
    this._category_id = map['id'];
    this._name = map['name'];
    this._image = map['image'];
  }
}

class CategoryPro with ChangeNotifier {
  List<Category> _categories;

  List<Category> get categories {
    return [..._categories];
  }

  //for multi rows
  Future<void> getCategories(Database database) async {
    String query = "SELECT * FROM category_fa";

    var res = await database.rawQuery(query);
    List<Category> list = res.isNotEmpty
        ? res.map((e) => Category.fromMapObject(e)).toList()
        : [];
    _categories = list;
    notifyListeners();
  }
}
