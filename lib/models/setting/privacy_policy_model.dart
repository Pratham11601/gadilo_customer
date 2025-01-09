/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) => PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) => json.encode(data.toJson());

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    required this.cities,
    required this.status,
  });

  List<PrivacyPolicy> cities;
  bool status;

  factory PrivacyPolicyModel.fromJson(Map<dynamic, dynamic> json) => PrivacyPolicyModel(
        cities: List<PrivacyPolicy>.from(json["cities"].map((x) => PrivacyPolicy.fromJson(x))),
        status: json["status"],
      );

  Map<dynamic, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
        "status": status,
      };
}

class PrivacyPolicy {
  PrivacyPolicy({
    required this.createdAt,
    required this.id,
    required this.policyText,
  });

  DateTime createdAt;
  String id;
  String policyText;

  factory PrivacyPolicy.fromJson(Map<dynamic, dynamic> json) => PrivacyPolicy(
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        policyText: json["policy_text"],
      );

  Map<dynamic, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "policy_text": policyText,
      };
}
