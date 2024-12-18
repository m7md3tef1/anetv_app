import 'dart:convert';

import 'package:anetv/featuers/home/presentation/views/widgets/adaptive_layout.dart';
import 'package:anetv/featuers/home/presentation/views/widgets/home_view_body.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/app_router.dart';
import '../../../../home/data/models/catogry_itme_model.dart';
import '../../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import '../../../../home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';
import '../search_view.dart';
import 'custom_search_text_field.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  void _addText(String newText) {
    print("newwwwwwwwwwwww");
    final currentText = _controller.text;
    final cursorPosition = _controller.selection.baseOffset;

    if (cursorPosition == -1) {
      // No cursor: Append text to the end
      _controller.text = currentText + newText;
    } else {
      // Insert text at cursor position
      final updatedText = currentText.replaceRange(
        cursorPosition,
        cursorPosition,
        newText,
      );
      _controller.text = updatedText;

      // Update cursor position
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPosition + newText.length),
      );
    }
  }

  final List<FocusNode?> focusNode = [];
  void _clearLetter(String letter) {
    String currentText = _controller.text;

    // Remove all occurrences of the specified letter
    currentText = currentText.replaceAll(letter, '');

    // Update the controller text
    _controller.text = currentText;

    // Maintain the cursor position
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: currentText.length),
    );
  }

  var i = 0;
  changFocus2(BuildContext context, FocusNode node, index) {
    FocusScope.of(context).requestFocus(node);
    print(index);
    print(I);
    setState(() {
      colors[I] = Colors.blue;
      colors[index] = Colors.grey;
      I = index;
    });
  }

  List colors = [];
  @override
  void initState() {
    _focusNode.clear();
    focusNode.clear();
    for (int i = 0; i < 1; i++) {
      _focusNode.add(FocusNode());
    }
    for (int i = 0; i < names.length; i++) {
      focusNode.add(FocusNode());
      colors.add(Colors.blue);
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Map<int, String> names = {
    1: "a",
    2: "b",
    3: "c",
    4: "d",
    5: "e",
    6: "f",
    7: "g",
    8: "h",
    9: "i",
    10: "j",
    11: "k",
    12: "l",
    13: "m",
    14: "n",
    15: "o",
    16: "p",
    17: "q",
    18: "r",
    19: "s",
    20: "t",
    21: "u",
    22: "v",
    23: "w",
    24: "x",
    25: "y",
    26: "z",
    27: 'Clear',
    28: 'Search'
  };
  final ScrollController _scrollController = ScrollController();
  _setFirstFocus2(BuildContext context) {
    if (focusNode[0] == null) {
      for (int i = 1; i < focusNode.length; i++) {
        focusNode[i] = FocusNode(descendantsAreFocusable: false);
      }
      FocusScope.of(context).requestFocus(focusNode[0]);
    }
  }

  Color color = Colors.transparent;
  var I = 0;
  final List<FocusNode?> _focusNode = [];

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

  changFocus(BuildContext context, FocusNode node, allMoves, index) {
    FocusScope.of(context).requestFocus(node);

    setState(() {
      allMoves[i].color = Colors.transparent;
      allMoves[index].color = Colors.white;
      scrollToIndex(index);
      i = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
    if (_focusNode[0] == null) {
      for (int i = 1; i < _focusNode.length; i++) {
        _focusNode[i] = FocusNode();
      }
      FocusScope.of(context).requestFocus(_focusNode[0]);
      _setFirstFocus(context);
    }

    if (focusNode[0] == null) {
      FocusScope.of(context).requestFocus(focusNode[0]);
      _setFirstFocus2(context);
    }
    return BlocBuilder<AllMoviesCubit, AllMoviesState>(
  builder: (context, state) {
      // if (state is AllSearchSuccess) {
      //
      //   }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              autofocus: false,
              // focusNode: _focusNode,
              onChanged: (value) {
                print("value");
                print(value);
              },
              decoration: const InputDecoration(
                labelText: "Type something or use shortcuts",
                border: OutlineInputBorder(),
              ),
            ),
            // Custom keyboard
            ActionHandler().handleArrowAndEnterAction3(
                child: Container(
              color: Colors.black12,
              child: GridView.count(
                  crossAxisCount: 15,
                  shrinkWrap: true,
                  children: names.entries
                      .map(
                        (key) => Actions(
                          actions: <Type, Action<Intent>>{
                            RightButtonIntent:
                                CallbackAction<RightButtonIntent>(
                              onInvoke: (intent) {
                                return changFocus2(
                                    context,
                                    focusNode[
                                        names.entries.last.value == key.value
                                            ? 0
                                            : key.key]!,
                                    names.entries.last.value == key.value
                                        ? 0
                                        : key.key);
                              },
                            ),
                            EnterButtonIntent:
                                CallbackAction<EnterButtonIntent>(
                              onInvoke: (intent) {
                                // _addText(key.value);
                                return key.value == "Clear"
                                    ? _clearLetter(_controller.text)
                                    : key.value == "Search"
                                        ?
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return SearchView(
                                    catogry: CatogryItmeModel(catogry: "catogry", image: "image", title: "title", color: color),
                                      cat: "https://alaanetstreaming.com/api/search/?search=${_controller.text}"
                                  );
                                },))
                                // BlocProvider.of<AllMoviesCubit>(
                                //                 context)
                                //             .fetchMovie(
                                //                 catogry: )
                                        : _addText(key.value);
                              },
                            ),
                            LeftButtonIntent: CallbackAction<LeftButtonIntent>(
                              onInvoke: (intent) {
                                return changFocus2(
                                    context,
                                    focusNode[
                                        names.entries.first.value == key.value
                                            ? 0
                                            : key.key - 2]!,
                                    names.entries.first.value == key.value
                                        ? 0
                                        : key.key - 2);
                              },
                            ),
                          },
                          child: GestureDetector(
                            onTap: () => _addText(key.value),
                            child: Focus(
                              focusNode: focusNode[key.key - 1],
                              child: Container(
                                height: 10,
                                width: 20,
                                margin: const EdgeInsets.all(4),
                                color: colors[key.key - 1] == Colors.blue
                                    ? Colors.blue
                                    : Colors.grey,
                                alignment: Alignment.center,
                                child: Text(
                                  key.value,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()
                  // ],
                  ),
            )),

          ],
        ),
      ),
    );
  },
);
  }
}

class InsertTextIntent extends Intent {
  const InsertTextIntent(this.text);
  final String text;
}
