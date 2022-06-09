// To parse this JSON data, do
//
//     final rol = rolFromJson(jsonString);

import 'dart:convert';

Rol rolFromJson(String str) => Rol.fromJson(json.decode(str));

String rolToJson(Rol data) => json.encode(data.toJson());

class Rol {

  String? id;
  String? name;
  String? image;
  String? rout;

  Rol({
    this.id,
    this.name,
    this.image,
    this.rout,
  });

  factory Rol.fromJson(Map<String, dynamic> json) => Rol(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    rout: json["rout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "rout": rout,
  };
}
