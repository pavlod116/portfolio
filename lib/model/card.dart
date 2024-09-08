import 'package:flutter/material.dart';

class CardModel {
  final String title;
  final Color color;
  final String description;

  CardModel({
    required this.title,
    required this.color,
    required this.description,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      title: json['title'] ?? '',
      color: json['color'] ?? Colors.pink,
      description: json['description'] ?? '',
    );
  }
}
