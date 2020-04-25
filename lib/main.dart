import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_android.dart';
import 'home_ios.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Theme.of(context).platform == TargetPlatform.android){
      print("Android");
      return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.red,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomeAndroid()
      );
    }
    else if(Theme.of(context).platform == TargetPlatform.iOS){
      print("IOS");
      return CupertinoApp(
          title: 'Flutter on iOS',
          theme: CupertinoThemeData(
            primaryColor: Colors.blue,
          ),
          home: HomeIOS()
      );
    }


  }
}

