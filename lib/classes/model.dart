class Model {

  int _id;
  String _body;

  int _category_id;
  String _name, _image;

//Constructor
  Model(this._id, this._body);
  Model.overloadConstructor(this._category_id, this._name, this._image);

//Gettters
  int get id => _id;
  String get body => _body;

  int get category_id => _category_id;
  String get name => _name;
  String get image => _image;

// Extract a Product Object from a Map Object
  Model.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._body = map['body'];
  }

  Model.toMapObject(Map<String, dynamic> map) {
    this._category_id = map['category_id'];
    this._name = map['name'];
    this._image = map['image'];
  }

}