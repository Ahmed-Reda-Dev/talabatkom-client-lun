// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class GeneratedConversions {
  bool? thumb;
  bool? icon;

  GeneratedConversions({this.thumb, this.icon});

  factory GeneratedConversions.fromJson(Map<String, dynamic> json) {
    return GeneratedConversions(
      thumb: json['thumb'] as bool?,
      icon: json['icon'] as bool?,
    );
  }

  Map<String, dynamic> toJson() => {
        'thumb': thumb,
        'icon': icon,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GeneratedConversions) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => thumb.hashCode ^ icon.hashCode;
}
