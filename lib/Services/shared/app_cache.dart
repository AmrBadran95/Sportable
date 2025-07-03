import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static late SharedPreferencesWithCache appCache;

  static Future init() async {
    appCache = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: {'isFirstInstalled', 'isLoggedIn'},
      ),
    );
  }

  static Future setFirstInstalled(bool value) async {
    await appCache.setBool('isFirstInstalled', value);
  }

  static bool get isFirstInstalled =>
      appCache.getBool('isFirstInstalled') ?? true;

  static Future setLoggedIn(bool value) async {
    await appCache.setBool('isLoggedIn', value);
  }

  static bool get isLoggedIn => appCache.getBool('isLoggedIn') ?? false;

  static Future reload() async {
    await appCache.reloadCache();
  }
}
