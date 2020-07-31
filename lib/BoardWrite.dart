import 'package:assn/server_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'BData.dart';
import 'dart:developer';

class BoardWrite extends StatefulWidget {
  @override
  _BoardWriteState createState() => _BoardWriteState();
}

class _BoardWriteState extends State<BoardWrite> {
  String _title;
  String _content;
  String _password;
  bool _isSave;
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _contentController = new TextEditingController();
  final TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: _buildBoardWrite()
    );
  }

  void save(BuildContext context, RestClient client, bool isSave) {
    _title = _titleController.text;
    _content = _contentController.text;
    _password = _passController.text;
    _clearTF();
    CreateFeed feed = CreateFeed(
      title: _title,
      content: _content,
      password: _password,
    );
    if(isSave) {
      client.postTasks(feed);
    }
    Navigator.pop(context);
  }

  Widget _buildBoardWrite() {
    final dio = Dio();
    final client = RestClient(dio);
    return SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Container(
            color: Colors.redAccent,
            child: ButtonBar(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.share),
                  tooltip: 'upload',
                  onPressed: () {
                    save(context, client, true);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  tooltip: 'delete',
                  onPressed: () {
                    save(context, client, false);
                  },
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(bottom: 30),
            child: Divider(
              height: 0,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              'Title',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _titleController,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Text title',
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            height: 100,
          ),

          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              'Password',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _passController,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.start,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Post password',
                labelText: 'password',
                border: OutlineInputBorder(),
              ),
            ),
            height: 80,
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.topLeft,
            child: Text(
              'Content',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(12),
            child: TextField(
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              maxLines: 10,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: 'Text Content',
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
            ),
            height: 200,
          ),
          Container(
            height: 400,
          )
        ],
      ),
    );
  }
  void _clearTF() {
    _titleController.clear();
    _contentController.clear();
    _passController.clear();
  }
}
