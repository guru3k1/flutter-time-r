import 'package:flutter/material.dart';
import 'list_future.dart';

class HomeAndroid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Time-R"),
        ),
        body: ListFuture()
      ),
    );
  }
}
