import 'dart:convert';

// Updated to use a List<Upazilla>
DistrictWiseData districtWiseDataFromJson(String str) => DistrictWiseData.fromJson(json.decode(str));

String districtWiseDataToJson(DistrictWiseData data) => json.encode(data.toJson());

class DistrictWiseData {
  Status status;
  List<Upazilla> data; // Change to List<Upazilla>

  DistrictWiseData({
    required this.status,
    required this.data,
  });

  factory DistrictWiseData.fromJson(Map<String, dynamic> json) => DistrictWiseData(
    status: Status.fromJson(json["status"]),
    data: List<Upazilla>.from(json["data"].map((x) => Upazilla.fromJson(x))), // Parse list of Upazillas
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())), // Convert to JSON list
  };
}

class Upazilla {
  String district;
  String districtbn;
  String coordinates;
  List<String> upazillas;

  Upazilla({
    required this.district,
    required this.districtbn,
    required this.coordinates,
    required this.upazillas,
  });

  factory Upazilla.fromJson(Map<String, dynamic> json) => Upazilla(
    district: json["district"],
    districtbn: json["districtbn"],
    coordinates: json["coordinates"],
    upazillas: List<String>.from(json["upazillas"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "district": district,
    "districtbn": districtbn,
    "coordinates": coordinates,
    "upazillas": List<dynamic>.from(upazillas.map((x) => x)),
  };
}

class Status {
  int code;
  String message;
  String date;

  Status({
    required this.code,
    required this.message,
    required this.date,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    code: json["code"],
    message: json["message"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "date": date,
  };
}