// To parse this JSON data, do
//
//     final divisionWiseData = divisionWiseDataFromJson(jsonString);

import 'dart:convert';

DivisionWiseData divisionWiseDataFromJson(String str) => DivisionWiseData.fromJson(json.decode(str));

String divisionWiseDataToJson(DivisionWiseData data) => json.encode(data.toJson());

class DivisionWiseData {
  Status status;
  List<District> data;

  DivisionWiseData({
    required this.status,
    required this.data,
  });

  factory DivisionWiseData.fromJson(Map<String, dynamic> json) => DivisionWiseData(
    status: Status.fromJson(json["status"]),
    data: List<District>.from(json["data"].map((x) => District.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class District {
  String district;
  String districtbn;
  String coordinates;
  List<String> upazilla;

  District({
    required this.district,
    required this.districtbn,
    required this.coordinates,
    required this.upazilla,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    district: json["district"],
    districtbn: json["districtbn"],
    coordinates: json["coordinates"],
    upazilla: List<String>.from(json["upazilla"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "district": district,
    "districtbn": districtbn,
    "coordinates": coordinates,
    "upazilla": List<dynamic>.from(upazilla.map((x) => x)),
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