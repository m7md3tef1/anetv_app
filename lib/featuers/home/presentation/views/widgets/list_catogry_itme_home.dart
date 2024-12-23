import 'dart:convert';

import 'package:anetv/core/utils/app_router.dart';
import 'package:anetv/core/utils/assets.dart';
import 'package:anetv/featuers/home/data/models/catogry_itme_model.dart';
import 'package:anetv/featuers/home/data/repo/addCubit.dart';
import 'package:anetv/featuers/home/data/repo/addState.dart';
import 'package:anetv/featuers/home/data/repo/all_movies_home_repo_impl.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:anetv/featuers/home/presentation/views/widgets/catogry_itme_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../data/repo/sql_helper.dart';

void launchUrlStatic(String url) async {
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

class ListCategoryItemHome extends StatefulWidget {
  const ListCategoryItemHome({super.key});

  @override
  State<ListCategoryItemHome> createState() => _ListCategoryItemHomeState();
}

class _ListCategoryItemHomeState extends State<ListCategoryItemHome>
    with SingleTickerProviderStateMixin {
  List<CatogryItmeModel> listCategory1 = [
    CatogryItmeModel(
        id: 1,
        image: AssetsData.movies,
        title: 'search',
        catogry: 'search',
        color: Colors.black),
    CatogryItmeModel(
        id: 2,
        image: AssetsData.movies,
        title: 'reset',
        catogry: 'reset',
        color: Colors.black),
    CatogryItmeModel(
        id: 3,
        image: AssetsData.movies,
        title: 'update',
        catogry: 'update',
        color: Colors.black),
    // CatogryItmeModel(
    //     id: 4,
    //     image: AssetsData.movies,
    //     title: 'All Movies',
    //     catogry: 'movies',
    //     color: Colors.black),
    // CatogryItmeModel(
    //     id: 5,
    //     image: AssetsData.movies,
    //     title: '1',
    //     catogry: '1',
    //     color: Colors.black),
    CatogryItmeModel(
        id: 6,
        image: AssetsData.christmas2024,
        title: 'Christmas 2024',
        color: Colors.black,
        catogry: 'Christmas-Movies-2024'),
    CatogryItmeModel(
        id: 7,
        image: AssetsData.movies,
        title: '2',
        catogry: '2',
        color: Colors.black),
    CatogryItmeModel(
        id: 8,
        image: AssetsData.arabicMovies,
        title: 'افلام عربي',
        color: Colors.black,
        catogry: 'افلام%20عربي'),
    CatogryItmeModel(
        id: 9,
        image: AssetsData.movies,
        title: '3',
        catogry: '3',
        color: Colors.black),
    CatogryItmeModel(
        id: 10,
        image: AssetsData.movTvSeriesies,
        title: 'Tv-series',
        color: Colors.black,
        catogry: 'https://alaanetstreaming.com/api/series/?page=Page'),
    CatogryItmeModel(
        id: 11,
        image: AssetsData.movies,
        title: '4',
        catogry: '4',
        color: Colors.black),
    CatogryItmeModel(
        id: 12,
        image: AssetsData.kidsFamily,
        title: 'Kids & Family',
        catogry: 'kids-family',
        color: Colors.black),
    CatogryItmeModel(
        id: 13,
        image: AssetsData.movies,
        title: '5',
        catogry: '5',
        color: Colors.black),
    CatogryItmeModel(
        id: 14,
        image: AssetsData.translatedTurkishSeries,
        title: 'مسلسلات تركية مترجمة',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D9%85%D8%B3%D9%84%D8%B3%D9%84%D8%A7%D8%AA%20%D8%AA%D8%B1%D9%83%D9%8A%D8%A9%20%D9%85%D8%AA%D8%B1%D8%AC%D9%85%D8%A9&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 15,
        image: AssetsData.movies,
        title: '6',
        catogry: '6',
        color: Colors.black),
    CatogryItmeModel(
        id: 16,
        image: AssetsData.dubbedTurkishSeries,
        title: 'مسلسلات تركية مدبلجة',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D8%AA%D8%B1%D9%83%D9%8A-%D9%85%D8%AF%D8%A8%D9%84%D8%AC&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 17,
        image: AssetsData.movies,
        title: '7',
        catogry: '7',
        color: Colors.black),
    CatogryItmeModel(
        id: 18,
        image: AssetsData.arabicSeries,
        title: 'مسلسلات عربية',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D9%85%D8%B3%D9%84%D8%B3%D9%84%D8%A7%D8%AA%20%D8%B9%D8%B1%D8%A8%D9%8A%D8%A9&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 19,
        image: AssetsData.movies,
        title: '8',
        catogry: '8',
        color: Colors.black),
    CatogryItmeModel(
        id: 20,
        image: AssetsData.cartoonDubbed,
        title: 'كرتون مدبلج',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D8%B1%D8%B3%D9%88%D9%85-%D9%85%D8%AF%D8%A8%D9%84%D8%AC%D8%A9&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 21,
        image: AssetsData.movies,
        title: '9',
        catogry: '9',
        color: Colors.black),
  ];
  List<CatogryItmeModel> listCategory = [
    CatogryItmeModel(
        id: 1,
        image: AssetsData.movies,
        title: 'search',
        catogry: 'search',
        color: Colors.black),
    CatogryItmeModel(
        id: 2,
        image: AssetsData.movies,
        title: 'reset',
        catogry: 'reset',
        color: Colors.black),
    CatogryItmeModel(
        id: 3,
        image: AssetsData.movies,
        title: 'update',
        catogry: 'update',
        color: Colors.black),
    CatogryItmeModel(
        id: 4,
        image: AssetsData.movies,
        title: 'All Movies',
        catogry: 'movies',
        color: Colors.black),
    CatogryItmeModel(
        id: 5,
        image: AssetsData.movies,
        title: '1',
        catogry: '1',
        color: Colors.black),
    CatogryItmeModel(
        id: 6,
        image: AssetsData.christmas2024,
        title: 'Christmas 2024',
        color: Colors.black,
        catogry: 'Christmas-Movies-2024'),
    CatogryItmeModel(
        id: 7,
        image: AssetsData.movies,
        title: '2',
        catogry: '2',
        color: Colors.black),
    CatogryItmeModel(
        id: 8,
        image: AssetsData.arabicMovies,
        title: 'افلام عربي',
        color: Colors.black,
        catogry: 'افلام%20عربي'),
    CatogryItmeModel(
        id: 9,
        image: AssetsData.movies,
        title: '3',
        catogry: '3',
        color: Colors.black),
    CatogryItmeModel(
        id: 10,
        image: AssetsData.movTvSeriesies,
        title: 'Tv-series',
        color: Colors.black,
        catogry: 'https://alaanetstreaming.com/api/series/?page=Page'),
    CatogryItmeModel(
        id: 11,
        image: AssetsData.movies,
        title: '4',
        catogry: '4',
        color: Colors.black),
    CatogryItmeModel(
        id: 12,
        image: AssetsData.kidsFamily,
        title: 'Kids & Family',
        catogry: 'kids-family',
        color: Colors.black),
    CatogryItmeModel(
        id: 13,
        image: AssetsData.movies,
        title: '5',
        catogry: '5',
        color: Colors.black),
    CatogryItmeModel(
        id: 14,
        image: AssetsData.translatedTurkishSeries,
        title: 'مسلسلات تركية مترجمة',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D9%85%D8%B3%D9%84%D8%B3%D9%84%D8%A7%D8%AA%20%D8%AA%D8%B1%D9%83%D9%8A%D8%A9%20%D9%85%D8%AA%D8%B1%D8%AC%D9%85%D8%A9&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 15,
        image: AssetsData.movies,
        title: '6',
        catogry: '6',
        color: Colors.black),
    CatogryItmeModel(
        id: 16,
        image: AssetsData.dubbedTurkishSeries,
        title: 'مسلسلات تركية مدبلجة',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D8%AA%D8%B1%D9%83%D9%8A-%D9%85%D8%AF%D8%A8%D9%84%D8%AC&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 17,
        image: AssetsData.movies,
        title: '7',
        catogry: '7',
        color: Colors.black),
    CatogryItmeModel(
        id: 18,
        image: AssetsData.arabicSeries,
        title: 'مسلسلات عربية',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D9%85%D8%B3%D9%84%D8%B3%D9%84%D8%A7%D8%AA%20%D8%B9%D8%B1%D8%A8%D9%8A%D8%A9&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 19,
        image: AssetsData.movies,
        title: '8',
        catogry: '8',
        color: Colors.black),
    CatogryItmeModel(
        id: 20,
        image: AssetsData.cartoonDubbed,
        title: 'كرتون مدبلج',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D8%B1%D8%B3%D9%88%D9%85-%D9%85%D8%AF%D8%A8%D9%84%D8%AC%D8%A9&page=Page',
        color: Colors.black),
    CatogryItmeModel(
        id: 21,
        image: AssetsData.movies,
        title: '9',
        catogry: '9',
        color: Colors.black),
  ];
  var i = 0;
  final List<FocusNode?> _focusNode = [];
  _setFirstFocus(BuildContext context) {
    if (_focusNode[0] == null) {
      for (int i = 1; i < _focusNode.length; i++) {
        _focusNode[i] = FocusNode(descendantsAreFocusable: false);
      }
      FocusScope.of(context).requestFocus(_focusNode[0]);
    }
  }

  _changFocus(BuildContext context, FocusNode node, index) {
    FocusScope.of(context).requestFocus(node);
    setState(() {
      listCategory[i].color = Colors.transparent;
      listCategory[index].color = Colors.white;
      scrollToIndex(index);
      i = index;
    });
  }

  List<CatogryItmeModel> tasks = [];
  DBHelper db = DBHelper();
  getTasks() async {
    _focusNode.clear();
    // for (int i = 0; i < listCatogry.length; i++) {
    //   // db.insertTask(CatogryItmeModel(
    //   //     title: listCatogry[i].title!,
    //   //     catogry: listCatogry[i].catogry!,
    //   //     id: listCatogry[i].id,
    //   //     image: listCatogry[i].image!));
    //   // print("kkkkkk");
    //   _focusNode.add(FocusNode());
    // }
    await db.getAllTasks().then((v) {
      print("kkkkkk5555");
      print("${tasks.length}");
      setState(() {
        tasks = v;

        if (tasks.isEmpty) {
          for (int i = 0; i < listCategory.length; i++) {
            db.insertTask(CatogryItmeModel(
                title: listCategory[i].title!,
                catogry: listCategory[i].catogry!,
                id: listCategory[i].id,
                image: listCategory[i].image!));
            // print("kkkkkk");
            _focusNode.add(FocusNode());
          }
          db.getAllTasks().then(
            (value) {
              tasks = value;
              listCategory = tasks;
              FocusScope.of(context).requestFocus(_focusNode[0]);
            },
          );
        } else {
          // print("kkkkkk1111111111111");
          for (int i = 0; i < tasks.length; i++) {
            // print("kkkkkk");
            _focusNode.add(FocusNode());
          }
          listCategory = tasks;
          FocusScope.of(context).requestFocus(_focusNode[0]);
        }
      });
    });
  }

  @override
  void initState() {
    getTasks();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.clear();
  }

  final double _itemHeight = 1.0; // Assuming each item has a fixed height
  void scrollToIndex(int index) {
    double offset = _itemHeight * index;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // if(_focusNode.isEmpty){
    //   // _focusNode.clear();
    // listCatogry=listCatogry1;
    //   for (int i = 0; i < listCatogry1.length; i++) {
    //     _focusNode.add(FocusNode());
    //   }
    // if (_focusNode[0] == null) {
    // listCategory = listCategory1;
    // for (int i = 0; i < listCategory1.length; i++) {
    //   _focusNode.add(FocusNode());
    // }
    //   FocusScope.of(context).requestFocus(_focusNode[0]);
    //   _setFirstFocus(context);
    // }
    // }
    return BlocConsumer<FavCubit, FavState>(
      builder: (context, state) {
        return ActionHandler().handleArrowAndEnterAction(
          child: SizedBox(
            child: _focusNode.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: listCategory.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          page = 1;
                          page == 1;
                          index == 0
                              ? ""
                              : index == 1
                                  ? {
                                      for (int i = 0;
                                          i < listCategory1.length;
                                          i++)
                                        {
                                          db.insertTask(CatogryItmeModel(
                                              title: listCategory1[i].title!,
                                              catogry:
                                                  listCategory1[i].catogry!,
                                              id: listCategory1[i].id,
                                              image: listCategory1[i].image!)),
                                        },
                                      FavCubit.get(context).addProduct(),
                                    }
                                  : GoRouter.of(context).push(
                                      AppRouter.kSearchView,
                                      extra: listCategory[index]);
                        },
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              bottom: 10, top: 0, start: 10),
                          child: Actions(
                            actions: <Type, Action<Intent>>{
                              DownButtonIntent:
                                  CallbackAction<DownButtonIntent>(
                                      onInvoke: (intent) {
                                return _changFocus(
                                    context,
                                    _focusNode[listCategory.last.id ==
                                            listCategory[index].id
                                        ? 0
                                        : index + 1]!,
                                    listCategory.last.title ==
                                            listCategory[index].title
                                        ? 0
                                        : index + 1);
                              }),
                              UpButtonIntent: CallbackAction<UpButtonIntent>(
                                  onInvoke: (intent) {
                                return _changFocus(
                                    context,
                                    _focusNode[listCategory.first.id ==
                                            listCategory[index].id
                                        ? 0
                                        : index - 1]!,
                                    listCategory.first.id ==
                                            listCategory[index].id
                                        ? 0
                                        : index - 1);
                              }),
                              EnterButtonIntent:
                                  CallbackAction<EnterButtonIntent>(
                                onInvoke: (intent) {
                                  print(jsonEncode(listCategory[index + 1]));
                                  print(jsonEncode(listCategory[index]));
                                  page = 1;
                                  page == 1;
                                  index == 0
                                      ? GoRouter.of(context)
                                          .push(AppRouter.kSearch)
                                      : listCategory[index + 1].title == "1" ||
                                              listCategory[index + 1].title ==
                                                  "2" ||
                                              listCategory[index + 1].title ==
                                                  "3" ||
                                              listCategory[index + 1].title ==
                                                  "4" ||
                                              listCategory[index + 1].title ==
                                                  "5" ||
                                              listCategory[index + 1].title ==
                                                  "6" ||
                                              listCategory[index + 1].title ==
                                                  "7" ||
                                              listCategory[index + 1].title ==
                                                  "8" ||
                                              listCategory[index + 1].title ==
                                                  "9"
                                          ? {
                                              db.deleteTask(
                                                  listCategory[index]),
                                              db.deleteTask(
                                                  listCategory[index + 1]),
                                              FavCubit.get(context)
                                                  .addProduct(),
                                            }
                                          : listCategory[index].title == "reset"
                                              ? showDialog(
                                                  useRootNavigator: false,
                                                  useSafeArea: true,
                                                  context: context,
                                                  builder: (dialogContext) {
                                                    final TextEditingController
                                                        controller =
                                                        TextEditingController();
                                                    return ActionHandler()
                                                        .handleArrowAndEnterAction3(
                                                      child: Actions(
                                                        actions: <Type,
                                                            Action<Intent>>{
                                                          CloseButtonIntent:
                                                              CallbackAction<
                                                                  CloseButtonIntent>(
                                                            onInvoke: (intent) {
                                                              return Navigator
                                                                  .pop(context);
                                                            },
                                                          )
                                                        },
                                                        child: AlertDialog(
                                                            insetPadding:
                                                                EdgeInsets.zero,
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            titlePadding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10,
                                                                    right: 10,
                                                                    top: 10,
                                                                    bottom: 10),
                                                            shape: const RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    color: Color(
                                                                        0xFFD6CECE),
                                                                    width: 1),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                            content:
                                                                StatefulBuilder(
                                                              builder: (context,
                                                                  setState) {
                                                                return SizedBox(
                                                                  height: 100.h,
                                                                  width: .8.sw,
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .all(
                                                                            8.0),
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              controller,
                                                                          textInputAction:
                                                                              TextInputAction.done,
                                                                          autofocus:
                                                                              false,
                                                                          onFieldSubmitted:
                                                                              (value) {
                                                                            if (value.toString().trim() ==
                                                                                "Anettva1") {
                                                                              for (int i = 0; i < listCategory1.length; i++) {
                                                                                db.insertTask(CatogryItmeModel(title: listCategory1[i].title!, catogry: listCategory1[i].catogry!, id: listCategory1[i].id, image: listCategory1[i].image!));
                                                                              }
                                                                              FavCubit.get(context).addProduct();
                                                                              Navigator.pop(context);
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                                  backgroundColor: Colors.red,
                                                                                  content: Text(
                                                                                    "Password Is Wrong",
                                                                                    style: TextStyle(fontSize: 15.sp, color: Colors.white),
                                                                                  )));
                                                                            }
                                                                          },
                                                                          onChanged:
                                                                              (value) {},
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            labelText:
                                                                                "Enter Password To Reset",
                                                                            border:
                                                                                OutlineInputBorder(),
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
                                                  })
                                              : listCategory[index].title ==
                                                      "update"
                                                  ? launchUrlStatic(
                                                      "https://aneting.net/ANETV%202.apk")
                                                  : GoRouter.of(context).push(
                                                      AppRouter.kSearchView,
                                                      extra: listCategory[
                                                          index - 1]);
                                  return listCategory[index].color;
                                },
                              )
                            },
                            child: Focus(
                              focusNode: _focusNode[index],
                              child: CatogryItmeHome(
                                images: listCategory[index].image!,
                                title: listCategory[index].title!,
                                title1:
                                    listCategory[index < 3 ? index : index - 1]
                                        .title!,
                                color: listCategory[index].color!,
                                index: index,
                                listCatogry: listCategory,
                                listCatogry1: listCategory1,
                                colorUpdate: listCategory[2].color!,
                                colorReset: listCategory[1].color!,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ),
        );
      },
      listener: (BuildContext context, FavState state) {
        if (state is AddFav) {
          // print("favvvvvvvvvvvvvvvv");
          db.getAllTasks().then(
            (value) {
              setState(() {
                tasks = value;
                listCategory = tasks;
                _focusNode.clear();
                for (int i = 0; i < listCategory.length; i++) {
                  _focusNode.add(FocusNode());
                }
              });
            },
          );
        }
      },
    );
  }
}
// width: width * .9,
//       height: height * .25,
