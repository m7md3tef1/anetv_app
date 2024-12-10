import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/search/presentation/view/widget/search_view_body.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({
    super.key, required this.catogry,
  });

  final String catogry;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: SearchViewBody(
        catogry: catogry,
      )),
    );
  }
}
