import 'package:flutter/material.dart';

import '../pages/home_page.dart';

Widget appBar(String title){
  return AppBar(
    backgroundColor: Colors.pink.shade900,
    title: Text(title),
    centerTitle: true,
  );
}