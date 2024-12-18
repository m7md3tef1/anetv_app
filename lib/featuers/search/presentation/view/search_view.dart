import 'package:anetv/featuers/home/data/models/movie_model.dart';
import 'package:anetv/featuers/search/presentation/view/widget/search_view_body.dart';
import 'package:flutter/material.dart';

import '../../../home/data/models/catogry_itme_model.dart';
import '../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';

class SearchView extends StatelessWidget {
    SearchView({
    super.key,
    required this.catogry,
    this.cat,
  });

  final CatogryItmeModel catogry;
var cat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ActionHandler().handleArrowAndEnterAction(
        child: Actions(
          actions: <Type, Action<Intent>>{
            CloseButtonIntent: CallbackAction<CloseButtonIntent>(
              onInvoke: (intent) {
                return Navigator.pop(context);
              },
            )
          },
          child: SafeArea(
              child: SearchViewBody(
            category: catogry,
                cat: cat
          )),
        ),
      ),
    );
  }
}
