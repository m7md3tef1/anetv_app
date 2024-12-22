import 'package:anetv/core/utils/styels.dart';
import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo_impl.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';
import 'package:anetv/featuers/search/presentation/view/widget/custom_search_text_field.dart';
import 'package:anetv/featuers/search/presentation/view/widget/episodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../home/data/models/catogry_itme_model.dart';
import 'moves_list.dart';

class SearchViewBody extends StatefulWidget {
  SearchViewBody({super.key, required this.category, this.cat});

  final CatogryItmeModel category;
  var cat;
  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  @override
  void initState() {
    BlocProvider.of<AllMoviesCubit>(context).fetchMovie(
        catogry: widget.cat != null ? widget.cat : widget.category.catogry);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Center(
                      child: Text(
                        widget.cat != null ? "Search" : widget.category.title!,
                        style: Styels.textStyle20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Search Result',
                  style: Styels.textStyle18,
                ),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          child: widget.cat != null
              ? MovesList("search")
              : widget.category.catogry
                      .toString()
                      .contains("https://alaanetstreaming.com")
                  ? EpisodesList(widget.category.catogry)
                  : MovesList(widget.category.catogry),
        ),
      ],
    );
  }
}
