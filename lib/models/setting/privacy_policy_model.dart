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
