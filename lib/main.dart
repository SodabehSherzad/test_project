import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './classes/category.dart';
import './classes/sub_category.dart';
import 'pages/home_page.dart';
import './pages/category_page.dart';
import './classes/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //I need to declare my database here for loading data from database
  // And use the variable of database to other pages

  //But Flutter does not have static variable and I do not know have to pass it to other pages

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => HomeProvider(), child: HomePage()),
        ChangeNotifierProvider(create: (_) => CategoryPro(), child: HomePage()),
        ChangeNotifierProvider(create: (_) => SubCatePro(), child: HomePage()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
