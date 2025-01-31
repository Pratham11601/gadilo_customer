import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gadi_customer_repo/models/setting/privacy_policy_model.dart';
import 'package:gadi_customer_repo/models/setting/status_string_response_model.dart';

import '../api/api_manager.dart';
import '../models/setting/user_details_model.dart';

class SettingRepositiory {
  SettingRepositiory._();
  static APIManager apiManager = APIManager();

  static Future<StatusStringResponseModel> contactSupportApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/contact_support',
        params: params,
        showLoading: showLoading,
      );
      StatusStringResponseModel messageCommonModel = StatusStringResponseModel.fromJson(response);
      return messageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<StatusStringResponseModel> FeedbackApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/give_feedback',
        params: params,
        showLoading: showLoading,
      );
      StatusStringResponseModel messageCommonModel = StatusStringResponseModel.fromJson(response);
      return messageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<StatusStringResponseModel> ratingApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/rate_us',
        params: params,
        showLoading: showLoading,
      );
      StatusStringResponseModel messageCommonModel = StatusStringResponseModel.fromJson(response);
      return messageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<userDetails> getUserDeatils({required dynamic id, bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: 'get_user_by_i?user_id=$id',
        showLoading: showLoading,
      );
      userDetails userModel = userDetails.fromJson(response);
      return userModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<userDetails> updateUserDetailsAPi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/update_user_profile',
        params: params,
        showLoading: showLoading,
      );
      userDetails userModel = userDetails.fromJson(response);
      return userModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<StatusStringResponseModel> changePasswordApi({required dynamic params, bool showLoading = true}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/change_password',
        params: params,
        showLoading: showLoading,
      );
      StatusStringResponseModel messageCommonModel = StatusStringResponseModel.fromJson(response);
      return messageCommonModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<PrivacyPolicyModel> privacyPolicyApi({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_privacy_policy',
        showLoading: showLoading,
      );
      PrivacyPolicyModel privacyModel = PrivacyPolicyModel.fromJson(response);
      return privacyModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<termsModel> termsCondnApi({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/getTermsConditions',
        showLoading: showLoading,
      );
      termsModel privacyModel = termsModel.fromJson(response);
      return privacyModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
