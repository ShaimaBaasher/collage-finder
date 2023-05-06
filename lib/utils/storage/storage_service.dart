import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'base_service.dart';

class StorageService extends GetxService implements BaseService {
  static StorageService get to => Get.find<StorageService>();
  late GetStorage _box;

  @override
  Future<void> init() async {
    _box = GetStorage('settings');

    await _box.initStorage;
  }

  void reset() async {
    await _box.erase();
  }

  String? get language => _box.read(_Keys.language) ?? 'en';

  void setLanguage(String? language) => _box.write(_Keys.language, language);

  void removeKey(String key) async {
    await _box.remove(key);
  }

  int? get homePageIndex => _box.read(_Keys.homeIndex) ?? 0;

  void setHomePageIndex(int? homeIndex) => _box.write(_Keys.homeIndex, homeIndex);

  String? get userId => _box.read(_Keys.userId);

  void setUserId(String? userId) => _box.write(_Keys.userId, userId);

  String? get userPhotoUrl => _box.read(_Keys.userPhotoUrl);

  void setUserPhotoUrl(String? photoUrl) => _box.write(_Keys.userPhotoUrl, photoUrl);

  String? get userName => _box.read(_Keys.userName);

  void setUserName(String? userName) => _box.write(_Keys.userName, userName);

  String? get email => _box.read(_Keys.email);

  void setEmail(String? email) => _box.write(_Keys.email, email);

  bool get isLoggedIn => _box.read(_Keys.isLoggedIn) ?? false;

  void setIsLoggedIn(bool? isLoggedIn) => _box.write(_Keys.isLoggedIn, isLoggedIn);

  bool get getFavView => _box.read(_Keys.favview) ?? false;

  void setFavView(bool? getFavView) => _box.write(_Keys.favview, getFavView);

  bool get isUserFirstLaunch => _box.read(_Keys.isUserFirstLaunch) ?? false;

  void setIsUserFirstLaunch(bool? isUserFirstLaunch) => _box.write(_Keys.isUserFirstLaunch, isUserFirstLaunch);

  String? get getCountryISOCode => _box.read(_Keys.countryISOCode) ?? '';

  void setCountryISOCode(String? countryISOCode) => _box.write(_Keys.countryISOCode, countryISOCode);

  String? get getCountryCode => _box.read(_Keys.countrycode) ?? '';

  void setCountryCode(String? countrycode) => _box.write(_Keys.countrycode, countrycode);

  String? get getToken => _box.read(_Keys.token) ?? '';

  void setToken(String? token) => _box.write(_Keys.token, token);

  String? get getCurrency => _box.read(_Keys.currency) ?? '\$';

  void setCurrency(String? currency) => _box.write(_Keys.currency, currency);

  String? get getApiCurrency => _box.read(_Keys.apiCurrency) ?? 'USD';

  void setApiCurrency(String? currency) => _box.write(_Keys.apiCurrency, currency);

  String? get getPaymentCurrency => _box.read(_Keys.paymentcurrency) ?? 'USD';

  void setPaymentCurrency(String? currency) => _box.write(_Keys.paymentcurrency, currency);

  void setPhoneNumber(String? phoneNumber) => _box.write(_Keys.phoneNumber, phoneNumber);

  String? get getPhoneNumber => _box.read(_Keys.phoneNumber) ?? '';

  bool? get isActionComingFromProfile => _box.read(_Keys.isActionComingFromProfile) ?? false;

  void setIsActionComingFromProfile(bool? isActionComingFromProfile) => _box.write(_Keys.isActionComingFromProfile, isActionComingFromProfile);



}

abstract class _Keys {
  static const String  language = 'language';
  static const String  homeIndex = 'homeIndex';
  static const String  userId = 'userId';
  static const String  userPhotoUrl = 'userPhotoUrl';
  static const String  userName = 'userName';
  static const String  email = 'email';
  static const String  phoneNumber = 'phoneNumber';
  static const String  isLoggedIn = 'isLoggedIn';
  static const String  countryISOCode = 'countryISOCode';
  static const String  isActionComingFromProfile = 'isActionComingFromProfile';
  static const String  token = 'token';
  static const String  currency = 'currency';
  static const String  apiCurrency = 'apiCurrency';
  static const String  isUserFirstLaunch = 'isUserFirstLaunch';
  static const String  settingList = 'settingList';
  static const String  searchHistory = 'searchHistory';
  static const String  paymentcurrency = 'payment-currency';
  static const String  favview = 'fav-view';
  static const String  countrycode = 'country-code';
}
