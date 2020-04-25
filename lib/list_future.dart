import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:timer/task_list.dart';

class ListFuture extends StatelessWidget {
  final String apiUrl = "http://192.168.0.12:8081/api/getTasks?userId=1";
  Stream _stream;

  Future<List<dynamic>> fetchTasks() async {
    var result = await http.get(apiUrl);
    return json.decode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<List<dynamic>>(
        future:fetchTasks(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
            print(snapshot.data[0]);
            return TaskList(snapshot: snapshot);
          }else{
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
    }
  
}
