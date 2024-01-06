class ReservationsModel {
  bool? success;
  List<Data>? data;

  ReservationsModel({this.success, this.data});

  ReservationsModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? categoryName;
  String? itemId;
  String? time;
  String? timeOfReservation;
  String? additionalOptions;
  String? status;
  String? document;
  String? approveOfPayment;
  String? paid;
  Item? item;

  Data(
      {this.id,
      this.userId,
      this.categoryName,
      this.itemId,
      this.time,
      this.timeOfReservation,
      this.additionalOptions,
      this.status,
      this.document,
      this.approveOfPayment,
      this.paid,
      this.item});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryName = json['category_name'];
    itemId = json['item_id'];
    time = json['time'];
    timeOfReservation = json['time_of_reservation'];
    additionalOptions = json['additional_options'];
    status = json['status'];
    document = json['document'];
    approveOfPayment = json['approve_of_payment'];
    paid = json['paid'];
    item = json['item'] != null ? new Item.fromJson(json['item']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_name'] = categoryName;
    data['item_id'] = itemId;
    data['time'] = time;
    data['time_of_reservation'] = timeOfReservation;
    data['additional_options'] = additionalOptions;
    data['status'] = status;
    data['document'] = document;
    data['approve_of_payment'] = approveOfPayment;
    data['paid'] = paid;
    if (item != null) {
      data['item'] = item!.toJson();
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
  String? availableTimeFrom;
  String? availableTimeTo;
  String? status;
  String? offer;
  String? price;

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
      this.availableTimeFrom,
      this.availableTimeTo,
      this.status,
      this.offer,
      this.price});

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
    availableTimeFrom = json['available_time_from'];
    availableTimeTo = json['available_time_to'];
    status = json['status'];
    offer = json['offer'];
    price = json['price'];
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
    data['available_time_from'] = availableTimeFrom;
    data['available_time_to'] = availableTimeTo;
    data['status'] = status;
    data['offer'] = offer;
    data['price'] = price;
    return data;
  }
}
