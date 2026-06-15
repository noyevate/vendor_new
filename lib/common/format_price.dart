import 'package:intl/intl.dart';

import 'package:get/get.dart'; // For RxInt

String formatPrice(dynamic price) {
  // 1. Create the formatter
  var formatter = NumberFormat('#,###');

  double priceAsDouble;

  // 2. Handle all possible input types and convert to a double
  if (price is RxInt) {
    priceAsDouble = price.value.toDouble();
  } else if (price is int) {
    priceAsDouble = price.toDouble();
  } else if (price is double) {
    priceAsDouble = price;
  } else if (price is String) {
    // Use double.tryParse which is safer and handles decimals
    priceAsDouble = double.tryParse(price) ?? 0.0;
  } else if (price == null) {
    priceAsDouble = 0.0;
  }
  else {
    // If the type is unknown, log an error and default to 0
    print("Warning: formatPrice received an invalid type: ${price.runtimeType}");
    priceAsDouble = 0.0;
  }

  // 3. Format the final number.
  // .toInt() safely truncates the decimal part (e.g., 1500.00 becomes 1500)
  return formatter.format(priceAsDouble.toInt());
}