import 'package:flutter/material.dart';
import 'package:test_project/components/bottom_navigation.dart';
import 'package:test_project/components/top_navigation.dart';
import 'package:test_project/localization/language_constants.dart';

class LinkPage extends StatefulWidget {
  LinkPage({Key key}) : super(key: key);

  @override
  _LinkPageState createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  int _currentIndex = 3;

  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: 'Book $index',
        expandedValue: 'Details for Book $index goes here',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Item> _books = generateItems(8);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green.shade900,
          title: Text(getTranslated(context, 'link_page')),
          centerTitle: true,
          ),
      body: SafeArea(
          child: ListView(
            children: [ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                //Not working to expand data of body
                setState(() {
                  _books[index].isExpanded = !_books[index].isExpanded;
                });
              },
                children: _books.map<ExpansionPanel>((Item item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded){
                      return ListTile(
                        title: Text(item.headerValue)
                      );
                    },
                    isExpanded: item.isExpanded,
                    body: ListTile(
                      title: Text(item.expandedValue)
                    ),
                  );
                }).toList(),
            ),
          ])
      ),
      bottomNavigationBar: bottomNavigation(_currentIndex, context, onTab),
    );
  }

  onTab(index){
    setState(() {_currentIndex = index;});
  }

}

class Item {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });
}