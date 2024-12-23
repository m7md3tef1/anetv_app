import 'package:anetv/featuers/home/presentation/views/widgets/list_catogry_itme_home.dart';
import 'package:flutter/material.dart';

import '../../../../search/presentation/view/widget/custom_search_text_field.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              ListCategoryItemHome(),
            ],
          ),
        ),
      ],
    );
  }
}
