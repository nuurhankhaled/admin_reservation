class AvailableTimeModel {
  bool? success;
  List<Data>? data;

  AvailableTimeModel({this.success, this.data});

  AvailableTimeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? itemId;
  String? availableTimeFrom;
  String? availableTimeTo;
  String? day;
  String? status;
  String? price;
  Item? item;
  Category? category;

  Data(
      {this.id,
      this.itemId,
      this.availableTimeFrom,
      this.availableTimeTo,
      this.day,
      this.status,
      this.price,
      this.item,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    availableTimeFrom = json['available_time_from'];
    availableTimeTo = json['available_time_to'];
    day = json['day'];
    status = json['status'];
    price = json['price'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    data['available_time_from'] = availableTimeFrom;
    data['available_time_to'] = availableTimeTo;
    data['day'] = day;
    data['status'] = status;
    data['price'] = price;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Item {
  String? id;
  String? categoryName;
  String? name;
  String? logo;
  String? image1;
  String? image2;
  String? image3;
  String? type;
  String? description;
  String? address;
  String? devices;
  String? status;
  String? offer;

  Item(
      {this.id,
      this.categoryName,
      this.name,
      this.logo,
      this.image1,
      this.image2,
      this.image3,
      this.type,
      this.description,
      this.address,
      this.devices,
      this.status,
      this.offer});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    name = json['name'];
    logo = json['logo'];
    image1 = json['image1'];
    image2 = json['image2'];
    image3 = json['image3'];
    type = json['type'];
    description = json['description'];
    address = json['address'];
    devices = json['devices'];
    status = json['status'];
    offer = json['offer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['name'] = name;
    data['logo'] = logo;
    data['image1'] = image1;
    data['image2'] = image2;
    data['image3'] = image3;
    data['type'] = type;
    data['description'] = description;
    data['address'] = address;
    data['devices'] = devices;
    data['status'] = status;
    data['offer'] = offer;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
