import 'dart:typed_data';
import 'dart:ui';

import 'package:Queued/app_screens/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class CategoryDto {

  CategoryDto(this.id, this.name, this.img);

  int id;

  String name;

  Uint8List img;

  CategoryDto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.img = Uint8List.fromList(json['img'].cast<int>());
  }

  Category toDomain(){
    return new Category(id: this.id, title: this.name, image: new Image.memory(this.img), color: Color(0xFFFFFFFF));
  }

  Map<String, dynamic> toJson(){
      return {'id': this.id.toString(), 'name': this.name, 'img': this.img.toString()};
  }
}
