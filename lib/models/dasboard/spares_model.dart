class Sparemodel {
  bool? status;
  int? errorCode;
  List<SparesList>? data;

  Sparemodel({this.status, this.errorCode, this.data});

  Sparemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error_code'];
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
    data['error_code'] = this.errorCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SparesList {
  String? sparePartId;
  List<String>? photo;
  String? price;
  String? city;
  String? brand;
  String? model;
  String? contactNumber;
  String? status;
  String? isAdvertised;
  String? description;
  String? createdAt;
  String? id;
  String? type;
  String? view;
  String? ratings;
  String? vehicleType;
  String? numberOfOwners;
  String? feedbackMsg;
  String? shopAddress;

  SparesList(
      {this.sparePartId,
      this.photo,
      this.price,
      this.city,
      this.brand,
      this.model,
      this.contactNumber,
      this.status,
      this.isAdvertised,
      this.description,
      this.createdAt,
      this.id,
      this.type,
      this.view,
      this.ratings,
      this.vehicleType,
      this.numberOfOwners,
      this.feedbackMsg,
      this.shopAddress});

  SparesList.fromJson(Map<String, dynamic> json) {
    sparePartId = json['spare_part_id'];
    photo = json['photo'].cast<String>();
    price = json['price'];
    city = json['city'];
    brand = json['brand'];
    model = json['model'];
    contactNumber = json['contact_number'];
    status = json['status'];
    isAdvertised = json['is_advertised'];
    description = json['description'];
    createdAt = json['created_at'];
    id = json['id'];
    type = json['type'];
    view = json['view'];
    ratings = json['ratings'];
    vehicleType = json['vehicle_type'];
    numberOfOwners = json['number_of_owners'];
    feedbackMsg = json['feedback_msg'];
    shopAddress = json['shop_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spare_part_id'] = this.sparePartId;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['city'] = this.city;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['contact_number'] = this.contactNumber;
    data['status'] = this.status;
    data['is_advertised'] = this.isAdvertised;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['type'] = this.type;
    data['view'] = this.view;
    data['ratings'] = this.ratings;
    data['vehicle_type'] = this.vehicleType;
    data['number_of_owners'] = this.numberOfOwners;
    data['feedback_msg'] = this.feedbackMsg;
    data['shop_address'] = this.shopAddress;
    return data;
  }
}
