import 'package:flutter/material.dart';
import 'category_page.dart';

class NailPage extends StatefulWidget {
  NailPage({Key key}) : super(key: key);

  @override
  _NailPageState createState() => _NailPageState();
}

class _NailPageState extends State<NailPage> {

  List<String> listName = ['Hand Nail'];
  String detail = '''Video provides a powerful way to help you prove your point. When you click Online Video, you can paste in the embed code for the video you want to add. You can also type a keyword to search online for the video that best fits your document.
  To make your document look professionally produced, Word provides header, footer, cover page, and text box designs that complement each other. For example, you can add a matching cover page, header, and sidebar. Click Insert and then choose the elements you want from the different galleries.
  ''';
  List<String> listImage = ['hand'];

  @override
  Widget build(BuildContext context) {
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
                            child: Icon(Icons.arrow_back, color: Colors.white,),
                            onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage()));},
                          ),
                        ),
                        SizedBox(width: 100),
                        Text('Face', textAlign: TextAlign.center,)
                      ],
                    ),
                    centerTitle: true,
                    //** Here between top and bottom *I like to have a line or bordertop**
                    bottom: TabBar(
                        indicatorPadding: EdgeInsets.all(5),
                        isScrollable: true,
                        unselectedLabelColor: Colors.white,
                        indicatorColor: Colors.pink,
                        tabs: [
                          Tab(text: listName[0]),
                        ]
                    )),
                body: TabBarView(children: [
                  getDetail(0),
                ])
            )
        )
    );
  }

  Widget getDetail(int index){
    return InteractiveViewer(
      child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(listName[index], style: TextStyle(
                  fontSize: 22,
                  color: Colors.pink
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(image: AssetImage("images/nail/"+listImage[index]+".jpg"), fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(detail, textAlign: TextAlign.justify, style: TextStyle(
                fontSize: 18,
              )),
            ),
          ]
      ),
    );
  }
}

