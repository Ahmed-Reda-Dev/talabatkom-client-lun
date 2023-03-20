// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

import 'media.dart';

class Data {
  String? token;
  String? name;
  bool? hasMedia;
  List<Media>? media;

  Data({this.token, this.name, this.hasMedia, this.media});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json['token'] as String?,
        name: json['name'] as String?,
        hasMedia: json['has_media'] as bool?,
        media: (json['media'] as List<dynamic>?)
            ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'name': name,
        'has_media': hasMedia,
        'media': media?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      token.hashCode ^ name.hashCode ^ hasMedia.hashCode ^ media.hashCode;
}
