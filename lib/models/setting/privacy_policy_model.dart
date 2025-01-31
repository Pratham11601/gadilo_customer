class PrivacyPolicyModel {
  bool? status;
  int? errorCode;
  List<PrivacyPolicy>? privacyPolicy;

  PrivacyPolicyModel({this.status, this.errorCode, this.privacyPolicy});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error_code'];
    if (json['privacy_policy'] != null) {
      privacyPolicy = <PrivacyPolicy>[];
      json['privacy_policy'].forEach((v) {
        privacyPolicy!.add(new PrivacyPolicy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error_code'] = this.errorCode;
    if (this.privacyPolicy != null) {
      data['privacy_policy'] = this.privacyPolicy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrivacyPolicy {
  String? id;
  String? policyText;
  String? createdAt;

  PrivacyPolicy({this.id, this.policyText, this.createdAt});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    policyText = json['policy_text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['policy_text'] = this.policyText;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class termsModel {
  bool? status;
  List<TermsList>? data;

  termsModel({this.status, this.data});

  termsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TermsList>[];
      json['data'].forEach((v) {
        data!.add(new TermsList.fromJson(v));
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

class TermsList {
  String? content;
  String? updatedAt;

  TermsList({this.content, this.updatedAt});

  TermsList.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
