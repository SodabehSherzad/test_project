import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:test_project/classes/db_helper.dart';
import 'package:test_project/components/bottom_navigation.dart';
import 'package:test_project/components/category.dart';
import 'package:test_project/components/top_navigation.dart';
import 'package:provider/provider.dart';

import 'face_page.dart';
import 'hair_page.dart';
import 'nail_page.dart';
import '../classes/category.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _currentIndex = 1;
  final dbHelper = DatabaseHelper();

  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await dbHelper.initDb();
      Provider.of<CategoryPro>(context, listen: false)
          .getCategories(dbHelper.database)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  void dispose() {
    dbHelper.closeDB();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final cates = Provider.of<CategoryPro>(context).categories;
    final List<String> listName = cates.map((item) => item.name).toList();
    final List<String> listIcon = cates.map((item) => item.image).toList();

    return Scaffold(
      appBar: appBar('Category'),
      body: SafeArea(
          child: _isLoading
              ? Container(child: Center(child: CircularProgressIndicator()))
              : category(listName, listIcon, openPage, cates)),
      bottomNavigationBar: bottomNavigation(_currentIndex, context, onTab),
    );
  }

  onTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }

  openPage(BuildContext context, int index, List<Category> categories) {
    var id =
        categories.firstWhere((element) => element.name == "Face").category_id;
    switch (index) {

      //**If share app information from social media in this way**
    // but does not work
      case 0:
        final RenderBox box = context.findRenderObject();
        final String text = "Make Up - Url Oof Makeup";
        Share.share(text, subject: 'Makeup', sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
        break;
      case 1:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HairPage(),
            ));
        break;
      case 2:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NailPage(),
            ));
        break;
      case 3:
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FacePage(id),
            ));
        break;
    }
  }
}
