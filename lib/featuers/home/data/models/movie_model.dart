import 'package:flutter/material.dart';

class MovieModel {
  final int id;
  final String? title;
  final String? content;
  final String? thumbnail;
  final String embedLink;
  final List<String> categories;
   final List<String>? tags;
  final String? type;
  Color? color = Colors.transparent;

  MovieModel({
    required this.id,
    required this.title,
    required this.content,
    this.thumbnail,
    this.color,
    required this.embedLink,
    required this.categories,
      required this.tags,
    required this.type,
  });

  // Factory method to create a MovieModel from a JSON object
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title']?? '',
      content: json['content'] ?? '',
      thumbnail: json['thumbnail'] != null && json['thumbnail'] != false
          ? json['thumbnail']
          : null,
      embedLink: json['embed_link']?? '',
      categories: List<String>.from(json['categories']),
        tags: List<String>.from(json['tags']??[""]),
      type: json['type'],
    );
  }

  // Method to convert a MovieModel object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'thumbnail': thumbnail,
      'embed_link': embedLink,
      'categories': categories,
       'tags': tags,
      'type': type,
    };
  }
}

// class MovieModel {
// 	int? id;
// 	String? title;
// 	String? content;
// 	String? thumbnail;
// 	String? embedLink;
// 	List<String>? categories;
// 	List<dynamic>? tags;
// 	String? type;
//
// 	MovieModel({
// 		this.id,
// 		this.title,
// 		this.content,
// 		this.thumbnail,
// 		this.embedLink,
// 		this.categories,
// 		this.tags,
// 		this.type,
// 	});
//
// 	factory MovieModel.fromJson(Map<String, dynamic> json) {
// 		return MovieModel(
// 			id: json['id'] as int?,
// 			title: json['title'] as String?,
// 			content: json['content'] as String?,
// 			thumbnail: json['thumbnail'] as String?,
// 			embedLink: json['embed_link'] as String?,
// 			categories: (json['categories'] as List<dynamic>?)?.map((e) => e as String).toList(),
// 			tags: json['tags'] as List<dynamic>?,
// 			// Fix the type handling to ensure we account for both bool and String
// 			type: _convertTypeToString(json['type']),
// 		);
// 	}
//
// 	// Helper function to handle type conversion of `type` field
// 	static String? _convertTypeToString(dynamic value) {
// 		if (value == null) return null;
// 		if (value is bool) return value.toString(); // Convert `bool` to string
// 		if (value is String) return value; // If it's already a `String`, return it
// 		return null; // If it's some other type, return null (or handle differently if needed)
// 	}
// }
