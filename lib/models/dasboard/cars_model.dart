class CarsModel {
  dynamic status;
  List<CarsList>? data;
  CarsModel({this.status, this.data});
  CarsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CarsList>[];
      json['data'].forEach((v) {
        data!.add(new CarsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status is bool ? status : status.toString();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CarsList {
  String? id;
  String? color;
  List<String>? image;
  String? reviewStars;
  String? phoneNumber;
  String? kmDriven;
  String? transmission;
  String? year;
  String? fuel;
  String? price;
  String? noOfOwners;
  String? location;
  String? brand;
  String? status;

  CarsList(
      {this.id,
      this.color,
      this.image,
      this.reviewStars,
      this.phoneNumber,
      this.kmDriven,
      this.transmission,
      this.year,
      this.price,
      this.fuel,
      this.noOfOwners,
      this.location,
      this.brand,
      this.status});

  CarsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    image = json['image'].cast<String>();
    reviewStars = json['review(stars)'];
    phoneNumber = json['phone_number'];
    kmDriven = json['km_driven'];
    transmission = json['transmission'];
    year = json['year'];
    fuel = json['fuel'];
    price = json['price'];
    noOfOwners = json['no_of_owners'];
    location = json['location'];
    brand = json['brand'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['image'] = this.image;
    data['review(stars)'] = this.reviewStars;
    data['phone_number'] = this.phoneNumber;
    data['km_driven'] = this.kmDriven;
    data['transmission'] = this.transmission;
    data['year'] = this.year;
    data['price'] = this.price;
    data['fuel'] = this.fuel;
    data['no_of_owners'] = this.noOfOwners;
    data['location'] = this.location;
    data['brand'] = this.brand;
    data['status'] = this.status;
    return data;
  }
}
