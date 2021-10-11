import 'package:flutter/material.dart';

Widget category(listName, listIcon, openPage, List categories) {
  return GridView.builder(
    primary: false,
    scrollDirection: Axis.vertical,
    itemCount: listName.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
    ),
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          openPage(context, index, categories);
        },
        child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            shadowColor: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset('images/${listIcon[index]}.jpg'),
                ),
                Text(
                  '${listName[index]}',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            )),
      );
    },
  );
}