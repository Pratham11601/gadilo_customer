import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gadi_customer_repo/generated/assets.dart';
import 'package:gadi_customer_repo/models/dasboard/bike_model.dart';
import 'package:gadi_customer_repo/models/dasboard/cars_model.dart';
import 'package:gadi_customer_repo/models/setting/user_details_model.dart';
import 'package:gadi_customer_repo/repository/setting_repositiory.dart';
import 'package:gadi_customer_repo/routes/routes.dart';
import 'package:gadi_customer_repo/utils/storage_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../models/auth/brandModel.dart';
import '../models/auth/get_city_model.dart';
import '../models/dasboard/banerModel.dart';
import '../models/dasboard/homePageCityModel.dart';
import '../models/dasboard/spares_model.dart';
import '../models/dasboard/view_cars_model.dart';
import '../repository/dashboard_repository.dart';
import '../utils/app_colors.dart';
import '../utils/app_enums.dart';
import '../widgets/snack_abar.dart';

class DashBoardController extends GetxController {
  RxList<CarsList> getCarsList = <CarsList>[].obs;
  RxList<CarsList> getCarsByBrandList = <CarsList>[].obs;
  RxList<CarsList> getCarsSuggestionList = <CarsList>[].obs;
  RxList<CarsList> getCarsRandomList = <CarsList>[].obs;

  RxList<baneerImages> getBannerImg = <baneerImages>[].obs;

  RxList<BikeList> getBikeList = <BikeList>[].obs;
  RxList<BikeList> getBikesRandom = <BikeList>[].obs;

  RxList<BikeList> getBikeByBrandList = <BikeList>[].obs;
  RxList<BikeList> getBikeSuggestionList = <BikeList>[].obs;

  FilterOption? selectedFilterOption;
  RxBool isLoading = true.obs;

  RxBool isLoadingRandom = true.obs;

  RxBool isLoadingInBikes = true.obs;
  RxBool isLoadingInSpares = true.obs;
  RxBool isLoadingInCas = true.obs;
  RxBool isloadingLocation = false.obs;
  RxInt selectedIndex = 0.obs;

  Rx<dynamic> id = "0".obs;
  Rx<TextEditingController> locationText = TextEditingController().obs;
  Rx<TextEditingController> searchText = TextEditingController().obs;
  var searchList = <String>[].obs;
  RxString location = ''.obs;

  void clearFilters() {
    filterColor.value = "";
    selectedFuelType.value = '';
    filterOwners.value = '';
    filterBudget.value = '';
    VehicleType.value = '';
    VehicleType.value = '';
    spareType.value = '';
    update();
  }

  RxString filterColor = ''.obs;
  RxString filterBrand = ''.obs;
  RxString selectedFuelType = ''.obs;
  RxString filterOwners = ''.obs;
  RxString filterBudget = ''.obs;

  final RxString VehicleType = "".obs;
  final RxString spareType = "".obs;

  Rx<Colour?> selectedColor = Rx<Colour?>(null);

  RxBool isCarFilterApplied = false.obs;
  RxBool isBikeFilterApplied = false.obs;
  RxBool isSparesFilterApplied = false.obs;

  RxBool isImageVisible = true.obs;
  RxBool isBikeImageVisible = true.obs;

  var minValue = 0.0.obs;
  var maxValue = 10000000.0.obs;

  var cityList = <Cities>[].obs;

  RxList<SparesList> getSparedList = <SparesList>[].obs;
  Future<Sparemodel?> getSpaeresListApi() async {
    Map<String, dynamic> params = {
      'city': location.value,
      'vehicle_type': VehicleType.value,
      'number_of_owners': filterOwners.value,
      'type': spareType.value,
    };
    isLoadingInSpares.value = true;
    try {
      Sparemodel getSpareApiresponse = await DashboardRepository.getSparesApi(params: params);
      isLoadingInSpares.value = false;

      if (getSpareApiresponse.status == true) {
        getSparedList.value = getSpareApiresponse.data!;
      } else {}
    } catch (e) {
      debugPrint("Error in spare ${e.toString()}");
    } finally {
      isLoadingInSpares.value = false;
    }
    return null;
  }

