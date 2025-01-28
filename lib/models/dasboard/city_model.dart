class CityModel {
  String? status;
  List<CitySearchList>? data;

  CityModel({this.status, this.data});

  CityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <CitySearchList>[];
      json['data'].forEach((v) {
        data!.add(new CitySearchList.fromJson(v));
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

class CitySearchList {
  String? cityId;
  String? cityName;
  String? cityCountry;

  CitySearchList({this.cityId, this.cityName, this.cityCountry});

  CitySearchList.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    cityCountry = json['city_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['city_country'] = this.cityCountry;
    return data;
  }
}
