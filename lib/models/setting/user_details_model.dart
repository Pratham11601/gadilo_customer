class userDetails {
  String? status;
  String? message;
  UserDetails? data;

  userDetails({this.status, this.message, this.data});

  userDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new UserDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? id;
  String? profile;
  String? username;
  String? mobileNumber;
  String? email;
  String? mobileNo;
  String? emailId;
  String? subscriptionDate;
  String? endSubscriptionDate;
  String? createdAt;
  String? status;
  String? mobOtp;

  UserDetails(
      {this.id,
      this.profile,
      this.username,
      this.mobileNumber,
      this.email,
      this.mobileNo,
      this.emailId,
      this.subscriptionDate,
      this.endSubscriptionDate,
      this.createdAt,
      this.status,
      this.mobOtp});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profile = json['profile'];
    username = json['username'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    emailId = json['email_id'];
    subscriptionDate = json['subscription_date'];
    endSubscriptionDate = json['end_subscription_date'];
    createdAt = json['created_at'];
    status = json['status'];
    mobOtp = json['mob_otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile'] = this.profile;
    data['username'] = this.username;
    data['mobile_number'] = this.mobileNumber;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['email_id'] = this.emailId;
    data['subscription_date'] = this.subscriptionDate;
    data['end_subscription_date'] = this.endSubscriptionDate;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['mob_otp'] = this.mobOtp;
    return data;
  }
}
