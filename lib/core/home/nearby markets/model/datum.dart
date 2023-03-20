import 'media.dart';
import 'tag.dart';

class Datum {
  int? id;
  String? address;
  String? latitude;
  String? longitude;
  dynamic phone;
  String? mobile;
  dynamic information;
  int? adminCommission;
  int? deliveryFee;
  int? deliveryRange;
  int? defaultTax;
  int? numTable;
  bool? closed;
  bool? active;
  bool? availableForDelivery;
  String? createdAt;
  String? updatedAt;
  int? timing;
  String? startingTime;
  String? closingTime;
  int? marketStatus;
  int? avgDeliveryTime;
  String? commercialId;
  String? taxNumber;
  int? isPickup;
  List<dynamic>? customFields;
  bool? hasMedia;
  int? rate;
  int? countRate;
  String? name;
  String? description;
  List<Tag>? tags;
  List<Media>? media;

  Datum({
    this.id,
    this.address,
    this.latitude,
    this.longitude,
    this.phone,
    this.mobile,
    this.information,
    this.adminCommission,
    this.deliveryFee,
    this.deliveryRange,
    this.defaultTax,
    this.numTable,
    this.closed,
    this.active,
    this.availableForDelivery,
    this.createdAt,
    this.updatedAt,
    this.timing,
    this.startingTime,
    this.closingTime,
    this.marketStatus,
    this.avgDeliveryTime,
    this.commercialId,
    this.taxNumber,
    this.isPickup,
    this.customFields,
    this.hasMedia,
    this.rate,
    this.countRate,
    this.name,
    this.description,
    this.tags,
    this.media,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        address: json['address'] as String?,
        latitude: json['latitude'] as String?,
        longitude: json['longitude'] as String?,
        phone: json['phone'] as dynamic,
        mobile: json['mobile'] as String?,
        information: json['information'] as dynamic,
        adminCommission: json['admin_commission'] as int?,
        deliveryFee: json['delivery_fee'] as int?,
        deliveryRange: json['delivery_range'] as int?,
        defaultTax: json['default_tax'] as int?,
        numTable: json['num_table'] as int?,
        closed: json['closed'] as bool?,
        active: json['active'] as bool?,
        availableForDelivery: json['available_for_delivery'] as bool?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        timing: json['timing'] as int?,
        startingTime: json['starting_time'] as String?,
        closingTime: json['closing_time'] as String?,
        marketStatus: json['market_status'] as int?,
        avgDeliveryTime: json['avg_delivery_time'] as int?,
        commercialId: json['commercial_id'] as String?,
        taxNumber: json['tax_number'] as String?,
        isPickup: json['is_pickup'] as int?,
        customFields: json['custom_fields'] as List<dynamic>?,
        hasMedia: json['has_media'] as bool?,
        rate: json['rate'] as int?,
        countRate: json['count_rate'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        tags: (json['tags'] as List<dynamic>?)
            ?.map((e) => Tag.fromJson(e as Map<String, dynamic>))
            .toList(),
        media: (json['media'] as List<dynamic>?)
            ?.map((e) => Media.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'phone': phone,
        'mobile': mobile,
        'information': information,
        'admin_commission': adminCommission,
        'delivery_fee': deliveryFee,
        'delivery_range': deliveryRange,
        'default_tax': defaultTax,
        'num_table': numTable,
        'closed': closed,
        'active': active,
        'available_for_delivery': availableForDelivery,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'timing': timing,
        'starting_time': startingTime,
        'closing_time': closingTime,
        'market_status': marketStatus,
        'avg_delivery_time': avgDeliveryTime,
        'commercial_id': commercialId,
        'tax_number': taxNumber,
        'is_pickup': isPickup,
        'custom_fields': customFields,
        'has_media': hasMedia,
        'rate': rate,
        'count_rate': countRate,
        'name': name,
        'description': description,
        'tags': tags?.map((e) => e.toJson()).toList(),
        'media': media?.map((e) => e.toJson()).toList(),
      };
}
