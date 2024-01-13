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
  String? timeOfReservationFrom;
  String? timeOfReservationTo;
  String? additionalOptions;
  String? status;
  String? document;
  String? approveOfPayment;
  String? price;
  String? paid;
  Item? item;
  User? user;

  Data(
      {this.id,
      this.userId,
      this.categoryName,
      this.itemId,
      this.time,
      this.timeOfReservationFrom,
      this.timeOfReservationTo,
      this.additionalOptions,
      this.status,
      this.document,
      this.approveOfPayment,
      this.price,
      this.paid,
      this.item,
      this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryName = json['category_name'];
    itemId = json['item_id'];
    time = json['time'];
    timeOfReservationFrom = json['time_of_reservation_from'];
    timeOfReservationTo = json['time_of_reservation_to'];
    additionalOptions = json['additional_options'];
    status = json['status'];
    document = json['document'];
    approveOfPayment = json['approve_of_payment'];
    price = json['price'];
    paid = json['paid'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_name'] = categoryName;
    data['item_id'] = itemId;
    data['time'] = time;
    data['time_of_reservation_from'] = timeOfReservationFrom;
    data['time_of_reservation_to'] = timeOfReservationTo;
    data['additional_options'] = additionalOptions;
    data['status'] = status;
    data['document'] = document;
    data['approve_of_payment'] = approveOfPayment;
    data['price'] = price;
    data['paid'] = paid;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
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
  String? devices;
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
      this.devices,
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
    devices = json['devices'];
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
    data['devices'] = devices;
    data['status'] = status;
    data['offer'] = offer;
    data['price'] = price;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? phone;
  String? nid;
  String? type;
  String? email;
  String? password;
  String? status;

  User(
      {this.id,
      this.name,
      this.phone,
      this.nid,
      this.type,
      this.email,
      this.password,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    nid = json['nid'];
    type = json['type'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['nid'] = nid;
    data['type'] = type;
    data['email'] = email;
    data['password'] = password;
    data['status'] = status;
    return data;
  }
}
