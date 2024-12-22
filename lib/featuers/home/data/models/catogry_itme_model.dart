import 'package:anetv/featuers/home/data/models/utils.dart';
import 'package:flutter/material.dart';

class CatogryItmeModel {
  String? image;
  String? title;
  String? catogry;
  int? id;
  Color? color = Colors.black;

  // Constructor
  CatogryItmeModel({
    required this.catogry,
    required this.image,
    required this.title,
    this.color,
    required this.id,
  });
  toJson() {
    return {
      taskImage: image,
      taskTitle: title,
      taskCatogry: catogry,
      taskId: id,


    };
  }

  CatogryItmeModel.fromJson(Map<String, dynamic> jsonTask) {
    title = jsonTask[taskTitle];
    id = jsonTask[taskId];
    catogry = jsonTask[taskCatogry];
    image = jsonTask[taskImage];
  }
}
