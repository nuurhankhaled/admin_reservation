class ReceptionistModel {
  bool? success;
  List<Data>? data;

  ReceptionistModel({this.success, this.data});

  ReceptionistModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  String? name;
  String? phone;
  String? nid;
  String? type;
  String? email;
  String? password;
  String? status;

  Data(
      {this.id,
      this.name,
      this.phone,
      this.nid,
      this.type,
      this.email,
      this.password,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
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
