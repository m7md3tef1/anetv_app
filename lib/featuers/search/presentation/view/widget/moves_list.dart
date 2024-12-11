import 'dart:convert';

import 'package:anetv/core/utils/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import '../../../../home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';

class MovesList extends StatefulWidget {
  const MovesList({super.key});

  @override
  State<MovesList> createState() => _MovesListState();
}

class _MovesListState extends State<MovesList>  with SingleTickerProviderStateMixin{
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

  _setFirstFocus(BuildContext context) {
    if (_focusNode[0] == null) {
      for (int i = 1; i < _focusNode.length; i++) {
        _focusNode[i] = FocusNode();
      }
      FocusScope.of(context).requestFocus(_focusNode[0]);
    }
  }

  ScrollController listScrollController = ScrollController();

  changFocus(BuildContext context, FocusNode node, allMoves, index) {
    FocusScope.of(context).requestFocus(node);

    setState(() {
      // if (listScrollController.hasClients) {
      final position = 500;
      print("object");
      listScrollController.animateTo(
          index >= 4 ? listScrollController.position.maxScrollExtent + 100 : 0,
          duration: Duration(seconds: 3),
          curve: Curves.easeOut,
          );
      // }
      allMoves[i].color = Colors.transparent;
      allMoves[index].color = Colors.white;
      i = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.clear();
  }

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
    return SingleChildScrollView(
      child: ActionHandler().handleArrowAndEnterAction(
        child: BlocBuilder<AllMoviesCubit, AllMoviesState>(
            builder: (context, state) {
          if (state is AllMoviesSuccess) {
            final allMoves = state.allMovies;
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
                controller: listScrollController,
                padding: EdgeInsetsDirectional.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 200),
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: allMoves.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).push(AppRouter.kWatchingMovieView,
                          extra: allMoves[index].embedLink);
                    },
                    child: Actions(
                      actions: <Type, Action<Intent>>{
                        DownButtonIntent: CallbackAction<DownButtonIntent>(
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
                        UpButtonIntent: CallbackAction<UpButtonIntent>(
                          onInvoke: (intent) {
                            return changFocus(
                                context,
                                _focusNode[
                                    allMoves.first.id == allMoves[index].id
                                        ? 0
                                        : index - 1]!,
                                allMoves,
                                allMoves.first.id == allMoves[index].id
                                    ? 0
                                    : index - 1);
                          },
                        ),
                        EnterButtonIntent: CallbackAction<EnterButtonIntent>(
                          onInvoke: (intent) {
                            return GoRouter.of(context).push(
                                AppRouter.kWatchingMovieView,
                                extra: allMoves[index].embedLink);
                          },
                        ),
                      },
                      child: Focus(
                        focusNode: _focusNode[index],
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 5.0, end: 5, bottom: 10),
                          child: Container(
                            width: 300,
                            height: 300,
                            // color: allMoves[index].color,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.white, width: 2),
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          allMoves[index].title,
                                          textAlign: TextAlign.start,
                                          maxLines: 5,
                                          style: TextStyle(
                                              fontSize: allMoves[index].color ==
                                                      Colors.white
                                                  ? 20
                                                  : 15,
                                              color: allMoves[index].color ==
                                                      Colors.white
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  CachedNetworkImage(
                                    imageUrl: '${allMoves[index].thumbnail}',
                                    width: 250,
                                    height: 250,
                                    fit: BoxFit.fill,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 250,
                                      height: 250,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Center(child: Icon(Icons.error)),
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
          } else if (state is AllMoviesFailure) {
            // print(state.errorMassage);
            return Center(child: Text("No Videos Yet"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
