import 'package:flutter/cupertino.dart';
import 'package:gadi_customer_repo/generated/assets.dart';
import 'package:gadi_customer_repo/models/dasboard/bike_model.dart';
import 'package:gadi_customer_repo/models/dasboard/cars_model.dart';
import 'package:gadi_customer_repo/models/setting/user_details_model.dart';
import 'package:gadi_customer_repo/repository/setting_repositiory.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/utils/storage_config.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screen/onBoarding/SelectCity.dart';
import '../models/dasboard/spares_model.dart';
import '../models/dasboard/view_cars_model.dart';
import '../repository/dashboard_repository.dart';
import '../utils/app_colors.dart';
import '../utils/app_enums.dart';

class DashBoardController extends GetxController {
  RxList<CarsList> getCarsList = <CarsList>[].obs;
  RxList<CarsList> getCarsDealsList = <CarsList>[].obs;
  RxList<CarsList> getCarsSuggestionList = <CarsList>[].obs;
  RxList<BikeList> getBikeList = <BikeList>[].obs;
  RxList<BikeList> getBikeDealList = <BikeList>[].obs;
  RxList<BikeList> getBikeSuggestionList = <BikeList>[].obs;
  RxList<SparesList> getSparedList = <SparesList>[].obs;

  FilterOption? selectedFilterOption;
  RxBool isLoading = true.obs;
  RxInt selectedIndex = 0.obs;

  Rx<dynamic> id = 0.obs;
  Rx<TextEditingController> locationText = TextEditingController().obs;
  RxString location = ''.obs;

  RxString filterColor = ''.obs;
  RxString filterBrand = ''.obs;
  RxString selectedFuelType = ''.obs;
  RxString filterOwners = ''.obs;
  RxString filterBudget = ''.obs;
  Rx<Colour?> selectedColor = Rx<Colour?>(null);

  RxBool isCarFilterApplied = false.obs;
  RxBool isBikeFilterApplied = false.obs;

  RxBool isImageVisible = true.obs;
  RxBool isBikeImageVisible = true.obs;

  void setFilterBrand(String brand) {
    filterBrand.value = brand;
  }

  void setFilterColor(Colour color) {
    selectedColor.value = color;
    filterColor.value = color.backendValue;
  }

  void selectFuelType(String fuelType) {
    selectedFuelType.value = fuelType;
  }

  void selectBudget(String budget) {
    filterBudget.value = budget;
  }

  void selectOwner(String owner) {
    filterOwners.value = owner;
  }

  void clearFilters() {
    filterColor.value = "";
    selectedFuelType.value = '';
    filterOwners.value = '';
    filterBudget.value = '';
    update();
  }

  RxString UserName = 'Welcome Back'.obs;

  @override
  void onInit() async {
    super.onInit();
    location.value = await LocalStorage.fetchValue(StorageKey.userLocation) ?? 'null';
    id.value = await LocalStorage.fetchValue(StorageKey.userid);
    getUserDetails();

    getSpaeresListApi();

    getCarsListSuggestionApi();
    getCarsListApi();
    getCarsDealsListApi();

    getbikesListApi();
    getMoreListBikeThisAPi();
    getbikesDealsListApi();
  }

