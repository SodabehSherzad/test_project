import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:test_project/classes/about.dart';
import 'package:test_project/classes/category.dart';
import 'package:test_project/classes/sub_category.dart';
import 'package:test_project/pages/home_page.dart';

import 'classes/home.dart';
import 'localization/demo_localization.dart';
import 'localization/language_constants.dart';

import './classes/category.dart';
import './classes/sub_category.dart';
import 'pages/home_page.dart';
import './classes/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeProvider(), child: HomePage()),
          ChangeNotifierProvider(create: (_) => CategoryPro(), child: HomePage()),
          ChangeNotifierProvider(create: (_) => SubCatePro(), child: HomePage()),
          ChangeNotifierProvider(create: (_) => AboutPro(), child: HomePage()),
        ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: [
        Locale("en", "US"),
        Locale("fa", "IR")
      ],
      localizationsDelegates: [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: HomePage(),
    )
    );
  }
}
