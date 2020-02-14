import 'package:flutter/material.dart';
import 'views/home_page.dart';
import 'shared/theme.dart';
import 'views/details_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: basicTheme(),
      home: HomePage(),
      routes: {
        '/details': (context) => DetailsPage(),
      },
    );
  }
}

