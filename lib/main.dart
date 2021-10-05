import 'package:chatrooms/UI/pickNamePage.dart';
import 'package:chatrooms/locator.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void main()async {
    await setUpLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Rooms',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.orange,
      ),
      navigatorKey: StackedService.navigatorKey,
      
      home: PickNamePage()
    );
  }
}

