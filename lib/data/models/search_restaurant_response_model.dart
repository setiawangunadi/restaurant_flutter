// To parse this JSON data, do
//
//     final searchRestaurantResponseModel = searchRestaurantResponseModelFromJson(jsonString);

import 'dart:convert';

SearchRestaurantResponseModel searchRestaurantResponseModelFromJson(String str) => SearchRestaurantResponseModel.fromJson(json.decode(str));

String searchRestaurantResponseModelToJson(SearchRestaurantResponseModel data) => json.encode(data.toJson());

class SearchRestaurantResponseModel {
  final bool? error;
  final int? founded;
  final List<Restaurant>? restaurants;

  SearchRestaurantResponseModel({
    this.error,
    this.founded,
    this.restaurants,
  });

  factory SearchRestaurantResponseModel.fromJson(Map<String, dynamic> json) => SearchRestaurantResponseModel(
    error: json["error"],
    founded: json["founded"],
    restaurants: json["restaurants"] == null ? [] : List<Restaurant>.from(json["restaurants"]!.map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
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
