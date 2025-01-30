class StatusMessageCommonModel {
  bool? status;
  String? message;
  String? user_id;

  StatusMessageCommonModel({this.status, this.message});

  StatusMessageCommonModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user_id = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.user_id;
    return data;
  }
}
