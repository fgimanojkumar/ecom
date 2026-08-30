import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/database/users/adapter/user_profile.dart';
import '../../../data/database/users/user_profile_db_provider.dart';
import '../../../shared/flutterStorage/flutter_storage_keys.dart';
import '../../../shared/localStorage/local_storage.dart';

class ProfileController extends GetxController {
  RxBool isDataLoaded = false.obs;
  Rx<UserProfile>? userProfile = Rx<UserProfile>(UserProfile());
  TextEditingController setPin = TextEditingController();
  TextEditingController confirmPin = TextEditingController();
  var isExpanded = false.obs;

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
    setPin = TextEditingController();
    confirmPin = TextEditingController();
  }

  final ImagePicker picker = ImagePicker();
  // var selectedImage = File('').obs;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  var selectedImage = Rx<File?>(null);
  var isLoading = true.obs; // Observable to manage loading state

  @override
  void onInit() {
    super.onInit();

    getProfileData();
  }

  @override
  void dispose() {
    setPin.dispose();
    confirmPin.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    setPin.dispose();
    confirmPin.dispose();
    super.onClose();
  }

  getProfileData() async {
    try {
      String userId =
          await LocalStorage().getLocalStorage(FlutterStorageKeys().userId);
      userProfile?.value = await UserProfileDbProvider.getProfile(userId);
      update();
    } catch (e) {
      log('Profile data load failed, using static mode: $e');
    } finally {
      await loadImageFromSecureStorage();
      isDataLoaded(true);
    }
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      await saveImageToSecureStorage(File(pickedFile.path));
    }
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      await saveImageToSecureStorage(File(pickedFile.path));
    }
  }

  Future<void> saveImageToSecureStorage(File image) async {
    try {
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);
      await secureStorage.write(key: 'storedImage', value: base64Image);
    } catch (e) {
      log('Error saving image to secure storage: $e');
    }
  }

  Future<void> loadImageFromSecureStorage() async {
    try {
      final base64Image = await secureStorage.read(key: 'storedImage');
      if (base64Image != null) {
        final bytes = base64Decode(base64Image);
        selectedImage.value = File.fromRawPath(bytes);
      }
    } catch (e) {
      log('Error loading image from secure storage: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
