// To parse this JSON data, do
//
//     final division = divisionFromJson(jsonString);

import 'dart:convert';

Division divisionFromJson(String str) => Division.fromJson(json.decode(str));

String divisionToJson(Division data) => json.encode(data.toJson());

class Division {
  Status status;
  List<DivisionData> data;

  Division({
    required this.status,
    required this.data,
  });

  factory Division.fromJson(Map<String, dynamic> json) => Division(
    status: Status.fromJson(json["status"]),
    data: List<DivisionData>.from(json["data"].map((x) => DivisionData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DivisionData {
  String division;
  String divisionbn;
  String coordinates;

  DivisionData({
    required this.division,
    required this.divisionbn,
    required this.coordinates,
  });

  factory DivisionData.fromJson(Map<String, dynamic> json) => DivisionData(
    division: json["division"],
    divisionbn: json["divisionbn"],
    coordinates: json["coordinates"],
  );

  Map<String, dynamic> toJson() => {
    "division": division,
    "divisionbn": divisionbn,
    "coordinates": coordinates,
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