import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream/widgets/VideosList.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff446699),
          title: Text(
            'Amazing Videos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: VideosList()
      ),
    );
  }
}
