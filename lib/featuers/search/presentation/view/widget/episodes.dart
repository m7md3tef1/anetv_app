import 'dart:convert';

import 'package:anetv/core/utils/app_router.dart';
import 'package:anetv/featuers/search/presentation/view/widget/moves_list2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/styels.dart';
import '../../../../home/data/models/moves.dart';
import '../../../../home/data/repo/all_movies_home_repo_impl.dart';
import '../../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import '../../../../home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';

class EpisodesList extends StatefulWidget {
  EpisodesList(this.category, {super.key});
  var category;
  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList>
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

  changFocus(BuildContext context, FocusNode node, List<Data> allMoves, index) {
    FocusScope.of(context).requestFocus(node);

    setState(() {
      allMoves[i] = Data(
          color: Colors.transparent,
          categories: allMoves[i].categories,
          id: allMoves[i].id,
          name: allMoves[i].name,
          thumbnail: allMoves[i].thumbnail,
          episodes: allMoves[i].episodes);
      allMoves[index] = Data(
          color: Colors.white,
          categories: allMoves[index].categories,
          id: allMoves[index].id,
          name: allMoves[index].name,
          thumbnail: allMoves[index].thumbnail,
          episodes: allMoves[index].episodes);
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
    return BlocBuilder<AllMoviesCubit, AllMoviesState>(
        builder: (context, state) {
      // print("jsonEncode(movies)");
      // print(jsonEncode(movies));
      if (state is AllMoviesSuccess) {
        final allMoves = movies;
        if (_focusNode.length == 1) {
          _focusNode.clear();
          for (int i = 0; i < allMoves.length; i++) {
            _focusNode.add(FocusNode());
          }
        }

        return SizedBox(
          width: width,
          height: height,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  page > 1
                      ? InkWell(
                          onTap: () {
                            --page;
                            BlocProvider.of<AllMoviesCubit>(context)
                                .fetchMovie(catogry: widget.category);
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                              )))
                      : const SizedBox(),
                  Text("Page Number = ${page.toString()}",
                      style: Styels.textStyle18),
                  allMoves.isNotEmpty
                      ? InkWell(
                          onTap: () {
                            ++page;
                            BlocProvider.of<AllMoviesCubit>(context)
                                .fetchMovie(catogry: widget.category);
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(20)
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.black),
                              )))
                      : const SizedBox(),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: allMoves.isEmpty
                    ? Actions(
                        actions: <Type, Action<Intent>>{
                          LeftButtonIntent: CallbackAction<LeftButtonIntent>(
                            onInvoke: (intent) {
                              return page > 1
                                  ? {
                                      --page,
                                      BlocProvider.of<AllMoviesCubit>(context)
                                          .fetchMovie(catogry: widget.category),
                                    }
                                  : "";
                            },
                          ),
                        },
                        child: Focus(
                          focusNode: _focusNode[1],
                          autofocus: true,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 5.0, end: 5, bottom: 10),
                            child: Container(
                              width: 300,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Not Found Videos",
                                    textAlign: TextAlign.start,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        padding: EdgeInsetsDirectional.zero,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, mainAxisExtent: 200.h),
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: allMoves.length,
                        itemBuilder: (context, index) => Padding(
                          padding:
                              EdgeInsets.only(bottom: 10.h, left: 5, right: 5),
                          child: InkWell(
                            onTap: () {
                              // print(jsonEncode(allMoves[index]));
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MovesList2(allMoves[index].episodes!,
                                      allMoves[index].thumbnail);
                                },
                              ));
                            },
                            child: Actions(
                              actions: <Type, Action<Intent>>{
                                RightButtonIntent:
                                    CallbackAction<RightButtonIntent>(
                                  onInvoke: (intent) {
                                    return {
                                      ++page,
                                      BlocProvider.of<AllMoviesCubit>(context)
                                          .fetchMovie(catogry: widget.category),
                                    };
                                  },
                                ),
                                LeftButtonIntent:
                                    CallbackAction<LeftButtonIntent>(
                                  onInvoke: (intent) {
                                    return page > 1
                                        ? {
                                            --page,
                                            BlocProvider.of<AllMoviesCubit>(
                                                    context)
                                                .fetchMovie(
                                                    catogry: widget.category),
                                          }
                                        : "";
                                  },
                                ),

                                DownButtonIntent:
                                    CallbackAction<DownButtonIntent>(
                                  onInvoke: (intent) {
                                    return changFocus(
                                        context,
                                        _focusNode[allMoves.last.id ==
                                                allMoves[index].id
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
                                    // print(jsonEncode(allMoves[index]));
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return MovesList2(
                                            allMoves[index].episodes!,
                                            allMoves[index].thumbnail);
                                      },
                                    ));
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
                                    width: 300.w,
                                    height: 300.h,
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
                                                  allMoves[index].name!,
                                                  textAlign: TextAlign.start,
                                                  maxLines: 5,
                                                  style: TextStyle(
                                                      fontSize: allMoves[index]
                                                                  .color ==
                                                              Colors.white
                                                          ? 15.sp
                                                          : 12.sp,
                                                      color: allMoves[index]
                                                                  .color ==
                                                              Colors.white
                                                          ? Colors.black
                                                          : Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '${allMoves[index].thumbnail}',
                                              width: 200.w,
                                              height: 200.h,
                                              fit: BoxFit.fill,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: 200.w,
                                                height: 200.h,
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
                                              errorWidget: (context, url,
                                                      error) =>
                                                  const Center(
                                                      child: Icon(Icons.error)),
                                            ),
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
              ),
            ],
          ),
        );
      } else if (state is AllMoviesFailure) {
        // print(state.errorMassage);
        return Center(child: Text("No Videos Yet"));
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
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
