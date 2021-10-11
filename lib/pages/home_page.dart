import 'package:carousel_pro/carousel_pro.dart';
import 'package:test_project/classes/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/classes/home.dart';
import '../classes/language.dart';
import '../localization/language_constants.dart';
import '../main.dart';
import '../components/bottom_navigation.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  //There I declare database to get Data from table
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
      Provider.of<HomeProvider>(context, listen: false)
          .getHomeData(dbHelper.database, context)
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
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
  @override
  Widget build(BuildContext context) {
    List<Home> data = Provider.of<HomeProvider>(context).homes;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade900,
        title: Text(getTranslated(context, 'home_page')),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: DropdownButton(
                underline: SizedBox(),
                icon: Icon(Icons.language, color: Colors.white),
                items: Language.languageList().map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                    value: lang,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(lang.name, style: TextStyle(fontSize: 20),),
                          Text(lang.flag),
                        ]
                    )
                )).toList(),
                onChanged: (Language language){
                  _changeLanguage(language);
                }
            ),
          )
        ],
      ),
      body: SafeArea(
          child: _isLoading
              ? Container(child: Center(child: CircularProgressIndicator()))
              : Column(
            children: [
              SizedBox(
                  height: 220,
                  width: double.infinity,
                  child: Carousel(
                      dotSize: 4,
                      dotSpacing: 15,
                      dotColor: Colors.lightGreenAccent,
                      indicatorBgPadding: 5,
                      dotBgColor: Colors.transparent,
                      boxFit: BoxFit.cover,
                      //** how I use for loop to have a dynamic slider for images **
                      // ------> Answer
                      // In the didChangedep method provide the categories
                      // then before the return() provide and filter
                      // categories to achive
                      // list of images then pass that list in HERE!
                      // like this ----> images: imagesList
                      images: [
                        AssetImage('images/slider/slider1.jpg'),
                        AssetImage('images/slider/slider3.jpg'),
                        AssetImage('images/slider/slider2.jpg'),
                      ])),
              Expanded(
                child: ListView(children: [
                  Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Column(children: [
                        Text(getTranslated(context, 'title'),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),

                        //**body** variable used here
                        Text(
                          // 'There is a Problem that does not show data $body from database',
                          // Answer: Here the body is brought from the Provider class.
                            data[0].body,
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ]))
                ]),
              ),
            ],
          )),
      bottomNavigationBar: bottomNavigation(_currentIndex, context, onTab),
    );
  }

  onTab(index) {
    setState(() {
      _currentIndex = index;
    });
  }
}