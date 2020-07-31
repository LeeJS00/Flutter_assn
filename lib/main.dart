import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'Board.dart';
import 'BData.dart';
import 'BoardWrite.dart';

/*
@RestApi(baseUrl: "https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/")
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
  @Get("/tasks")
  Future<List<Task>> getTasks();
}

@JsonSerializable()
class Task{
  String id;
  String name;
  String avatar;
  String createdAt;

  Task({this.id,this.name,this.avatar, this.createdAt});
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskFromJson(this);
}*/


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoardMain',
      theme: ThemeData(
          brightness: Brightness.dark,
          //primaryColor: Colors.black54,
          //accentColor: Colors.redAccent,
          fontFamily: 'Sans-serif',
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 35),
            bodyText1: TextStyle(fontSize: 20),
          )
      ),
      home: Board(),
    );
  }
}
