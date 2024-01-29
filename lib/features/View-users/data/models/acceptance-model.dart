class AcceptanceModel {
  bool? success;
  int? itemId;

  AcceptanceModel({this.success, this.itemId});

  AcceptanceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['item_id'] = itemId;
    return data;
  }
}
