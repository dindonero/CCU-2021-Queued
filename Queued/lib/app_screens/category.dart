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
      image: "images/supermarkets2.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 2,
      title: "Pharmacy",
      image: "images/phar2.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 3,
      title: "Coffee Shop",
      image: "images/coffeeShop2.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 4,
      title: "Coffee",
      image: "images/coffee2.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 5,
      title: "Hospital",
      image: "images/hospital2.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 6,
      title: "Restaurant",
      image: "images/restaurant2.png",
      color: Color(0xFFFFFFFF)),
];

