import 'package:anetv/featuers/search/presentation/view/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../search/presentation/view/widget/custom_search_text_field.dart';

class CatogryItmeHome extends StatelessWidget {
  const CatogryItmeHome(
      {super.key,
      required this.images,
      required this.title,
      required this.color});

  final String images;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return title == "search"
        ? InkWell(
            onTap: () {
              GoRouter.of(context).push(AppRouter.kSearch);
            },
            child: Container(
                decoration: BoxDecoration(
                  color:
                      color == Colors.white ? Colors.black : Colors.transparent,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10),
                  child: Text(
                    "Search",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color == Colors.white
                            ? Colors.white
                            : Colors.black),
                  ),
                )),
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: color == Colors.white ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color == Colors.white ? Colors.white : Colors.black),
            ),
          );
  }
}