  Future<CarsModel?> getCarsDealsListApi() async {
    Map<String, dynamic> params = {
      'city': location.value,
      'brand': filterBrand.value,
      'color': filterColor.value,
      'fuel_type': selectedFuelType.value,
      'min_budget': minValue.value,
      'max_budget': maxValue.value,
      'number_of_owners': filterOwners.value,
    };
    isLoadingInCas.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getCarsApi(params: params);
      isLoadingInCas.value = false;
      if (getCarsApiresponse.status == true) {
        getCarsByBrandList.clear();
        getCarsByBrandList.value = getCarsApiresponse.data!;
      } else {
        getCarsByBrandList.clear();
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoadingInCas.value = false;
    }
    return null;
  }

  Future<CarsModel?> getRandomFiveCars() async {
    isLoadingRandom.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getRandomFiveCarsApi();
      isLoadingRandom.value = false;
      if (getCarsApiresponse.status == "true" || getCarsApiresponse.status == true) {
        getCarsRandomList.value = getCarsApiresponse.data!;
        debugPrint(getCarsRandomList.value.toString());
      } else {}
    } catch (e) {
      debugPrint("Error in random Cars ${e.toString()}");
    } finally {
      isLoadingRandom.value = false;
    }
    return null;
  }

  @override
  void onInit() async {
    super.onInit();
    getDefaultCities();
    getBanners();
    clearFilters();

    location.value = await LocalStorage.fetchValue(StorageKey.userLocation);
    id.value = await LocalStorage.fetchValue(StorageKey.userid) ?? "1";
    getUserDetails();

    //Home Screen
    await getRandomFiveCars();
    await getFiveRandomBikes();
    await getSpaeresListApi();

    // on Selected Brand or Show All
    await getCarsListApi();
    await getbikesListApi();

    await getCarsListSuggestionApi();
    await getCarsDealsListApi();
    await getbikesDealsListApi();
  }

  void showNonDismissibleDialog({
    required TextEditingController controller,
  }) {
    Get.dialog(
      AlertDialog(
        title: const Text('Enter Name'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Please enter your name.'),
            const SizedBox(height: 10),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (controller.text.isEmpty) {
                // Show a warning if the field is empty
                Get.snackbar(
                  'Error',
                  'Name cannot be empty!',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red.withOpacity(0.8),
                  colorText: Colors.white,
                );
              } else {
                Get.back(); // Dismiss the dialog
                // Add your logic here after the dialog is closed
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
      barrierDismissible: false, // Prevents dismissing the dialog by tapping outside
    );
  }

  Rx<TextEditingController> name = TextEditingController().obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;

  Future<userDetails?> getUserDetails() async {
    //TODO
    Map<String, dynamic> params = {'id': id.value};
    debugPrint(params.toString());
    try {
      userDetails userResponse = await SettingRepositiory.getUserDeatils(params: params);
      if (userResponse.status == "success") {
        name.value.text = userResponse.data!.name!;

        if (name.value.text.isEmpty || name.value.text.isNull || name.value.text == "".obs) {
          showNonDismissibleDialog(controller: name.value);
        }

        phone.value.text = userResponse.data!.phone!;

        return userResponse;
      } else {}
    } catch (e) {
      debugPrint("Error in Contact ${e..toString}");
    }
    return null;
  }

  var cityName = 'Fetch Current Location'.obs;
  Future<void> getCityNameFromCoordinates(double latitude, double longitude) async {
    const apiKey = 'AIzaSyD71mBgK5iq7VKL4Q51bkTI_lSk6tPd_Xc';
    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'OK') {
          final results = data['results'];
          for (var component in results[0]['address_components']) {
            if (component['types'].contains('locality')) {
              cityName.value = component['long_name'];
              debugPrint(cityName.value);
              saveLocation(cityName.value);

              return;
            }
          }
        }
      }
      cityName.value = 'City not found';
    } catch (e) {
      cityName.value = 'Error fetching city';
    }
  }

  Future<CarsModel?> getCarsListApi() async {
    Map<String, dynamic> params = {
      'city': location.value,
      'brand': filterBrand.value,
      'color': filterColor.value,
      'km_driven': filterBudget.value,
      'search_filter': filterColor.value,
    };
    isLoadingInCas.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getCarsApi(params: params);
      isLoadingInCas.value = false;

      if (getCarsApiresponse.status == true) {
        getCarsList.clear();
        getCarsList.value = getCarsApiresponse.data!;
      } else {
        getCarsList.clear();
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoadingInCas.value = false;
    }
    return null;
  }

  Future<bannerImagesModel?> getBanners() async {
    try {
      bannerImagesModel getCarsApiresponse = await DashboardRepository.getBannerApi(params: null);
      if (getCarsApiresponse.status == "success") {
        getBannerImg.value = getCarsApiresponse.data!;
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {}
    return null;
  }

  RxList<CityModel> cityListModel = <CityModel>[].obs;
  Future<homePageCityModel?> getDefaultCities() async {
    try {
      homePageCityModel getCarsApiresponse = await DashboardRepository.getdefaultCities();
      if (getCarsApiresponse.status == "success") {
        cityListModel.value = getCarsApiresponse.data!;
      }
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {}
    return null;
  }

  Future<CarsModel?> getCarsListSuggestionApi() async {
    isLoadingInCas.value = true;
    try {
      CarsModel getCarsApiresponse = await DashboardRepository.getCarsSuggestionApi();
      if (getCarsApiresponse.status == true) {
        getCarsSuggestionList.value = getCarsApiresponse.data!;
      } else {}
    } catch (e) {
      debugPrint("Error in getCarsListApi ${e.toString()}");
    } finally {
      isLoadingInCas.value = false;
    }
    return null;
  }

  Future<Bikemodel?> getbikesDealsListApi() async {
    Map<String, dynamic> params = {
      'city': location.value,
      'brand': filterBrand.value,
      'color': filterColor.value,
      'fuel_type': selectedFuelType.value,
      'min_budget': minValue.value,
      'max_budget': maxValue.value,
      'number_of_owners': filterOwners.value,
    };
    debugPrint(params.toString());
    isLoadingInBikes.value = true;
    try {
      Bikemodel getBikeApiresponse = await DashboardRepository.getBikesAPi(params: params);
      isLoadingInBikes.value = false;
      if (getBikeApiresponse.status == true) {
        if (getBikeApiresponse.data != null) {
          getBikeByBrandList.value = getBikeApiresponse.data!;
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
      isLoadingInBikes.value = false;
    }
    return null;
  }

  Future<Bikemodel?> getbikesListApi() async {
    Map<String, dynamic> params = {
      'city': location.value,
      'brand': "",
      'color': "",
      'km_driven': "",
      'search_filter': "",
    };
    debugPrint(params.toString());

    isLoadingInBikes.value = true;
    try {
      Bikemodel getBikeApiresponse = await DashboardRepository.getBikesAPi(params: params);
      isLoadingInBikes.value = false;

      if (getBikeApiresponse.status == true) {
        if (getBikeApiresponse.data != null) {
          getBikeList.value = getBikeApiresponse.data!;
        }
      } else {}
    } catch (e) {
      debugPrint("Error in getbikesListApi  All ${e.toString()}");
    } finally {
      isLoadingInBikes.value = false;
    }
    return null;
  }

  Future<Bikemodel?> getFiveRandomBikes() async {
    isLoadingRandom.value = true;
    try {
      Bikemodel getBikeApiresponse = await DashboardRepository.getRandomFiveBikesAPi();
      isLoadingRandom.value = false;

      if (getBikeApiresponse.status == "true" || getBikeApiresponse.status == true) {
        if (getBikeApiresponse.data != null) {
          getBikesRandom.value = getBikeApiresponse.data!;
        }
      } else {}
    } catch (e) {
      debugPrint("Error in getbikesListApi  Random ${e.toString()}");
    } finally {
      isLoadingRandom.value = false;
    }
    return null;
  }

  Future<homePageCityModel?> fetchCities(String query) async {
    isLoading.value = true;
    try {
      homePageCityModel getBikeApiresponse = await DashboardRepository.getCityModel(params: query);

      if (getBikeApiresponse.status == "success") {
        if (getBikeApiresponse.data != null) {
          cityListModel.value = getBikeApiresponse.data ?? [];
        }
      } else {}
    } catch (e) {
      debugPrint("Error in getbikesListApi ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  var brand = <BrandNamesList>[].obs;
  Future<brandNamesModel?> fetchBrands(String query) async {
    isLoading.value = true;
    try {
      brandNamesModel getBikeApiresponse = await DashboardRepository.getbrandModel(params: query);

      if (getBikeApiresponse.status == "success") {
        if (getBikeApiresponse.data != null) {
          brand.value = getBikeApiresponse.data ?? [];
        }
      } else {}
    } catch (e) {
      debugPrint("Error in getbikesListApi ${e.toString()}");
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
    await LocalStorage.storeValue(StorageKey.userLocation, savedlocation);

    getCarsList.clear();
    getSparedList.clear();
    getBikeList.clear();
    location.value = await LocalStorage.fetchValue(StorageKey.userLocation) ?? '';
    await getSpaeresListApi();
    await getbikesListApi();
    await getCarsListApi();

    Get.offNamed(Routes.HOME_SCREEN);
  }

  Future<void> fetchCurrentLocation() async {
    isloadingLocation.value = true;

    try {
      debugPrint("1");
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      debugPrint("Service Enabled: $serviceEnabled");

      if (!serviceEnabled) {
        showToast("Please Enabled your Location");
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      debugPrint("2 - Permission is: $permission");

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        debugPrint("3 - Requested Permission: $permission");
        if (permission == LocationPermission.denied) {
          showToast(
            "Please Enabled your Location and allow location ",
          );
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        showToast("Please Give access from Setting");
        throw Exception('Location permissions are permanently denied. We cannot request permissions.');
      }

      debugPrint("4 - Permissions granted, fetching position...");

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
      ).timeout(
        const Duration(seconds: 12),
        onTimeout: () {
          showToast("Network and GPS Latency is too low");
          debugPrint("Timeout while fetching position");
          throw Exception('Timeout while fetching position');
        },
      );

      debugPrint("5 - Position fetched: ${position.latitude}, ${position.longitude}");
      print(position.latitude);

      print(position.longitude);

      await getCityNameFromCoordinates(position.latitude, position.longitude);
    } catch (e) {
      cityName.value = 'Error fetching location';
      print('Error: $e');
    } finally {
      isloadingLocation.value = false;
    }
  }

  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void updateMin(double value) {
    minValue.value = value;
  }

  void updateMax(double value) {
    maxValue.value = value;
  }

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

  void selectVehicleType(String vehcleType) {
    VehicleType.value = vehcleType;
  }

  void selectSpareType(String Type) {
    spareType.value = Type;
  }

  void selectBudget(String budget) {
    filterBudget.value = budget;
  }

  void selectOwner(String owner) {
    filterOwners.value = owner;
  }

  void openMaps(String query) async {
    final Uri googleMapsUri = Uri(
      scheme: 'https',
      host: 'www.google.com',
      path: 'maps/search/$query',
    );

    // Print the generated URL for debugging
    print(googleMapsUri.toString());

    // Check if the URL can be launched
    if (await canLaunch(googleMapsUri.toString())) {
      await launch(googleMapsUri.toString());
    } else {
      throw 'Could not launch $googleMapsUri';
    }
  }

  final List<City> cities = City.values;
}
