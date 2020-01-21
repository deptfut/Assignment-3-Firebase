import 'package:json_annotation/json_annotation.dart';
part 'Post.g.dart';

@JsonSerializable()
class Post {
  String postText;
  String image;

  Post(this.postText);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$PostToJson`.
  Map<String, dynamic> toJson() => _$PostToJson(this);

}
