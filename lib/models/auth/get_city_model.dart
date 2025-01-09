class GetCityModel {
  bool? status;
  List<Cities>? cities;

  GetCityModel({this.status, this.cities});

  GetCityModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  String? id;
  String? cityName;
  String? isPopular;

  Cities({this.id, this.cityName, this.isPopular});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cityName = json['city_name'];
    isPopular = json['is_popular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['city_name'] = this.cityName;
    data['is_popular'] = this.isPopular;
    return data;
  }
}
