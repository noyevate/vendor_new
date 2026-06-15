import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/common/size.dart';
import 'dart:convert';

class DayScheduleState {
  RxBool isOpen;
  RxString openTime;
  RxString closeTime;

  DayScheduleState({
    bool isOpen = true,
    String openTime = '08:00',
    String closeTime = '21:00',
  })  : isOpen = isOpen.obs,
        openTime = openTime.obs,
        closeTime = closeTime.obs;
}

class OperatingHoursControllerNew extends GetxController {
  // Tab: 0 = delivery, 1 = pickup
  RxInt selectedTab = 0.obs;

  // true = pickup uses same hours as delivery
  RxBool sameHoursForBoth = true.obs;

  RxBool isLoading = false.obs;

  RxBool isOperatingHours = false.obs;
  final box = GetStorage();

  final List<String> days = [
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
    'sunday',
  ];

  // Schedule state for each order type
  late Map<String, DayScheduleState> deliverySchedule;
  late Map<String, DayScheduleState> pickupSchedule;

  @override
  void onInit() {
    super.onInit();
    _initSchedules();
  }

  void _initSchedules() {
    deliverySchedule = {
      for (var day in days) day: DayScheduleState(),
    };
    pickupSchedule = {
      for (var day in days) day: DayScheduleState(),
    };
    // Default: weekends closed
    deliverySchedule['sunday']!.isOpen.value = false;
    pickupSchedule['sunday']!.isOpen.value = false;
  }

  Map<String, DayScheduleState> get activeSchedule {
    if (selectedTab.value == 1 && !sameHoursForBoth.value) {
      return pickupSchedule;
    }
    return deliverySchedule;
  }

  String get deviceTimezone {
    return DateTime.now().timeZoneName.isNotEmpty
        ? DateTime.now().timeZoneName
        : 'Africa/Lagos';
  }

  Future<void> pickTime(
    BuildContext context,
    String day,
    bool isOpenTime,
  ) async {
    final schedule = selectedTab.value == 1 && !sameHoursForBoth.value
        ? pickupSchedule
        : deliverySchedule;

    final current = isOpenTime
        ? schedule[day]!.openTime.value
        : schedule[day]!.closeTime.value;

    final parts = current.split(':');
    final initialTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted =
          '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

      if (isOpenTime) {
        schedule[day]!.openTime.value = formatted;
        // If sameHours, mirror to pickup too
        if (sameHoursForBoth.value) {
          pickupSchedule[day]!.openTime.value = formatted;
        }
      } else {
        schedule[day]!.closeTime.value = formatted;
        if (sameHoursForBoth.value) {
          pickupSchedule[day]!.closeTime.value = formatted;
        }
      }
    }
  }

  void toggleDay(String day, bool value) {
    activeSchedule[day]!.isOpen.value = value;
    // Mirror to pickup if same hours
    if (sameHoursForBoth.value) {
      pickupSchedule[day]!.isOpen.value = value;
    }
  }

  // Builds the final payload
  Map<String, List<Map<String, dynamic>>> _buildSchedulePayload(
      Map<String, DayScheduleState> schedule) {
    return {
      for (var day in days)
        day: schedule[day]!.isOpen.value
            ? [
                {
                  'open': schedule[day]!.openTime.value,
                  'close': schedule[day]!.closeTime.value,
                }
              ]
            : [], // empty = closed
    };
  }

  Future<int?> saveOperatingHours(String? restaurantId) async {
    if (restaurantId == null) return null;
    isLoading.value = true;

    Uri url = Uri.parse("$appBaseUrl/api/restaurant/operating-hours");
    print("response: $url");

    String accessToken = box.read("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken'
    };

    try {
      final payload = {
        'time': {
          'timezone': 'Africa/Lagos',
          'delivery': _buildSchedulePayload(deliverySchedule),
          'pickup': sameHoursForBoth.value
              ? _buildSchedulePayload(deliverySchedule)
              : _buildSchedulePayload(pickupSchedule),
        }
      };

      // ✅ jsonEncode converts the Map to a JSON string
      final response =
          await http.patch(url, headers: headers, body: jsonEncode(payload));

      print("status: ${response.statusCode}");
      print(
          "body: ${response.body}"); // add this to see what the backend returns

      isOperatingHours.value = true;
      return response.statusCode;
    } catch (e) {
      print('Error saving hours: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
