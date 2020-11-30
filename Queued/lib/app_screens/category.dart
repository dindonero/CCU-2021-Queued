import 'package:flutter/material.dart';

class Category {
  final String image;
  final String title;
  final int id;
  final Color color;

  Category({
    this.id,
    this.title,
    this.image,
    this.color,
  });
}

List<Category> categories = [
  Category(
      id: 1,
      title: "Supermarket",
      image: "images/supermarkets.png",
      color: Color(0xFFFFFFFF)),
];

