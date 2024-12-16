import 'dart:convert';

import 'package:anetv/core/utils/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/styels.dart';
import '../../../../home/data/models/moves.dart';
import '../../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import '../../../../home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';

class MovesList2 extends StatefulWidget {
  MovesList2(this.allMovies, this.image, {super.key});
  List<Episodes> allMovies;
  String image;
  @override
  State<MovesList2> createState() => _MovesList2State();
}

class _MovesList2State extends State<MovesList2>
    with SingleTickerProviderStateMixin {
  Color color = Colors.transparent;
  var i = 0;
  final List<FocusNode?> _focusNode = [];
  @override
  void initState() {
    _focusNode.clear();
    for (int i = 0; i < 1; i++) {
      _focusNode.add(FocusNode());
    }
    super.initState();
  }

  final double _itemHeight = 100.0; // Assuming each item has a fixed height
  void scrollToIndex(int index) {
    double offset = _itemHeight * index;
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  _setFirstFocus(BuildContext context) {
    if (_focusNode[0] == null) {
      for (int i = 1; i < _focusNode.length; i++) {
        _focusNode[i] = FocusNode(descendantsAreFocusable: false);
      }
      FocusScope.of(context).requestFocus(_focusNode[0]);
    }
  }

  ScrollController listScrollController = ScrollController();

  changFocus(BuildContext context, FocusNode node,List<Episodes> allMoves, index) {
    FocusScope.of(context).requestFocus(node);

    setState(() {
      allMoves[i] = Episodes(
          color: Colors.transparent,
          categories: allMoves[i].categories,
          id: allMoves[i].id,
          type: allMoves[i].type,
          thumbnail: allMoves[i].thumbnail,
          title: allMoves[i].title,
          content: allMoves[i].content,
          embedLink: allMoves[i].embedLink,
          tags: allMoves[i].tags
      );
      allMoves[index] = Episodes(
          color: Colors.white,
          categories: allMoves[index].categories,
          id: allMoves[index].id,
          type: allMoves[index].type,
          thumbnail: allMoves[index].thumbnail,
          title: allMoves[index].title,
          content: allMoves[i].content,
          embedLink: allMoves[i].embedLink,
          tags: allMoves[i].tags);



      scrollToIndex(index);
      i = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.clear();
  }

  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    if (_focusNode[0] == null) {
      for (int i = 1; i < _focusNode.length; i++) {
        _focusNode[i] = FocusNode();
      }
      FocusScope.of(context).requestFocus(_focusNode[0]);
      _setFirstFocus(context);
    }
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              child: CustomScrollView(
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
                              "الحلقات",
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
                child: BlocBuilder<AllMoviesCubit, AllMoviesState>(
                    builder: (context, state) {
                  final allMoves = widget.allMovies;
                  if (_focusNode.length == 1) {
                    _focusNode.clear();
                    for (int i = 0; i < allMoves.length; i++) {
                      _focusNode.add(FocusNode());
                    }
                  }

                  return SizedBox(
                    width: width,
                    height: height,
                    child: GridView.builder(
                      // shrinkWrap: true,
                      controller: _scrollController,
                      padding: EdgeInsetsDirectional.zero,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisExtent: 200),
                      scrollDirection: Axis.vertical,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: allMoves.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 5, right: 5),
                        child: InkWell(
                          onTap: () {
                            print(jsonEncode(allMoves[index]));
                            GoRouter.of(context).push(
                                AppRouter.kWatchingMovieView,
                                extra: allMoves[index].embedLink);
                          },
                          child: Actions(
                            actions: <Type, Action<Intent>>{
                              DownButtonIntent:
                                  CallbackAction<DownButtonIntent>(
                                onInvoke: (intent) {
                                  return changFocus(
                                      context,
                                      _focusNode[
                                          allMoves.last.id == allMoves[index].id
                                              ? 0
                                              : index + 1]!,
                                      allMoves,
                                      allMoves.last.id == allMoves[index].id
                                          ? 0
                                          : index + 1);
                                },
                              ),
                              // ScrollIntent: ScrollAction(_scrollController),
                              UpButtonIntent: CallbackAction<UpButtonIntent>(
                                onInvoke: (intent) {
                                  return changFocus(
                                      context,
                                      _focusNode[allMoves.first.id ==
                                              allMoves[index].id
                                          ? 0
                                          : index - 1]!,
                                      allMoves,
                                      allMoves.first.id == allMoves[index].id
                                          ? 0
                                          : index - 1);
                                },
                              ),
                              EnterButtonIntent:
                                  CallbackAction<EnterButtonIntent>(
                                onInvoke: (intent) {
                                  print(jsonEncode(allMoves[index]));
                                  return GoRouter.of(context).push(
                                      AppRouter.kWatchingMovieView,
                                      extra: allMoves[index].embedLink);
                                },
                              ),
                            },
                            child: Focus(
                              focusNode: _focusNode[index],
                              autofocus: true,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 5.0, end: 5, bottom: 10),
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  // color: allMoves[index].color,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      color: allMoves[index].color),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            // width: 100,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                allMoves[index].title!,
                                                textAlign: TextAlign.start,
                                                maxLines: 5,
                                                style: TextStyle(
                                                    fontSize:
                                                        allMoves[index].color ==
                                                                Colors.white
                                                            ? 20
                                                            : 15,
                                                    color:
                                                        allMoves[index].color ==
                                                                Colors.white
                                                            ? Colors.black
                                                            : Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        CachedNetworkImage(
                                          imageUrl: widget.image,
                                          width: 250,
                                          height: 250,
                                          fit: BoxFit.fill,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: 250,
                                            height: 250,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Center(
                                                  child: Icon(Icons.error)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          )),
        ),
      ),
    );
  }
}

class ScrollIntent extends Intent {
  const ScrollIntent(this.direction);
  final Direction direction;
}

class ScrollAction extends Action<ScrollIntent> {
  ScrollAction(this.controller);

  final ScrollController controller;
  // var allMoves;
  @override
  void invoke(covariant ScrollIntent intent) {
    if (intent.direction == Direction.down) {
      print("ssssssssssssssssss");
      // allMoves;
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else if (intent.direction == Direction.up) {
      print("ssssssssssssssssss");
      // allMoves;
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}
