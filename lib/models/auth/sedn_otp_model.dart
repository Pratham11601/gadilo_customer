class SendOtpModel {
  String? success;
  String? errorCode;
  String? message;
  String? id;

  SendOtpModel({this.success, this.errorCode, this.message, this.id});

  SendOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errorCode = json['error_code'];
    message = json['message'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['error_code'] = this.errorCode;
    data['message'] = this.message;
    data['id'] = this.id;
    return data;
  }
}
