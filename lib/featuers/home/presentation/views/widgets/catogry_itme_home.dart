import 'package:anetv/featuers/home/data/repo/addCubit.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:anetv/featuers/search/presentation/view/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../search/presentation/view/widget/custom_search_text_field.dart';
import '../../../data/models/catogry_itme_model.dart';
import '../../../data/repo/all_movies_home_repo_impl.dart';
import '../../../data/repo/sql_helper.dart';
import 'list_catogry_itme_home.dart';

class CatogryItmeHome extends StatefulWidget {
  const CatogryItmeHome({
    super.key,
    required this.images,
    required this.title,
    required this.title1,
    required this.colorUpdate,
    required this.colorReset,
    required this.color,
    required this.index,
    // this.color1,
    // this.color2,
    // this.color3,
    // this.color4,
    // this.color5,
    // this.color6,
    // this.color7,
    // this.color8,
    required this.listCatogry,
    required this.listCatogry1,
    // this.color9,
  });

  final String images;
  final String title;
  final String title1;
  final Color color;
  final int index;
  final Color colorUpdate;
  final Color colorReset;
  // final Color? color1;
  // final Color? color2;
  // final Color? color3;
  // final Color? color4;
  // final Color? color5;
  // final Color? color6;
  // final Color? color7;
  // final Color? color8;
  // final Color? color9;
  final List<CatogryItmeModel> listCatogry;
  final List<CatogryItmeModel> listCatogry1;

  @override
  State<CatogryItmeHome> createState() => _CatogryItmeHomeState();
}

