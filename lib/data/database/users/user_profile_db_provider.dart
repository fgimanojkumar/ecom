import 'package:hive/hive.dart';

import '../box_names_type_id.dart';
import 'adapter/user_profile.dart';

class UserProfileDbProvider {
  UserProfileDbProvider._internal();

  static final UserProfileDbProvider _instance =
      UserProfileDbProvider._internal();

  factory UserProfileDbProvider() {
    return _instance;
  }

  static String boxUserProfile = BoxNamesTypeId.userProfile;

  static save(UserProfile userProfile) async {
    var box = await Hive.openBox(boxUserProfile);
    await box.put(userProfile.userId, userProfile);
  }

  static getProfile(String userId) async {
    var box = await Hive.openBox(boxUserProfile);
    return box.get(userId);
  }
}
