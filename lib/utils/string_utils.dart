String formatPriceRange(String price) {
  double parsedPrice = double.tryParse(price) ?? 0.0;

  double range = parsedPrice * 0.12; // 10% range
  double lowerLimit = parsedPrice - range;
  double upperLimit = parsedPrice + range;

  if (parsedPrice >= 100000) {
    String lowerInLakhs = (lowerLimit / 100000).toStringAsFixed(1);
    String upperInLakhs = (upperLimit / 100000).toStringAsFixed(1);
    return " ₹$lowerInLakhs Lakhs - ₹$upperInLakhs Lakhs";
  } else {
    String lowerInThousands = (lowerLimit / 1000).toStringAsFixed(1);
    String upperInThousands = (upperLimit / 1000).toStringAsFixed(1);
    return " ₹${lowerInThousands}K - ₹${upperInThousands}K ";
  }
}

String formatToRoundedFigure(double value) {
  if (value >= 10000000) {
    return '${(value / 10000000).toStringAsFixed(1)} Cr'; // Crore
  } else if (value >= 100000) {
    return '${(value / 100000).toStringAsFixed(1)} L'; // Lakh
  } else if (value >= 1000) {
    return '${(value / 1000).toStringAsFixed(1)} K'; // Thousand
  } else {
    return value.toStringAsFixed(0); // Whole number
  }
}

String capitalizeFirstLetter(String brand) {
  if (brand.isNotEmpty) {
    return brand[0].toUpperCase() + brand.substring(1);
  }
  return brand;
}
