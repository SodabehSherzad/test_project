import 'package:flutter/material.dart';
import 'package:test_project/pages/category_page.dart';
import 'package:test_project/localization/language_constants.dart';
import 'package:test_project/pages/link.dart';

import '../pages/about_page.dart';
import '../pages/home_page.dart';

Widget bottomNavigation(_currentIndex, context, onTab){
  return BottomNavigationBar(
    currentIndex: _currentIndex,

    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.pink.shade800,),
          title: Text(getTranslated(context, 'home_page'), style: TextStyle(color: Colors.pink.shade800,)),
          activeIcon: Icon(Icons.home, color: Colors.pink.shade900, size: 40,)
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.list_alt_outlined, color: Colors.pink.shade800,),
        title: Text(getTranslated(context, 'category_page'), style: TextStyle(color: Colors.pink.shade800,)),
          activeIcon: Icon(Icons.list_alt_outlined, color: Colors.pink.shade900, size: 40,)
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_rounded, color: Colors.pink.shade700,),
        title: Text(getTranslated(context, 'about_page'), style: TextStyle(color: Colors.pink.shade700,)),
          activeIcon: Icon(Icons.people_alt_rounded, color: Colors.pink.shade900, size: 40,)
      ),

      BottomNavigationBarItem(
          icon: Icon(Icons.link, color: Colors.pink.shade700,),
          title: Text(getTranslated(context, 'link_page'), style: TextStyle(color: Colors.pink.shade700,)),
          activeIcon: Icon(Icons.link, color: Colors.pink.shade900, size: 40,)
      )
    ],
    onTap: (index){
      onTab(index);
      switch(index){
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage()));
          break;
        case 2:
          Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
          break;
        case 3:
          Navigator.push(context, MaterialPageRoute(builder: (context) => LinkPage()));
          break;
      }
    },
  );
}