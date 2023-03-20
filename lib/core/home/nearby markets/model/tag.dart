import 'pivot.dart';

class Tag {
  String? name;
  Pivot? pivot;

  Tag({this.name, this.pivot});

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json['name'] as String?,
        pivot: json['pivot'] == null
            ? null
            : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'pivot': pivot?.toJson(),
      };
}
