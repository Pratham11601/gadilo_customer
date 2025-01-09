class Sparemodel {
  String? status;
  List<SparesList>? data;

  Sparemodel({this.status, this.data});

  Sparemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <SparesList>[];
      json['data'].forEach((v) {
        data!.add(new SparesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SparesList {
  String? id;
  String? name;
  String? price;
  String? review;
  String? spareVersion;
  String? address;
  String? phoneNumber;
  String? locationName;
  List<String>? images;

  SparesList(
      {this.id, this.name, this.price, this.review, this.spareVersion, this.address, this.phoneNumber, this.locationName, this.images});

  SparesList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    review = json['review(stars)'];
    spareVersion = json['spare_version'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    locationName = json['location_name'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['review(stars)'] = this.review;
    data['spare_version'] = this.spareVersion;
    data['address'] = this.address;
    data['phone_number'] = this.phoneNumber;
    data['location_name'] = this.locationName;
    data['images'] = this.images;
    return data;
  }
}