class _CatogryItmeHomeState extends State<CatogryItmeHome> {
  DBHelper db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return widget.title == "search"
        ? Padding(
            padding: const EdgeInsets.only(right: 5.0, left: 5, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      page = 1;
                      page == 1;
                      GoRouter.of(context).push(AppRouter.kSearch);
                    },
                    child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color: widget.color == Colors.white
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
                                color: widget.color == Colors.white
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        )),
                  ),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    showDialog(
                        useRootNavigator: false,
                        useSafeArea: true,
                        context: context,
                        builder: (dialogContext) {
                          final TextEditingController controller =
                              TextEditingController();
                          return ActionHandler().handleArrowAndEnterAction3(
                            child: Actions(
                              actions: <Type, Action<Intent>>{
                                CloseButtonIntent:
                                    CallbackAction<CloseButtonIntent>(
                                  onInvoke: (intent) {
                                    return Navigator.pop(context);
                                  },
                                )
                              },
                              child: AlertDialog(
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  titlePadding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10, bottom: 10),
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFD6CECE), width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return SizedBox(
                                        height: 100.h,
                                        width: .8.sw,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: controller,
                                                autofocus: false,
                                                onFieldSubmitted: (value) {
                                                  if (value.toString().trim() ==
                                                      "Anettva1") {
                                                    for (int i = 0;
                                                        i <
                                                            widget.listCatogry1
                                                                .length;
                                                        i++) {
                                                      db.insertTask(
                                                          CatogryItmeModel(
                                                              title: widget
                                                                  .listCatogry1[
                                                                      i]
                                                                  .title!,
                                                              catogry: widget
                                                                  .listCatogry1[
                                                                      i]
                                                                  .catogry!,
                                                              id: widget
                                                                  .listCatogry1[
                                                                      i]
                                                                  .id,
                                                              image: widget
                                                                  .listCatogry1[
                                                                      i]
                                                                  .image!));
                                                    }
                                                    FavCubit.get(context)
                                                        .addProduct();
                                                    Navigator.pop(context);
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                Colors.red,
                                                            content: Text(
                                                              "Password Is Wrong",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  color: Colors
                                                                      .white),
                                                            )));
                                                  }
                                                },
                                                // focusNode: _focusNode,
                                                onChanged: (value) {
                                                  // print("value");
                                                  // print(value);
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      "Enter Password To Reset",
                                                  border: OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )),
                            ),
                          );
                        });
                  },
                  child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: widget.colorReset == Colors.white
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
                          "Reset",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.colorReset == Colors.white
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    launchUrlStatic("https://aneting.net/ANETV%202.apk");
                  },
                  child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: widget.colorUpdate == Colors.white
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
                              color: widget.colorUpdate == Colors.white
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )),
                ),
              ],
            ),
          )
        : widget.title == "update" || widget.title == "reset"
            ? const SizedBox()
            : widget.title == "1"
                ? Row(
                    children: [
                      InkWell(
                        onTap: () {
                          db.deleteTask(widget.listCatogry[widget.index]);
                          db.deleteTask(widget.listCatogry[widget.index - 1]);
                          FavCubit.get(context).addProduct();
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color:
                                  widget.listCatogry[widget.index - 1].color ==
                                          Colors.white
                                      ? Colors.black
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 5,
                                    offset: const Offset(0, 3)),
                              ],
                            ),
                            child: const Icon(Icons.clear, color: Colors.red)),
                      ),
                      SizedBox(width: 5.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            page = 1;
                            page == 1;
                            GoRouter.of(context).push(AppRouter.kSearchView,
                                extra: widget.listCatogry[widget.index - 1]);
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: widget.color == Colors.white
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
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
                              widget.title1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: widget.color == Colors.white
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w)
                    ],
                  )
                : widget.title == "2"
                    ? Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                db.deleteTask(widget.listCatogry[widget.index]);
                                db.deleteTask(
                                    widget.listCatogry[widget.index - 1]);
                                FavCubit.get(context).addProduct();
                              });
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: widget.listCatogry[widget.index - 1]
                                              .color ==
                                          Colors.white
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3)),
                                  ],
                                ),
                                child:
                                    const Icon(Icons.clear, color: Colors.red)),
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                page = 1;
                                page == 1;
                                GoRouter.of(context).push(AppRouter.kSearchView,
                                    extra:
                                        widget.listCatogry[widget.index - 1]);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: widget.color == Colors.white
                                      ? Colors.black
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3)),
                                  ],
                                ),
                                child: Text(
                                  widget.title1,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: widget.color == Colors.white
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5.w)
                        ],
                      )
                    : widget.title == "3"
                        ? Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  db.deleteTask(
                                      widget.listCatogry[widget.index]);
                                  db.deleteTask(
                                      widget.listCatogry[widget.index - 1]);
                                  FavCubit.get(context).addProduct();
                                },
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: widget.listCatogry[widget.index-1].color ==
                                              Colors.white
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 5,
                                            offset: const Offset(0, 3)),
                                      ],
                                    ),
                                    child: const Icon(Icons.clear,
                                        color: Colors.red)),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    page = 1;
                                    page == 1;
                                    GoRouter.of(context).push(
                                        AppRouter.kSearchView,
                                        extra: widget
                                            .listCatogry[widget.index - 1]);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: widget
                                                  .color ==
                                              Colors.white
                                          ? Colors.black
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                      widget.title1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: widget.color == Colors.white
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w)
                            ],
                          )
                        : widget.title == "4"
                            ? Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      db.deleteTask(
                                          widget.listCatogry[widget.index]);
                                      db.deleteTask(
                                          widget.listCatogry[widget.index - 1]);
                                      FavCubit.get(context).addProduct();
                                    },
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: widget
                                                      .listCatogry[
                                                          widget.index - 1]
                                                      .color ==
                                                  Colors.white
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                blurRadius: 5,
                                                offset: const Offset(0, 3)),
                                          ],
                                        ),
                                        child: const Icon(Icons.clear,
                                            color: Colors.red)),
                                  ),
                                  SizedBox(width: 5.w),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        page = 1;
                                        page == 1;
                                        GoRouter.of(context).push(
                                            AppRouter.kSearchView,
                                            extra: widget
                                                .listCatogry[widget.index - 1]);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: widget.color == Colors.white
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          widget.title1,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  widget.color == Colors.white
                                                      ? Colors.white
                                                      : Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.w)
                                ],
                              )
                            : widget.title == "5"
                                ? Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          db.deleteTask(
                                              widget.listCatogry[widget.index]);
                                          db.deleteTask(widget
                                              .listCatogry[widget.index - 1]);
                                          FavCubit.get(context).addProduct();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color: widget
                                                          .listCatogry[
                                                              widget.index - 1]
                                                          .color ==
                                                      Colors.white
                                                  ? Colors.black
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 3)),
                                              ],
                                            ),
                                            child: const Icon(Icons.clear,
                                                color: Colors.red)),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            page = 1;
                                            page == 1;
                                            GoRouter.of(context).push(
                                                AppRouter.kSearchView,
                                                extra: widget.listCatogry[
                                                    widget.index - 1]);
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 10),
                                            decoration: BoxDecoration(
                                              color:
                                                  widget.color == Colors.white
                                                      ? Colors.black
                                                      : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              widget.title1,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: widget.color ==
                                                          Colors.white
                                                      ? Colors.white
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w)
                                    ],
                                  )
                                : widget.title == "6"
                                    ? Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              db.deleteTask(widget
                                                  .listCatogry[widget.index]);
                                              db.deleteTask(widget.listCatogry[
                                                  widget.index - 1]);
                                              FavCubit.get(context)
                                                  .addProduct();
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: widget
                                                              .listCatogry[
                                                                  widget.index -
                                                                      1]
                                                              .color ==
                                                          Colors.white
                                                      ? Colors.black
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        blurRadius: 5,
                                                        offset:
                                                            const Offset(0, 3)),
                                                  ],
                                                ),
                                                child: const Icon(Icons.clear,
                                                    color: Colors.red)),
                                          ),
                                          SizedBox(width: 5.w),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                page = 1;
                                                page == 1;
                                                GoRouter.of(context).push(
                                                    AppRouter.kSearchView,
                                                    extra: widget.listCatogry[
                                                        widget.index - 1]);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                decoration: BoxDecoration(
                                                  color: widget.color ==
                                                          Colors.white
                                                      ? Colors.black
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 2),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  widget.title1,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: widget.color ==
                                                              Colors.white
                                                          ? Colors.white
                                                          : Colors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.w)
                                        ],
                                      )
                                    : widget.title == "7"
                                        ? Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  db.deleteTask(
                                                      widget.listCatogry[
                                                          widget.index]);
                                                  db.deleteTask(
                                                      widget.listCatogry[
                                                          widget.index - 1]);
                                                  FavCubit.get(context)
                                                      .addProduct();
                                                },
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: widget
                                                                  .listCatogry[
                                                                      widget.index -
                                                                          1]
                                                                  .color ==
                                                              Colors.white
                                                          ? Colors.black
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3)),
                                                      ],
                                                    ),
                                                    child: const Icon(
                                                        Icons.clear,
                                                        color: Colors.red)),
                                              ),
                                              SizedBox(width: 5.w),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    page = 1;
                                                    page == 1;
                                                    GoRouter.of(context).push(
                                                        AppRouter.kSearchView,
                                                        extra: widget
                                                                .listCatogry[
                                                            widget.index - 1]);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: widget.color ==
                                                              Colors.white
                                                          ? Colors.black
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 2),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          blurRadius: 5,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      widget.title1,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: widget.color ==
                                                                  Colors.white
                                                              ? Colors.white
                                                              : Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 5.w)
                                            ],
                                          )
                                        : widget.title == "8"
                                            ? Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      db.deleteTask(
                                                          widget.listCatogry[
                                                              widget.index]);
                                                      db.deleteTask(widget
                                                              .listCatogry[
                                                          widget.index - 1]);
                                                      FavCubit.get(context)
                                                          .addProduct();
                                                    },
                                                    child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: widget
                                                                      .listCatogry[
                                                                          widget.index -
                                                                              1]
                                                                      .color ==
                                                                  Colors.white
                                                              ? Colors.black
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                blurRadius: 5,
                                                                offset:
                                                                    const Offset(
                                                                        0, 3)),
                                                          ],
                                                        ),
                                                        child: const Icon(
                                                            Icons.clear,
                                                            color: Colors.red)),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Expanded(
                                                    child: InkWell(
                                                      onTap: () {
                                                        page = 1;
                                                        page == 1;
                                                        GoRouter.of(context).push(
                                                            AppRouter
                                                                .kSearchView,
                                                            extra: widget
                                                                    .listCatogry[
                                                                widget.index -
                                                                    1]);
                                                      },
                                                      child: Container(
                                                        width: double.infinity,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 20,
                                                                vertical: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: widget.color ==
                                                                  Colors.white
                                                              ? Colors.black
                                                              : Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 2),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Text(
                                                          widget.title1,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: widget
                                                                          .color ==
                                                                      Colors
                                                                          .white
                                                                  ? Colors.white
                                                                  : Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.w)
                                                ],
                                              )
                                            : widget.title == "9"
                                                ? Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          db.deleteTask(widget
                                                                  .listCatogry[
                                                              widget.index]);
                                                          db.deleteTask(widget
                                                                  .listCatogry[
                                                              widget.index -
                                                                  1]);
                                                          FavCubit.get(context)
                                                              .addProduct();
                                                        },
                                                        child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: widget
                                                                          .listCatogry[widget.index -
                                                                              1]
                                                                          .color ==
                                                                      Colors
                                                                          .white
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    blurRadius:
                                                                        5,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            3)),
                                                              ],
                                                            ),
                                                            child: const Icon(
                                                                Icons.clear,
                                                                color: Colors
                                                                    .red)),
                                                      ),
                                                      SizedBox(width: 5.w),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            page = 1;
                                                            page == 1;
                                                            GoRouter.of(context).push(
                                                                AppRouter
                                                                    .kSearchView,
                                                                extra: widget
                                                                        .listCatogry[
                                                                    widget.index -
                                                                        1]);
                                                          },
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20,
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: widget
                                                                          .color ==
                                                                      Colors
                                                                          .white
                                                                  ? Colors.black
                                                                  : Colors
                                                                      .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 2),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  blurRadius: 5,
                                                                  offset:
                                                                      const Offset(
                                                                          0, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Text(
                                                              widget.title1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: widget
                                                                              .color ==
                                                                          Colors
                                                                              .white
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 5.w)
                                                    ],
                                                  )
                                                : const SizedBox();
  }
}