  Future<userDetails?> getUserDetails() async {
    Map<String, dynamic> params = {'id': id.value};
    debugPrint(params.toString());
    try {
      userDetails userResponse = await SettingRepositiory.getUserDeatils(params: params);
      if (userResponse.status == "success") {
        UserName.value = userResponse.data!.name!;
        return userResponse;
      } else {
        Get.snackbar(
          'Failed',
          userResponse.status.toString(),
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<CarsModel?> getCarsListApi() async {
    Map<String, dynamic> params = {
      'location': location.value,
      'brand': filterBrand.value,
      'color': filterColor.value,
      'km_driven': filterBudget.value,
      'search_filter': filterColor.value,
    };
    isLoading.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getCarsApi(params: params);
      if (getCarsApiresponse.status is String && getCarsApiresponse.status == "success" ||
          getCarsApiresponse.status is bool && getCarsApiresponse.status == true) {
        getCarsList.clear();
        getCarsList.value = getCarsApiresponse.data!;
      } else {
        getCarsList.clear();
        Get.snackbar(
          "no cars found",
          "Change filters or location",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<CarsModel?> getCarsDealsListApi() async {
    Map<String, dynamic> params = {
      'location': location.value,
      'brand': "",
      'color': "",
      'km_driven': "",
      'search_filter': "",
    };
    isLoading.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getCarsApi(params: params);
      if (getCarsApiresponse.status is String && getCarsApiresponse.status == "success" ||
          getCarsApiresponse.status is bool && getCarsApiresponse.status == true) {
        getCarsDealsList.clear();
        getCarsDealsList.value = getCarsApiresponse.data!;
      } else {
        getCarsDealsList.clear();
        Get.snackbar(
          "no cars found",
          "Change filters or location",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<CarsModel?> getCarsListSearchApi() async {
    Map<String, dynamic> params = {
      'location': location.value,
      'car_name': filterBrand.value,
    };
    getCarsList.clear();
    isLoading.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getSearchForCarsApi(params: params);
      if (getCarsApiresponse.status is String && getCarsApiresponse.status == "success" ||
          getCarsApiresponse.status is bool && getCarsApiresponse.status == true) {
        getCarsList.clear();
        getCarsList.value = getCarsApiresponse.data!;
      } else {
        getCarsList.clear();
        Get.snackbar(
          "no cars found",
          "Change filters or location",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<CarsModel?> getCarsListSuggestionApi() async {
    getCarsSuggestionList.clear();
    isLoading.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getCarsSuggestionApi();
      if (getCarsApiresponse.status is String && getCarsApiresponse.status == "success" ||
          getCarsApiresponse.status is bool && getCarsApiresponse.status == true) {
        getCarsSuggestionList.value = getCarsApiresponse.data!;
      } else {
        Get.snackbar(
          'Failed',
          "Something went wrong",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<Bikemodel?> getbikesDealsListApi() async {
    Map<String, dynamic> params = {
      'location': location.value,
      'brand': "",
      'color': "",
      'km_driven': "",
      'search_filter': "",
    };
    debugPrint(params.toString());

    isLoading.value = true;
    try {
      Bikemodel getBikeApiresponse = await DashboardRepository.getBikesAPi(params: params);

      if (getBikeApiresponse.status == "success") {
        if (getBikeApiresponse.data != null) {
          getBikeDealList.value = getBikeApiresponse.data!;
        }
      } else {
        Get.snackbar(
          'Failed',
          "Something went wrong",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getbikesListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<Bikemodel?> getbikesListApi() async {
    Map<String, dynamic> params = {
      'location': location.value,
      'brand': "",
      'color': "",
      'km_driven': "",
      'search_filter': "",
    };
    debugPrint(params.toString());

    isLoading.value = true;
    try {
      Bikemodel getBikeApiresponse = await DashboardRepository.getBikesAPi(params: params);

      if (getBikeApiresponse.status == "success") {
        if (getBikeApiresponse.data != null) {
          getBikeList.value = getBikeApiresponse.data!;
        }
      } else {
        Get.snackbar(
          'Failed',
          "Something went wrong",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getbikesListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<Bikemodel?> getMoreListBikeThisAPi() async {
    isLoading.value = true;
    try {
      Bikemodel getBikeApiresponse = await DashboardRepository.getBikesSuggestionsAPi(params: null);

      if (getBikeApiresponse.status == "success") {
        if (getBikeApiresponse.data != null) {
          getBikeSuggestionList.value = getBikeApiresponse.data!;
        }
      } else {
        Get.snackbar(
          'Failed',
          "Something went wrong",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in getbikesListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<Sparemodel?> getSpaeresListApi() async {
    Map<String, dynamic> params = {'location': location.value};
    isLoading.value = true;
    try {
      Sparemodel getSpareApiresponse = await DashboardRepository.getSparesApi(params: params);
      if (getSpareApiresponse.status == "success") {
        getSparedList.value = getSpareApiresponse.data!;
      } else {
        Get.snackbar(
          'Failed',
          "Something went wrong cant fetch Spares ",
          backgroundColor: ColorsForApp.alertColor,
        );
      }
    } catch (e) {
      debugPrint("Error in spare ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  void setSelectedFilterOption(FilterOption? option) {
    selectedFilterOption = option;

    debugPrint(selectedFilterOption.toString());

    update();
  }

  final List<VehicleBrandsModel> cars = [
    VehicleBrandsModel(CarBrand.Volvo, 'assets/yuyul.png'),
    VehicleBrandsModel(CarBrand.MG, 'assets/jjivvv.png'),
    VehicleBrandsModel(CarBrand.Hyundai, 'assets/gttg.png'),
    VehicleBrandsModel(CarBrand.Kia, 'assets/ftthj.png'),
    VehicleBrandsModel(CarBrand.Volkswagen, 'assets/kjhgd.png'),
    VehicleBrandsModel(CarBrand.Citroen, 'assets/lydc.png'),
    VehicleBrandsModel(CarBrand.Nissan, 'assets/jrfex.png'),
    VehicleBrandsModel(CarBrand.Mercedes, 'assets/yurex.png'),
    VehicleBrandsModel(CarBrand.BMW, 'assets/hfdfh.png'),
    VehicleBrandsModel(CarBrand.Audi, 'assets/gtddc.png'),
    VehicleBrandsModel(CarBrand.Mahindra, 'assets/jgxfxf.png'),
    VehicleBrandsModel(CarBrand.Tata, 'assets/ffdx.png'),
    VehicleBrandsModel(CarBrand.Lexus, 'assets/tssx.png'),
    VehicleBrandsModel(CarBrand.Renault, 'assets/igdzx.png'),
    VehicleBrandsModel(CarBrand.Jeep, 'assets/trwz.png'),
  ];

  final List<VehicleBrandsModel> bikeList = [
    VehicleBrandsModel(BikeBrand.OLA, Assets.bikeimagesOla),
    VehicleBrandsModel(BikeBrand.Ducati, Assets.bikeimagesDucatti),
    VehicleBrandsModel(BikeBrand.BAJAJ, Assets.bikeimagesBajaj),
    VehicleBrandsModel(BikeBrand.Suzuki, Assets.bikeimagesSuzuki),
    VehicleBrandsModel(BikeBrand.Vida, Assets.bikeimagesVidaa),
    VehicleBrandsModel(BikeBrand.BAJAJ, Assets.bikeimagesBajaj),
    VehicleBrandsModel(BikeBrand.KTM, Assets.bikeimagesKtm),
    VehicleBrandsModel(BikeBrand.Hero, Assets.bikeimagesHero),
    VehicleBrandsModel(BikeBrand.Keeway, Assets.bikeimagesKeeway),
    VehicleBrandsModel(BikeBrand.Ather, Assets.bikeimagesAther),
    VehicleBrandsModel(BikeBrand.Jawa, Assets.bikeimagesJawa),
    VehicleBrandsModel(BikeBrand.Revolt, Assets.bikeimagesRevolt),
    VehicleBrandsModel("Royal Enfield", Assets.bikeimagesRoyal),
    VehicleBrandsModel("Harley Davidson", Assets.bikeimagesHrlydavid)
  ];

  Future<void> saveLocation(String savedlocation) async {
    debugPrint("Location  Changed to   ${location.value} ");
    getCarsList.clear();
    getSparedList.clear();
    getBikeList.clear();
    await LocalStorage.storeValue(StorageKey.userLocation, savedlocation);
    location.value = await LocalStorage.fetchValue(StorageKey.userLocation) ?? '';
    Get.toNamed(Routes.HOME_SCREEN);
    await getbikesListApi();
    await getCarsListApi();
    await getSpaeresListApi();
  }

  final List<Item> itemList = [
    Item('assets/dcdp.png', "Pune"),
    Item('assets/ferv.png', "Mumbai"),
    Item('assets/jujnh.png', "Delhi"),
    Item('assets/kjmn.png', "Jaipur"),
    Item('assets/occ.png', "Bangalore"),
    Item('assets/oikjm.png', "Hyderabad"),
    Item('assets/zax.png', "Kolkata"),
    Item('assets/dedlj.png', "Chennai"),
    Item('assets/cdxs.png', "Noida"),
    Item('assets/sxsx.png', "Indore"),
    Item('assets/fczsx.png', "Lucknow"),
    Item('assets/kjhgfd.png', "Gurgaon"),
  ];

  final List<City> cities = City.values;
}
