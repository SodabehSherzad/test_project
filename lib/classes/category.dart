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