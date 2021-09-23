import 'package:flutter/material.dart';
import 'package:test_project/components/bottom_navigation.dart';
import 'package:test_project/components/category.dart';
import 'package:test_project/components/top_navigation.dart';

import 'face_page.dart';
import 'hair_page.dart';
import 'nail_page.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {

    //For **does not work database to get data and show them here**, I used list to show data
    List<String> listName = [
      'Face',
      'Hair',
      'Nail'
    ];
    List<String> listIcon = ['face','hair','nail'];
    return Scaffold(
      appBar: appBar('Category'),
      body: SafeArea(
          child: category(listName, listIcon, openPage)
      ),
      bottomNavigationBar: bottomNavigation(_currentIndex, context, onTab),
    );
  }

  onTab(index){
    setState(() {_currentIndex = index;});
  }

  openPage(BuildContext context, int index) {
    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => FacePage(),));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HairPage(),));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => NailPage(),));
        break;
    }
  }

}
