import 'custom_properties.dart';

class Media {
  int? id;
  String? modelType;
  int? modelId;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  int? size;
  List<dynamic>? manipulations;
  CustomProperties? customProperties;
  List<dynamic>? responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? url;
  String? thumb;
  String? icon;
  String? formatedSize;

  Media({
    this.id,
    this.modelType,
    this.modelId,
    this.collectionName,
    this.name,
    this.fileName,
    this.mimeType,
    this.disk,
    this.size,
    this.manipulations,
    this.customProperties,
    this.responsiveImages,
    this.orderColumn,
    this.createdAt,
    this.updatedAt,
    this.url,
    this.thumb,
    this.icon,
    this.formatedSize,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json['id'] as int?,
        modelType: json['model_type'] as String?,
        modelId: json['model_id'] as int?,
        collectionName: json['collection_name'] as String?,
        name: json['name'] as String?,
        fileName: json['file_name'] as String?,
        mimeType: json['mime_type'] as String?,
        disk: json['disk'] as String?,
        size: json['size'] as int?,
        manipulations: json['manipulations'] as List<dynamic>?,
        customProperties: json['custom_properties'] == null
            ? null
            : CustomProperties.fromJson(
                json['custom_properties'] as Map<String, dynamic>),
        responsiveImages: json['responsive_images'] as List<dynamic>?,
        orderColumn: json['order_column'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        url: json['url'] as String?,
        thumb: json['thumb'] as String?,
        icon: json['icon'] as String?,
        formatedSize: json['formated_size'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'model_type': modelType,
        'model_id': modelId,
        'collection_name': collectionName,
        'name': name,
        'file_name': fileName,
        'mime_type': mimeType,
        'disk': disk,
        'size': size,
        'manipulations': manipulations,
        'custom_properties': customProperties?.toJson(),
        'responsive_images': responsiveImages,
        'order_column': orderColumn,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'url': url,
        'thumb': thumb,
        'icon': icon,
        'formated_size': formatedSize,
      };
}
