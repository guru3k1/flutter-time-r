import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskList extends StatefulWidget {
  final AsyncSnapshot snapshot;
  TaskList({Key key, @required this.snapshot}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState(snapshot);
}

class _TaskListState extends State<TaskList> {
  AsyncSnapshot snapshot;
  _TaskListState(this.snapshot);

  Map _taskMap;
  Map _rangeStarted;

  @override
  void initState() {
    _taskMap = new Map();
    _rangeStarted = new Map();
  }


  void _taskStatusManagment(int taskId){
    print(_taskMap[taskId]);
    if(!_taskMap.containsKey(taskId)){
      setState(() {
        _taskMap[taskId]= true;
      });
    }else{
      setState(() {
        _taskMap[taskId]= !_taskMap[taskId];
      });
    }
  }

  Future<http.Response> addRange(int taskId, int userId) async{
    var response=  await http.post(
      'http://192.168.0.12:8081/api/addRange',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{
        'userId': userId,
        'taskId': taskId
      }),
    );
    setState(() {
      _rangeStarted[taskId] = int.parse(response.body) ;
    });
    print(response.body);
    return response;
  }

  Future<http.Response> _closeRange(int rangeId) {
    if(rangeId != 0){
      return http.post(
        'http://192.168.0.12:8081/api/closeRange?rangeId=$rangeId',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'rangeId': rangeId
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index){
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                    leading: MaterialButton(
                      onPressed: () {
                        int taskId = snapshot.data[index]['taskId'];
                        _taskStatusManagment(taskId);
                        if(_taskMap[taskId]){
                          print("Closing Range");
                          _closeRange(_rangeStarted[taskId]);
                        }else{
                          print("Adding Range");
                          addRange(taskId,snapshot.data[index]['userId']);

                        }
                      },
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Icon(
                        _taskMap[snapshot.data[index]['taskId']] == true ? Icons.play_arrow: Icons.pause,
                        size: 40,
                      ),
                      padding: EdgeInsets.all(0),
                      shape: CircleBorder(),
                    ),
                    title: Text(snapshot.data[index]['name']),
                    subtitle: Text(snapshot.data[index]['description']),
                    trailing: Text(snapshot.data[index]['elapsedTime']??"0")
                )
              ],
            ),
          );
        });
  }

  void responseManager(String response) {
    print("response");
  }
}
