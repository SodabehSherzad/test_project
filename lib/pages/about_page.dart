import 'package:test_project/components/bottom_navigation.dart';

import '../classes/about.dart';
import '../classes/db_helper.dart';
import '../localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatefulWidget {

  @override
  _AboutPage createState() => _AboutPage();
}

class _AboutPage extends State<AboutPage> {
  int _currentIndex = 2;

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
      Provider.of<AboutPro>(context, listen: false)
          .getData(dbHelper.database)
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

    List<About> data = Provider.of<AboutPro>(context).about;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        //Flutter Tabbar not support localization to data rtl/ltr***
        home: DefaultTabController(
            length: 1,
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.pink.shade900,
                    title: Text(getTranslated(context, 'about_page')),
                    centerTitle: true,
                    //create a bordertop or horizontaly line for bottom between tabbar and bottom
                    bottom: TabBar(
                        indicatorColor: Colors.transparent,
                        tabs: [
                          Tab(text: data[0].name, )
                        ]
                    )),
                body: _isLoading
                    ? Container(child: Center(child: CircularProgressIndicator()))
                    : TabBarView(children: [
                  InteractiveViewer(child: ListView(children: [Html(data: data[0].body)]))
                ]),
              bottomNavigationBar: bottomNavigation(_currentIndex, context, onTab),
            ),

        ),
    );
  }
  onTab(index){
    setState(() {_currentIndex = index;});
  }
}
