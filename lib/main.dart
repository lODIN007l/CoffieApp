import 'package:coffie_app/views/coffe_home.dart';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Theme(data: ThemeData.light(), child: HomeCoffe()));
  }
}
