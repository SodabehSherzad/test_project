class Home {

  //these variables are for home table
  int _id;
  String _body;

//Constructor
  Home(this._id, this._body);
//Gettters
  int get id => _id;
  String get body => _body;

// Extract a Product Object from a Map Object
  Home.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._body = map['body'];
  }


}