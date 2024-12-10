import 'package:anetv/core/utils/styels.dart';
import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';
import 'package:anetv/featuers/search/presentation/view/widget/custom_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'moves_list.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  @override
  void initState() {
    BlocProvider.of<AllMoviesCubit>(context)
        .fetchMovie(catogry: widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text(
                  'Search Result',
                  style: Styels.textStyle18,
                ),
                SizedBox(height: 10)
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: MovesList(),
        ),
      ],
    );
  }
}
