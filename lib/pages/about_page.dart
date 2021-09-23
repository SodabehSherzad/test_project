import 'package:flutter/material.dart';
import 'package:test_project/components/bottom_navigation.dart';
import 'package:test_project/components/top_navigation.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('About'),
      body: SafeArea(
          child: Container(child: Center(child: Text('About Page')))
      ),
      bottomNavigationBar: bottomNavigation(_currentIndex, context, onTab),
    );
  }

  onTab(index){
    setState(() {_currentIndex = index;});
  }

}
