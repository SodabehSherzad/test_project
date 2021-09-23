import 'package:flutter/material.dart';
import 'package:test_project/pages/category_page.dart';

import '../pages/about_page.dart';
import '../pages/home_page.dart';

Widget bottomNavigation(_currentIndex, context, onTab){
  return BottomNavigationBar(
    currentIndex: _currentIndex,

    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, color: Colors.pink.shade900,),
        title: Text('Home', style: TextStyle(color: Colors.pink.shade900,)),
        backgroundColor: Colors.pink.shade900,
        activeIcon: Icon(Icons.home, color: Colors.pink.shade900, size: 40,)
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.list_alt_outlined, color: Colors.pink.shade800,),
        title: Text('Category', style: TextStyle(color: Colors.pink.shade800,)),
          activeIcon: Icon(Icons.list_alt_outlined, color: Colors.pink.shade900, size: 40,)
      ),

      BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_rounded, color: Colors.pink.shade700,),
        title: Text('About', style: TextStyle(color: Colors.pink.shade700,)),
          activeIcon: Icon(Icons.people_alt_rounded, color: Colors.pink.shade900, size: 40,)
      ),
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
      }
    },
  );
}