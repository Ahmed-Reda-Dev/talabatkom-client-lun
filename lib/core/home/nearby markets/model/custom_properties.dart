import 'generated_conversions.dart';

class CustomProperties {
  String? uuid;
  int? userId;
  GeneratedConversions? generatedConversions;

  CustomProperties({this.uuid, this.userId, this.generatedConversions});

  factory CustomProperties.fromJson(Map<String, dynamic> json) {
    return CustomProperties(
      uuid: json['uuid'] as String?,
      userId: json['user_id'] as int?,
      generatedConversions: json['generated_conversions'] == null
          ? null
          : GeneratedConversions.fromJson(
              json['generated_conversions'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'user_id': userId,
        'generated_conversions': generatedConversions?.toJson(),
      };
}
