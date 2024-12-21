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
      required this.colorUpdate,
      required this.color});

  final String images;
  final String title;
  final Color color;
  final Color colorUpdate;

  @override
  Widget build(BuildContext context) {
    return title == "search"
        ? Padding(
          padding: const EdgeInsets.only(right: 5.0,left: 5,top: 10),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kSearch);
                    },
                    child: Container(
                      width: 200,
                        decoration: BoxDecoration(
                          color: color == Colors.white
                              ? Colors.black
                              : Colors.transparent,
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
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    GoRouter.of(context).push(AppRouter.kSearch);
                  },
                  child: Container(
                    width: 100,
                      decoration: BoxDecoration(
                        color: colorUpdate == Colors.white
                            ? Colors.black
                            : Colors.transparent,
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
                          "Update",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: colorUpdate == Colors.white
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )),
                ),
              ],
            ),
        )
        : title == "update"
            ? const SizedBox()
            : Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      color:
                          color == Colors.white ? Colors.white : Colors.black),
                ),
              );
  }
}
