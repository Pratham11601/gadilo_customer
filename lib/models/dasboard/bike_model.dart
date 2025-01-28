class Bikemodel {
  bool? status;
  int? errorCode;
  List<BikeList>? data;

  Bikemodel({this.status, this.errorCode, this.data});

  Bikemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <BikeList>[];
      json['data'].forEach((v) {
        data!.add(new BikeList.fromJson(v));
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

class BikeList {
  String? bikeId;
  List<String>? bikeImage;
  String? bikePrice;
  String? city;
  String? brand;
  String? model;
  String? status;
  String? isAdvertised;
  String? contactNumber;
  String? kilometersDriven;
  String? fuelType;
  String? year;
  String? transmissionType;
  String? numberOfOwners;
  String? color;
  String? createdAt;
  String? id;
  String? view;
  String? ratings;
  String? feedbackMsg;
  String? shopAddress;

  BikeList(
      {this.bikeId,
      this.bikeImage,
      this.bikePrice,
      this.city,
      this.brand,
      this.model,
      this.status,
      this.isAdvertised,
      this.contactNumber,
      this.kilometersDriven,
      this.fuelType,
      this.year,
      this.transmissionType,
      this.numberOfOwners,
      this.color,
      this.createdAt,
      this.id,
      this.view,
      this.ratings,
      this.feedbackMsg,
      this.shopAddress});

  BikeList.fromJson(Map<String, dynamic> json) {
    bikeId = json['bike_id'];
    bikeImage = json['bike_image'].cast<String>();
    bikePrice = json['bike_price'];
    city = json['city'];
    brand = json['brand'];
    model = json['model'];
    status = json['status'];
    isAdvertised = json['is_advertised'];
    contactNumber = json['contact_number'];
    kilometersDriven = json['kilometers_driven'];
    fuelType = json['fuel_type'];
    year = json['year'];
    transmissionType = json['transmission_type'];
    numberOfOwners = json['number_of_owners'];
    color = json['color'];
    createdAt = json['created_at'];
    id = json['id'];
    view = json['view'];
    ratings = json['ratings'];
    feedbackMsg = json['feedback_msg'];
    shopAddress = json['shop_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bike_id'] = this.bikeId;
    data['bike_image'] = this.bikeImage;
    data['bike_price'] = this.bikePrice;
    data['city'] = this.city;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['status'] = this.status;
    data['is_advertised'] = this.isAdvertised;
    data['contact_number'] = this.contactNumber;
    data['kilometers_driven'] = this.kilometersDriven;
    data['fuel_type'] = this.fuelType;
    data['year'] = this.year;
    data['transmission_type'] = this.transmissionType;
    data['number_of_owners'] = this.numberOfOwners;
    data['color'] = this.color;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['view'] = this.view;
    data['ratings'] = this.ratings;
    data['feedback_msg'] = this.feedbackMsg;
    data['shop_address'] = this.shopAddress;
    return data;
  }
}
