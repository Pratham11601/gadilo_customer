class Bikemodel {
  String? status;
  List<BikeList>? data;

  Bikemodel({this.status, this.data});

  Bikemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BikeList {
  String? id;
  String? color;
  String? mobileNumber;
  String? review;
  String? model;
  List<String>? image;
  String? kmDriven;
  String? transmission;
  String? year;
  String? price;
  String? fuelType;
  String? owners;
  String? location;
  String? brand;

  BikeList(
      {this.id,
      this.color,
      this.mobileNumber,
      this.review,
      this.price,
      this.model,
      this.image,
      this.kmDriven,
      this.transmission,
      this.year,
      this.fuelType,
      this.owners,
      this.location,
      this.brand});

  BikeList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    mobileNumber = json['mobile_number'];
    review = json['review'];
    model = json['model'];
    image = json['image'].cast<String>();
    kmDriven = json['km_driven'];
    transmission = json['transmission'];
    year = json['year'];
    fuelType = json['fuel_type'];
    price = json['price'];
    owners = json['owners'];
    location = json['location'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['color'] = this.color;
    data['mobile_number'] = this.mobileNumber;
    data['review'] = this.review;
    data['model'] = this.model;
    data['price'] = this.price;
    data['image'] = this.image;
    data['km_driven'] = this.kmDriven;
    data['transmission'] = this.transmission;
    data['year'] = this.year;
    data['fuel_type'] = this.fuelType;
    data['owners'] = this.owners;
    data['location'] = this.location;
    data['brand'] = this.brand;
    return data;
  }
}
