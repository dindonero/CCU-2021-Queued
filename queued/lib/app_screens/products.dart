import 'package:flutter/material.dart';

class Category {
  final String image;
  final int size, id;
  final Color color;

  Category({
    this.id,
    this.image,
    this.size,
    this.color,
  });
}

List<Category> categories = [
  Category(
      id: 1,
      size: 12,
      image: "images/supermarkets.png",
      color: Color(0xFFFFFFFF)),

];

