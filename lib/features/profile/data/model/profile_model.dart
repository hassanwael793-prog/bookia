
class ProfileResponse {
  Data? data;
  String? message;
  List<dynamic>? error;
  int? status;

  ProfileResponse({this.data, this.message, this.error, this.status});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : Data.fromJson(json["data"]);
    message = json["message"];
    error = json["error"] ?? [];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.toJson();
    }
    _data["message"] = message;
    if(error != null) {
      _data["error"] = error;
    }
    _data["status"] = status;
    return _data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? address;
  String? city;
  dynamic phone;
  bool? emailVerified;
  String? image;

  Data({this.id, this.name, this.email, this.address, this.city, this.phone, this.emailVerified, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    address = json["address"];
    city = json["city"];
    phone = json["phone"];
    emailVerified = json["email_verified"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["email"] = email;
    _data["address"] = address;
    _data["city"] = city;
    _data["phone"] = phone;
    _data["email_verified"] = emailVerified;
    _data["image"] = image;
    return _data;
  }
}
