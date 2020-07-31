
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

part 'server_api.g.dart';

@RestApi(baseUrl: 'http://binvitstudio.com/poapper/v1/tutorial/')
abstract class RestClient{
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/feeds")
  Future<void> postTasks(@Body() CreateFeed feed);
  @GET("/feeds")
  Future<List<Feed>> getTasks();
  @DELETE('/feeds/{id}')
  Future<void> deleteTasks(@Path() int id, @Body() DeleteFeed feed);
}

@JsonSerializable()
class Feed {
  int id;
  String title;
  String content;

  Feed({this.id, this.title, this.content});

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
  Map<String, dynamic> toJson() => _$FeedToJson(this);
}

@JsonSerializable()
class CreateFeed{
  String title;
  String content;
  String password;

  CreateFeed({this.title,this.content,this.password});

  factory CreateFeed.fromJson(Map<String,dynamic> json) => _$CreateFeedFromJson(json);
  Map<String,dynamic> toJson() => _$CreateFeedToJson(this);
}

@JsonSerializable()
class DeleteFeed{
  String password;

  DeleteFeed({this.password});

  factory DeleteFeed.fromJson(Map<String, dynamic> json) => _$DeleteFeedFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteFeedToJson(this);
}