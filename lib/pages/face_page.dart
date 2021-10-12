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

    List<String> listName = subCates.map((item) => item.title).toList();
    List<String> listDetail = subCates.map((item) => item.detail).toList();
    List<String> listImage = subCates.map((item) => item.subCategoryImage).toList();

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
                    ? Container(child: Center(child: CircularProgressIndicator()))
                    : TabBarView(children: [
                        getDetail(0, listName, listImage, listDetail),
                        getDetail(1, listName, listImage, listDetail),
                        getDetail(2, listName, listImage, listDetail),
                        getDetail(3, listName, listImage, listDetail),
                      ])
            )));
  }

  Widget getDetail(int index, List listName, List listImage, List listDetail) {
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
            image: AssetImage("images/face/${listImage[index]}.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(listDetail[index]),
        ),
      ]),
    );
  }
}

