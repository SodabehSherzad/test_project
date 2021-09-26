import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

class SubCategory {
  //These variables are for subCategory table

  int _subCategoryId, _foreign_categoryId;
  String _title, _subCategoryImage, _detail;

  SubCategory(this._subCategoryId, this._title, this._subCategoryImage,
      this._detail, this._foreign_categoryId);

  int get subCategoryId => _subCategoryId;
  String get title => _title;
  String get subCategoryImage => _subCategoryImage;
  String get detail => _detail;
  int get f_categoryId => _foreign_categoryId;

  SubCategory.fromMapObject(Map<String, dynamic> map) {
    this._subCategoryId = map['id'];
    this._title = map['title'];
    this._subCategoryImage = map['image'];
    this._detail = map['detail'];
    this._foreign_categoryId = map['category_id'];
  }
}

class SubCatePro with ChangeNotifier {
  List<SubCategory> _subCategories;
  List<SubCategory> get subCategories {
    return [..._subCategories];
  }

  Future<void> getSubCategories(Database database, int categId) async {
    String query =
        "SELECT * FROM subCategory, category where $categId == subCategory.category_id";
    var res = await database.rawQuery(query);
    List<SubCategory> list = res.isNotEmpty
        ? res.map((e) => SubCategory.fromMapObject(e)).toList()
        : [];
    _subCategories = list;
    notifyListeners();
  }
}
