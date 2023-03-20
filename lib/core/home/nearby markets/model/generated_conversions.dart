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
}
