import 'dart:convert';

class DaySlot {
  final String open;
  final String close;

  DaySlot({required this.open, required this.close});

  Map<String, dynamic> toJson() => {'open': open, 'close': close};
}

class OperatingHoursModel {
  final String timezone;
  final Map<String, List<DaySlot>> delivery;
  final Map<String, List<DaySlot>> pickup;

  OperatingHoursModel({
    required this.timezone,
    required this.delivery,
    required this.pickup,
  });

  Map<String, dynamic> toJson() {
    return {
      'time': {
        'timezone': timezone,
        'delivery': delivery.map(
          (day, slots) => MapEntry(day, slots.map((s) => s.toJson()).toList()),
        ),
        'pickup': pickup.map(
          (day, slots) => MapEntry(day, slots.map((s) => s.toJson()).toList()),
        ),
      }
    };
  }

  String toJsonString() => jsonEncode(toJson());
}
