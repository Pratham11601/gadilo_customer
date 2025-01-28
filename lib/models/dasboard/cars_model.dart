class CarsModel {
  bool? status;
  int? errorCode;
  List<CarsList>? data;

  CarsModel({this.status, this.errorCode, this.data});

  CarsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error_code'];
    if (json['data'] != null) {
      data = <CarsList>[];
      json['data'].forEach((v) {
        data!.add(new CarsList.fromJson(v));
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

class CarsList {
  String? carId;
  List<String>? carImage;
  String? carPrice;
  String? city;
  String? brand;
  String? model;
  String? status;
  String? shop_address;
  String? ratings;
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

  CarsList(
      {this.carId,
      this.carImage,
      this.carPrice,
      this.city,
      this.brand,
      this.model,
      this.status,
      this.shop_address,
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
      this.view});

  CarsList.fromJson(Map<String, dynamic> json) {
    carId = json['car_id'];
    carImage = json['car_image'].cast<String>();
    carPrice = json['car_price'];
    city = json['city'];
    brand = json['brand'];
    model = json['model'];
    status = json['status'];
    isAdvertised = json['is_advertised'];
    contactNumber = json['contact_number'];
    kilometersDriven = json['kilometers_driven'];
    ratings = json['ratings'];
    fuelType = json['fuel_type'];
    year = json['year'];
    transmissionType = json['transmission_type'];
    numberOfOwners = json['number_of_owners'];
    color = json['color'];
    createdAt = json['created_at'];
    shop_address = json['shop_address'];
    id = json['id'];
    view = json['view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_id'] = this.carId;
    data['car_image'] = this.carImage;
    data['car_price'] = this.carPrice;
    data['city'] = this.city;
    data['brand'] = this.brand;
    data['shop_address'] = this.shop_address;
    data['model'] = this.model;
    data['ratings'] = this.ratings;
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
    return data;
  }
}
