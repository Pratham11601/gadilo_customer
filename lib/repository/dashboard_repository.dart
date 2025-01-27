import 'package:flutter/cupertino.dart';
import 'package:gadi_customer_repo/models/dasboard/bike_model.dart';
import 'package:gadi_customer_repo/models/dasboard/cars_model.dart';

import '../api/api_manager.dart';
import '../models/dasboard/spares_model.dart';

class DashboardRepository {
  DashboardRepository._();
  static APIManager apiManager = APIManager();

  static Future<CarsModel> getCarsApi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/get_cars_by_filter',
        params: params,
        showLoading: showLoading,
      );
      CarsModel getCarsModel = CarsModel.fromJson(response);
      return getCarsModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<CarsModel> getSearchForCarsApi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/search_car',
        params: params,
        showLoading: showLoading,
      );
      CarsModel getCarsModel = CarsModel.fromJson(response);
      return getCarsModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<CarsModel> getCarsSuggestionApi({
    bool showLoading = true,
  }) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_cars_by_filter',
        showLoading: showLoading,
      );
      CarsModel getCarsModel = CarsModel.fromJson(response);
      return getCarsModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Sparemodel> getSparesApi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/PageController/get_spare_parts_by_location',
        params: params,
        showLoading: showLoading,
      );
      Sparemodel getSpareModel = Sparemodel.fromJson(response);
      return getSpareModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Bikemodel> getBikesAPi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/get_bikes_by_filter',
        params: params,
        showLoading: showLoading,
      );
      Bikemodel bikeModel = Bikemodel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Bikemodel> getBikesSearchAPi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.postFormAPICall(
        url: '/get_bikes_by_filter',
        params: params,
        showLoading: showLoading,
      );
      Bikemodel bikeModel = Bikemodel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<Bikemodel> getBikesSuggestionsAPi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_bike_details1',
        showLoading: showLoading,
      );
      Bikemodel bikeModel = Bikemodel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
