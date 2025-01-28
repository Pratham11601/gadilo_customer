class bannerImagesModel {
  String? status;
  List<baneerImages>? data;

  bannerImagesModel({this.status, this.data});

  bannerImagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <baneerImages>[];
      json['data'].forEach((v) {
        data!.add(new baneerImages.fromJson(v));
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

class baneerImages {
  String? bannerId;
  String? banImg;
  String? banTitle;
  String? banFor;
  String? createdAt;
  String? status;

  baneerImages({this.bannerId, this.banImg, this.banTitle, this.banFor, this.createdAt, this.status});

  baneerImages.fromJson(Map<String, dynamic> json) {
    bannerId = json['banner_id'];
    banImg = json['ban_img'];
    banTitle = json['ban_title'];
    banFor = json['ban_for'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerId;
    data['ban_img'] = this.banImg;
    data['ban_title'] = this.banTitle;
    data['ban_for'] = this.banFor;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    return data;
  }
}
