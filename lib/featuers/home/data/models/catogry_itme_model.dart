import 'package:flutter/material.dart';

class CatogryItmeModel {
  final String image;
  final String title;
  final String catogry;
    Color? color=Colors.black;

  // Constructor
  CatogryItmeModel(
     {
    required this.catogry,
    required this.image,
    required this.title,
    required this.color,
  });
}
