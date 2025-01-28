class brandNamesModel {
  String? status;
  List<BrandNamesList>? data;

  brandNamesModel({this.status, this.data});

  brandNamesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BrandNamesList>[];
      json['data'].forEach((v) {
        data!.add(new BrandNamesList.fromJson(v));
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

class BrandNamesList {
  String? brandId;
  String? brandName;
  String? brandCountry;
  String? brandFounded;
  String? brandImg;
  String? createdAt;

  BrandNamesList({this.brandId, this.brandName, this.brandCountry, this.brandFounded, this.brandImg, this.createdAt});

  BrandNamesList.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandCountry = json['brand_country'];
    brandFounded = json['brand_founded'];
    brandImg = json['brand_img'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['brand_country'] = this.brandCountry;
    data['brand_founded'] = this.brandFounded;
    data['brand_img'] = this.brandImg;
    data['created_at'] = this.createdAt;
    return data;
  }
}
