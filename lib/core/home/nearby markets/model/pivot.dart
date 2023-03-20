class Pivot {
  int? marketId;
  int? fieldId;

  Pivot({this.marketId, this.fieldId});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        marketId: json['market_id'] as int?,
        fieldId: json['field_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'market_id': marketId,
        'field_id': fieldId,
      };
}
