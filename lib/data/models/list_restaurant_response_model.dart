// To parse this JSON data, do
//
//     final listRestaurantResponseModel = listRestaurantResponseModelFromJson(jsonString);

import 'dart:convert';

ListRestaurantResponseModel listRestaurantResponseModelFromJson(String str) => ListRestaurantResponseModel.fromJson(json.decode(str));

String listRestaurantResponseModelToJson(ListRestaurantResponseModel data) => json.encode(data.toJson());

class ListRestaurantResponseModel {
  final bool? error;
  final String? message;
  final int? count;
  final List<Restaurant>? restaurants;

  ListRestaurantResponseModel({
    this.error,
    this.message,
    this.count,
    this.restaurants,
  });

  factory ListRestaurantResponseModel.fromJson(Map<String, dynamic> json) => ListRestaurantResponseModel(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: json["restaurants"] == null ? [] : List<Restaurant>.from(json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": restaurants == null ? [] : List<dynamic>.from(restaurants!.map((x) => x.toJson())),
  };
}

class Restaurant {
  final String? id;
  final String? name;
  final String? description;
  final String? pictureId;
  final String? city;
  final double? rating;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}
