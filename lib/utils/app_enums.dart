import 'package:flutter/material.dart';

enum City {
  Agartala,
  Agra,
  Ahmednagar,
  Akola,
  Solapur,
  Kolhapur,
  Sangli,
  Nagpur,
}

enum Colour { black, grey, red, blue, darkGreen }

extension ColourExtension on Colour {
  String get displayName {
    switch (this) {
      case Colour.black:
        return "Black";
      case Colour.grey:
        return "Grey";
      case Colour.red:
        return "Red";
      case Colour.blue:
        return "Blue";
      case Colour.darkGreen:
        return "Dark Green";
      default:
        return "";
    }
  }

  String get backendValue {
    switch (this) {
      case Colour.black:
        return "black";
      case Colour.grey:
        return "grey";
      case Colour.red:
        return "red";
      case Colour.blue:
        return "blue";
      case Colour.darkGreen:
        return "dark_green";
      default:
        return "";
    }
  }
}

enum CarBrand {
  Volvo,
  MG,
  Hyundai,
  Kia,
  Volkswagen,
  Citroen,
  Nissan,
  Mercedes,
  BMW,
  Audi,
  Mahindra,
  Tata,
  Lexus,
  Renault,
  Jeep,
}

enum BikeBrand {
  Royal_Enfield,
  MG,
  BAJAJ,
  KTM,
  Keeway,
  Suzuki,
  Ducati,
  Hero,
  Ather,
  OLA,
  Vida,
  Revolt,
  Harley_Davidson,
  Jawa,
}

enum FilterOption {
  byKmDriven,
  byFuelType,
  byNumberOfOwner,
  byBudget,
  byBrand,
  byModel,
  byYear,
  byColour,
}

enum ImageType { svg, png, other }

enum FileType { asset, network, file, other }

enum StorageKey {
  user,
  userid,
  token,
  userLocation;

  String get name => switch (this) {
        StorageKey.user => 'username',
        StorageKey.userid => 'userid',
        StorageKey.token => 'token',
        StorageKey.userLocation => 'userLocation',
      };
}

enum MediaType { image, video }

enum NotificationStatus {
  granted,
  denied,
  permanentlyDenied;
}

enum LocationStatus {
  granted,
  partial,
  denied,
  permanentlyDenied;
}

enum HelpLine {
  police('Police', '100', Icons.local_police),
  ambulance('Ambulance', '108', Icons.local_hospital),
  fireBrigade('Fire Brigade', '101', Icons.fire_truck),
  pmc('PMC', '18001030222', Icons.location_city),
  childHelpline('Child Helpline', '1098', Icons.child_care),
  womenHelpline('Women Helpline', '1091', Icons.woman);

  final String name;
  final String number;
  final IconData icon;

  const HelpLine(this.name, this.number, this.icon);
}

enum RideStatus {
  completed,
  cancelled,
  pending;

  Color get color {
    switch (this) {
      case RideStatus.completed:
        return Colors.green;
      case RideStatus.cancelled:
        return Colors.red;
      case RideStatus.pending:
        return Colors.amber;
    }
  }

  static RideStatus fromString(String? status) {
    switch (status?.toLowerCase()) {
      case 'completed':
        return RideStatus.completed;
      case 'cancelled':
        return RideStatus.cancelled;
      default:
        return RideStatus.pending;
    }
  }
}

enum MarkerType {
  source('pickup'),
  destination('drop');

  final String name;
  const MarkerType(this.name);
}
