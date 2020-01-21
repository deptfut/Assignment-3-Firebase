// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['postText'] as String,
  )..image = json['image'] as String;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'postText': instance.postText,
      'image': instance.image,
    };
