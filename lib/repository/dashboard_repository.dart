import 'package:flutter/cupertino.dart';
import 'package:gadi_customer_repo/models/dasboard/bike_model.dart';
import 'package:gadi_customer_repo/models/dasboard/cars_model.dart';

import '../api/api_manager.dart';
import '../models/auth/brandModel.dart';
import '../models/dasboard/banerModel.dart';
import '../models/dasboard/homePageCityModel.dart';
import '../models/dasboard/spares_model.dart';

class DashboardRepository {
  DashboardRepository._();
  static APIManager apiManager = APIManager();

  static Future<bannerImagesModel> getBannerApi({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/banner_img',
        showLoading: showLoading,
      );
      bannerImagesModel getBanners = bannerImagesModel.fromJson(response);
      return getBanners;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

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

  static Future<CarsModel> getRandomFiveCarsApi({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_car_random',
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
        url: '/get_spare_parts_by_filter',
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

  static Future<Bikemodel> getRandomFiveBikesAPi({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_bike_random',
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
        url: '/get_bikes_by_filter',
        showLoading: showLoading,
      );
      Bikemodel bikeModel = Bikemodel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<homePageCityModel> getCityModel({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/city_name?city_name=${params}',
        showLoading: showLoading,
      );
      homePageCityModel bikeModel = homePageCityModel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<homePageCityModel> getdefaultCities({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_cities_homepage',
        showLoading: showLoading,
      );
      homePageCityModel getBanners = homePageCityModel.fromJson(response);
      return getBanners;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<brandNamesModel> getbrandModel({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/cars_by_brand?brand_name=${params}',
        showLoading: showLoading,
      );
      brandNamesModel bikeModel = brandNamesModel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<brandNamesModel> getDefaultbrandCarsModel({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_car_homepage',
        showLoading: showLoading,
      );
      brandNamesModel bikeModel = brandNamesModel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<brandNamesModel> getDefaultbrandBikeModel({bool showLoading = true}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_bike_homepage',
        showLoading: showLoading,
      );
      brandNamesModel bikeModel = brandNamesModel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static Future<brandNamesModel> getBikebrandModelbySearch({bool showLoading = true, required dynamic params}) async {
    try {
      var response = await apiManager.getAPICall(
        url: '/get_bike_brand?brand_name=${params}',
        showLoading: showLoading,
      );
      brandNamesModel bikeModel = brandNamesModel.fromJson(response);
      return bikeModel;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
