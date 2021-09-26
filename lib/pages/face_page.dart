import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/classes/db_helper.dart';
import 'package:test_project/classes/sub_category.dart';
import 'package:test_project/pages/category_page.dart';

class FacePage extends StatefulWidget {
  final categoryId;
  FacePage(this.categoryId);

  @override
  _FacePageState createState() => _FacePageState();
}

class _FacePageState extends State<FacePage> {
  //For **does not work database to get data and show them here**, I used list to show data

  // List<String> listName = ['Eyebrow', 'Eyelash', 'Eyeliner', 'Lip'];
  String detail =
      '''Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add. You can also type a keyword to search online for the video that best fits your document.
  // To make your document look professionally produced, Word provides header, footer, cover page, and text box designs that complement each other. For example, you can add a matching cover page, header, and sidebar. Click Insert and then choose the elements you want from the different galleries.
  // ''';
  // List<String> listImage = ['eyebrow','eyelash','eyeliner','lip'];

  // Answer: I do the first one as a sample and then you do the rest of that.

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
      Provider.of<SubCatePro>(context, listen: false)
          .getSubCategories(dbHelper.database, widget.categoryId)
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
    final subCates = Provider.of<SubCatePro>(context).subCategories;
    List<String> listName0 = subCates.map((item) => item.title).toList();
    List<String> listImage =
        subCates.map((item) => item.subCategoryImage).toList();

    for (var i in listName0) {
      print(i);
      //listName0 has 12 items. it doesn't much to the UI.
      // please delete the repeated items from the database. this cause an error.
      // so currently I delete them here.
    }

    List<String> listName = [
      listName0[0],
      listName0[1],
      listName0[2],
      listName0[3],
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: listName.length,
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.pink.shade900,
                    title: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: InkWell(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CategoryPage()));
                            },
                          ),
                        ),
                        SizedBox(width: 100),
                        Text(
                          'Face',
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    centerTitle: true,
                    bottom: TabBar(
                        indicatorPadding: EdgeInsets.all(5),
                        isScrollable: true,
                        unselectedLabelColor: Colors.white,
                        indicatorColor: Colors.pink,
                        tabs: [
                          Tab(text: listName[0]),
                          Tab(text: listName[1]),
                          Tab(text: listName[2]),
                          Tab(text: listName[3]),
                        ])),
                body: _isLoading
                    ? Container(
                        child: Center(child: CircularProgressIndicator()))
                    : TabBarView(children: [
                        getDetail(0, listName, listImage),
                        getDetail(1, listName, listImage),
                        getDetail(2, listName, listImage),
                        getDetail(3, listName, listImage),
                      ]))));
  }

  Widget getDetail(int index, List listName, List listImage) {
    return InteractiveViewer(
      child: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(listName[index],
              style: TextStyle(fontSize: 22, color: Colors.pink)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage("images/face/" + listImage[index] + ".jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(detail,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
              )),
        ),
      ]),
    );
  }
}
