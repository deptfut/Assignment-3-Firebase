import 'package:json_annotation/json_annotation.dart';
part 'Comment.g.dart';

@JsonSerializable()
class Comment {
  String commentsText;
  Comment(this.commentsText);

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

}