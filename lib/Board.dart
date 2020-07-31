import 'package:assn/server_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'BoardWrite.dart';
import 'dart:developer';

class Post {
  int id;
  String title;
  String content;
  Post({this.id,this.title,this.content});
  String getContent() {
    String temp;
    temp = '  ';
    temp += content;
    if(content.length > 20) {
      temp = content.substring(0,20);
      temp+= '...';
    }
    return temp;
  }
}

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Post> post = <Post>[];
  @override
  Widget build(BuildContext context) {
    final TextEditingController _passController = new TextEditingController();
    final dio = Dio();
    final client = RestClient(dio);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 120,
            backgroundColor: Colors.redAccent,
            flexibleSpace: const FlexibleSpaceBar(
              title:Text("Posts"),
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.add_circle),
                    tooltip: 'Add new post',
                    onPressed: () {
                      _goBoardWrite(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh),
                    tooltip: 'Tap to refresh',
                    onPressed: () {
                      client.getTasks().then((value) {
                        post.clear();
                        value.forEach((x) {
                          Post p = Post(id:x.id,title:x.title,content:x.content);
                          post.add(p);
                        });
                      });
                      setState(() {
                        post = new List.from(post.reversed);
                      });
                    },
                  )
                ],
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context,int index) {
                return GestureDetector(
                  onLongPress: () {
                    print("long press");
                    log(post[post.length-index-1].id.toString());
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Modify or Delete",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          content: Container(
                            height: 200,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Password',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 15
                                  ),

                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: 240,
                                  height: 80,
                                  child:TextField(
                                    controller: _passController,
                                    style: TextStyle(fontSize: 13),
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      hintText: 'PW',
                                      labelText: 'PW',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                ButtonBar(
                                  alignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        DeleteFeed f = DeleteFeed(
                                          password: _passController.text
                                        );
                                        client.deleteTasks(post[post.length-index-1].id, f);
                                        _passController.clear();
                                        Navigator.pop(context);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.border_color),
                                      onPressed: () {
                                        DeleteFeed f = DeleteFeed(
                                            password: _passController.text
                                        );
                                        client.deleteTasks(post[post.length-index-1].id, f);
                                        _passController.clear();
                                        _goBoardWrite(context);
                                      },
                                    )
                                  ],
                                ),
                              ],
                            )
                          ),
                        );
                      }
                    );
                  },
                  onHorizontalDragEnd: (DragEndDetails details){
                    print(details);
                   // FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child:Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Image(
                          image: AssetImage('src/p.png'),
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5,right: 5),
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(bottom: 3),
                              child: Text(
                                '${post[index].title}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                '${post[index].getContent()}',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                );
              },
              childCount: post.length,
            ),
          )
        ],
      ),
    );
  }

  _goBoardWrite(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BoardWrite())
    );
  }
}
