import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class LocationUtil {
  LocationUtil._();

  static Future<String?>? _locationNameRequest;
  static String? _cachedLocationName;
  static bool _hasResolvedLocationName = false;

  static Future<String?> getCurrentLocationName() {
    if (_hasResolvedLocationName) {
      return Future.value(_cachedLocationName);
    }
    return _locationNameRequest ??= _resolveCurrentLocationName().then((name) {
      _cachedLocationName = name;
      _hasResolvedLocationName = true;
      return name;
    }).whenComplete(() => _locationNameRequest = null);
  }

  static Future<Map<String, String>?> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    final uri = Uri.https(
      'nominatim.openstreetmap.org',
      '/reverse',
      {
        'format': 'jsonv2',
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'addressdetails': '1',
      },
    );

    try {
      final response = await http.get(
        uri,
        headers: const {'User-Agent': 'Bhabsa Flutter app'},
      ).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return null;

      final result = jsonDecode(response.body);
      if (result is! Map<String, dynamic>) return null;
      final rawAddress = result['address'];
      if (rawAddress is! Map<String, dynamic>) return null;

      String firstAddressValue(List<String> keys) {
        for (final key in keys) {
          final value = rawAddress[key];
          if (value is String && value.trim().isNotEmpty) return value.trim();
        }
        return '';
      }

      final houseNumber = firstAddressValue(['house_number']);
      final road = firstAddressValue([
        'road',
        'pedestrian',
        'residential',
        'footway',
        'neighbourhood',
        'suburb',
      ]);

      return {
        'street':
            [houseNumber, road].where((part) => part.isNotEmpty).join(' '),
        'city': firstAddressValue([
          'city',
          'town',
          'village',
          'municipality',
          'city_district',
        ]),
        'state': firstAddressValue(['state', 'state_district', 'county']),
        'pincode': firstAddressValue(['postcode']),
      };
    } catch (_) {
      return null;
    }
  }

  static Future<String?> _resolveCurrentLocationName() async {
    late final List<double> coordinates;
    try {
      coordinates = List<double>.from(await getLatLong());
    } catch (_) {
      return null;
    }
    final latitude = coordinates[0];
    final longitude = coordinates[1];
    if (latitude == 0 && longitude == 0) return null;

    final coordinateLabel =
        '${latitude.toStringAsFixed(4)}, ${longitude.toStringAsFixed(4)}';
    final uri = Uri.https(
      'nominatim.openstreetmap.org',
      '/reverse',
      {
        'format': 'jsonv2',
        'lat': latitude.toString(),
        'lon': longitude.toString(),
        'zoom': '10',
      },
    );

    try {
      final response = await http.get(
        uri,
        headers: const {'User-Agent': 'Bhabsa Flutter app'},
      ).timeout(const Duration(seconds: 8));
      if (response.statusCode != 200) return coordinateLabel;

      final result = jsonDecode(response.body);
      if (result is! Map<String, dynamic>) return coordinateLabel;

      final address = result['address'];
      if (address is Map<String, dynamic>) {
        for (final key in [
          'neighbourhood',
          'suburb',
          'city_district',
          'town',
          'city',
          'village',
          'county',
          'state',
        ]) {
          final value = address[key];
          if (value is String && value.isNotEmpty) return value;
        }
      }

      final displayName = result['display_name'];
      if (displayName is String && displayName.isNotEmpty) {
        return displayName.split(',').take(2).join(',').trim();
      }
      return coordinateLabel;
    } catch (_) {
      return coordinateLabel;
    }
  }

  static getLatLong() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return [position.latitude, position.longitude];
    } catch (e) {
      return [0.0, 0.0];
    }
  }
}
