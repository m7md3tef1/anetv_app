import 'package:flutter/material.dart';

class Moves {
  Moves({
    String? status,
    String? message,
    List<Data>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  Moves.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data!.add(Data.fromJson(v));
      });
    }
  }
  String? _status;
  String? _message;
  List<Data>? _data;
  Moves copyWith({
    String? status,
    String? message,
    List<Data>? data,
  }) =>
      Moves(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  String? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    num? id,
    String? name,
    String? video_id,
    var thumbnail,
    Color? color,
    List<String>? categories,
    List<Episodes>? episodes,
  }) {
    _id = id;
    _name = name;
    _color = color;
    _video_id = video_id;
    _thumbnail = thumbnail;
    _categories = categories;
    _episodes = episodes;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _thumbnail = json['thumbnail'];
    _video_id = json['video_id'];
    _categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
    if (json['episodes'] != null) {
      _episodes = [];
      json['episodes'].forEach((v) {
        _episodes!.add(Episodes.fromJson(v));
      });
    }
  }
  num? _id;
  String? _name;
  String? _video_id;
  var _thumbnail;
  Color? _color;
  List<String>? _categories;
  List<Episodes>? _episodes;
  Data copyWith({
    num? id,
    String? name,
    String? video_id,
    Color? color,
    var thumbnail,
    List<String>? categories,
    List<Episodes>? episodes,
  }) =>
      Data(
        id: id ?? _id,
        name: name ?? _name,
        color: color ?? _color,
        video_id: video_id ?? _video_id,
        thumbnail: thumbnail ?? _thumbnail,
        categories: categories ?? _categories,
        episodes: episodes ?? _episodes,
      );
  num? get id => _id;
  String? get name => _name;
  String? get video_id => _video_id;
  Color? get color => _color;
  get thumbnail => _thumbnail;
  List<String>? get categories => _categories;
  List<Episodes>? get episodes => _episodes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['video_id'] = _video_id;
    map['thumbnail'] = _thumbnail;
    map['categories'] = _categories;
    if (_episodes != null) {
      map['episodes'] = _episodes!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}



class Episodes {
  Episodes({
    num? id,
    String? title,
    String? content,
    bool? thumbnail,
    String? embedLink,
    String? video_id,
    Color? color ,
    List<String>? categories,
    List<dynamic>? tags,
    String? type,
  }) {
    _id = id;
    _title = title;
    _color = color;
    _video_id = video_id;
    _content = content;
    _thumbnail = thumbnail;
    _embedLink = embedLink;
    _categories = categories;
    _tags = tags;
    _type = type;
  }

  Episodes.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _video_id = json['video_id'];
    _thumbnail = json['thumbnail'];
    _embedLink = json['embed_link'];
    _categories =
        json['categories'] != null ? json['categories'].cast<String>() : [];
    if (json['tags'] != null) {
      _tags = [];
      json['tags'].forEach((v) {
        _tags!.add(v);
      });
    }
    _type = json['type'];
  }
  num? _id;
  String? _title;
  String? _content;
  String? _video_id;
  var _thumbnail;
  Color? _color;
  String? _embedLink;
  List<String>? _categories;
  List<dynamic>? _tags;
  String? _type;
  Episodes copyWith({
    num? id,
    String? title,
    String? video_id,
    String? content,
    var thumbnail,
    Color? color,
    String? embedLink,
    List<String>? categories,
    List<dynamic>? tags,
    String? type,
  }) =>
      Episodes(
        id: id ?? _id,
        title: title ?? _title,
        video_id: video_id ?? _video_id,
        content: content ?? _content,
        thumbnail: thumbnail ?? _thumbnail,
        embedLink: embedLink ?? _embedLink,
        categories: categories ?? _categories,
        color: color ?? _color,
        tags: tags ?? _tags,
        type: type ?? _type,
      );
  num? get id => _id;
  String? get title => _title;
  String? get video_id => _video_id;
  String? get content => _content;
  get thumbnail => _thumbnail;
  String? get embedLink => _embedLink;
  Color? get color => _color;
  List<String>? get categories => _categories;
  List<dynamic>? get tags => _tags;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['video_id'] = _video_id;
    map['content'] = _content;
    map['thumbnail'] = _thumbnail;
    map['embed_link'] = _embedLink;
    map['categories'] = _categories;
    if (_tags != null) {
      map['tags'] = _tags!.map((v) => v.toJson()).toList();
    }
    map['type'] = _type;
    return map;
  }
}
