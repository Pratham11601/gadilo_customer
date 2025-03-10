class homePageCityModel {
  String? status;
  List<CityModel>? data;

  homePageCityModel({this.status, this.data});

  homePageCityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CityModel>[];
      json['data'].forEach((v) {
        data!.add(new CityModel.fromJson(v));
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

class CityModel {
  String? cityId;
  String? cityName;
  String? cityImg;
  String? cityCountry;

  CityModel({this.cityId, this.cityName, this.cityImg, this.cityCountry});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    cityImg = json['city_img'];
    cityCountry = json['city_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['city_img'] = this.cityImg;
    data['city_country'] = this.cityCountry;
    return data;
  }
}
