import 'package:anetv/core/utils/app_router.dart';
import 'package:anetv/core/utils/assets.dart';
import 'package:anetv/featuers/home/data/models/catogry_itme_model.dart';
import 'package:anetv/featuers/home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import 'package:anetv/featuers/home/presentation/views/widgets/catogry_itme_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class ListCatogryItmeHome extends StatefulWidget {
  const ListCatogryItmeHome({super.key});

  @override
  State<ListCatogryItmeHome> createState() => _ListCatogryItmeHomeState();
}

class _ListCatogryItmeHomeState extends State<ListCatogryItmeHome> {
  List<CatogryItmeModel> listCatogry = [
    CatogryItmeModel(
        image: AssetsData.movies,
        title: 'All Movies',
        catogry: 'movies',
        color: Colors.black),
    CatogryItmeModel(
        image: AssetsData.christmas2024,
        title: 'Christmas 2024',
        color: Colors.black,
        catogry: 'Christmas-Movies-2024'),
    CatogryItmeModel(
        image: AssetsData.arabicMovies,
        title: 'افلام عربي',
        color: Colors.black,
        catogry: 'D8%A7%D9%81%D9%84%D8%A7%D9%85%20%D8%B9%D8%B1%D8%A8%D9%8A'),
    CatogryItmeModel(
        image: AssetsData.movTvSeriesies,
        title: 'Tv-series',
        color: Colors.black,
        catogry: 'https://alaanetstreaming.com/api/series/'),
    CatogryItmeModel(
        image: AssetsData.kidsFamily,
        title: 'Kids & Family',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=Kids-family',
        color: Colors.black),
    CatogryItmeModel(
        image: AssetsData.translatedTurkishSeries,
        title: 'مسلسلات تركية مترجمة',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D9%85%D8%B3%D9%84%D8%B3%D9%84%D8%A7%D8%AA%20%D8%AA%D8%B1%D9%83%D9%8A%D8%A9%20%D9%85%D8%AA%D8%B1%D8%AC%D9%85%D8%A9',
        color: Colors.black),
    CatogryItmeModel(
        image: AssetsData.dubbedTurkishSeries,
        title: 'مسلسلات تركية مدبلجة',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D8%AA%D8%B1%D9%83%D9%8A-%D9%85%D8%AF%D8%A8%D9%84%D8%AC',
        color: Colors.black),
    CatogryItmeModel(
        image: AssetsData.arabicSeries,
        title: 'مسلسلات عربية',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D9%85%D8%B3%D9%84%D8%B3%D9%84%D8%A7%D8%AA%20%D8%B9%D8%B1%D8%A8%D9%8A%D8%A9',
        color: Colors.black),
    CatogryItmeModel(
        image: AssetsData.cartoonDubbed,
        title: 'كرتون مدبلج',
        catogry:
            'https://alaanetstreaming.com/api/series/?category=%D8%B1%D8%B3%D9%88%D9%85-%D9%85%D8%AF%D8%A8%D9%84%D8%AC%D8%A9',
        color: Colors.black),
  ];
  var i = 0;
  FocusNode? _focusNode1;
  FocusNode? _focusNode2;
  FocusNode? _focusNode3;
  FocusNode? _focusNode4;
  FocusNode? _focusNode5;
  FocusNode? _focusNode6;
  FocusNode? _focusNode7;
  FocusNode? _focusNode8;
  FocusNode? _focusNode9;
  _setFirstFocus(BuildContext context) {
    if (_focusNode1 == null) {
      _focusNode1 = FocusNode();
      _focusNode2 = FocusNode();
      _focusNode3 = FocusNode();
      _focusNode4 = FocusNode();
      _focusNode5 = FocusNode();
      _focusNode6 = FocusNode();
      _focusNode7 = FocusNode();
      _focusNode8 = FocusNode();
      _focusNode9 = FocusNode();
      FocusScope.of(context).requestFocus(_focusNode1);
    }
  }

  _changFocus(BuildContext context, FocusNode node, index) {
    FocusScope.of(context).requestFocus(node);
    setState(() {
      listCatogry[i].color = Colors.transparent;
      listCatogry[index].color = Colors.white;
      i = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode2?.dispose();
    _focusNode3?.dispose();
    _focusNode4?.dispose();
    _focusNode5?.dispose();
    _focusNode6?.dispose();
    _focusNode7?.dispose();
    _focusNode8?.dispose();
    _focusNode9?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_focusNode1 == null) {
      print("object");
      listCatogry[0].color = Colors.white;
      _setFirstFocus(context);
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ActionHandler().handleArrowAndEnterAction(
      child: SizedBox(
        width: width,
        height: height,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: listCatogry.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  GoRouter.of(context)
                      .push(AppRouter.kSearchView, extra: listCatogry[index]);
                },
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      bottom: 10, top: 10, start: 10),
                  child: Actions(
                    actions: <Type, Action<Intent>>{
                      DownButtonIntent:
                          CallbackAction<DownButtonIntent>(onInvoke: (intent) {
                        return _changFocus(
                            context,
                            index == 0
                                ? _focusNode2!
                                : index == 1
                                    ? _focusNode3!
                                    : index == 2
                                        ? _focusNode4!
                                        : index == 3
                                            ? _focusNode5!
                                            : index == 4
                                                ? _focusNode6!
                                                : index == 5
                                                    ? _focusNode7!
                                                    : index == 6
                                                        ? _focusNode8!
                                                        : index == 7
                                                            ? _focusNode9!
                                                            : _focusNode1!,
                            index == 8 ? 0 : index + 1);
                      }),
                      UpButtonIntent:
                          CallbackAction<UpButtonIntent>(onInvoke: (intent) {
                        return _changFocus(
                            context,
                            index == 0
                                ? _focusNode9!
                                : index == 1
                                    ? _focusNode1!
                                    : index == 2
                                        ? _focusNode2!
                                        : index == 3
                                            ? _focusNode3!
                                            : index == 4
                                                ? _focusNode4!
                                                : index == 5
                                                    ? _focusNode5!
                                                    : index == 6
                                                        ? _focusNode6!
                                                        : index == 7
                                                            ? _focusNode7!
                                                            : index == 8
                                                                ? _focusNode8!
                                                                : _focusNode9!,
                            index == 0 ? 8 : index - 1);
                      }),
                      EnterButtonIntent: CallbackAction<EnterButtonIntent>(
                        onInvoke: (intent) {
                          GoRouter.of(context).push(AppRouter.kSearchView,
                              extra: listCatogry[index]);
                          return listCatogry[index].color;
                        },
                      )
                    },
                    child: Focus(
                      focusNode: index == 0
                          ? _focusNode1
                          : index == 1
                              ? _focusNode2
                              : index == 2
                                  ? _focusNode3
                                  : index == 3
                                      ? _focusNode4
                                      : index == 4
                                          ? _focusNode5
                                          : index == 5
                                              ? _focusNode6
                                              : index == 6
                                                  ? _focusNode7
                                                  : index == 7
                                                      ? _focusNode8
                                                      : _focusNode9,
                      child: CatogryItmeHome(
                        images: listCatogry[index].image,
                        title: listCatogry[index].title,
                        color: listCatogry[index].color!,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
// width: width * .9,
//       height: height * .25,
