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
  Category(
      id: 2,
      title: "Pharmacy",
      image: "images/phar.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 3,
      title: "Coffee Shop",
      image: "images/coffeeShop.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 4,
      title: "Coffee",
      image: "images/coffee.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 5,
      title: "Hospital",
      image: "images/hospital.png",
      color: Color(0xFFFFFFFF)),
  Category(
      id: 6,
      title: "Restaurant",
      image: "images/restaurant.png",
      color: Color(0xFFFFFFFF)),
];

