import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../home/data/models/catogry_itme_model.dart';
import '../../../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';
import '../../../../home/presentation/manager/all_movies_cubit/all_movies_cubit.dart';
import '../search_view.dart';



class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController _controller = TextEditingController();
  void _addText(String newText) {
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
    // print(index);
    // print(I);
    setState(() {
      colors[I] = Colors.blue;
      colors[index] = Colors.grey;
      I = index;
    });
  }
  bool change=true;
  List colors = [];
  @override
  void initState() {
    _focusNode.clear();
    focusNode.clear();
    for (int i = 0; i < 1; i++) {
      _focusNode.add(FocusNode());
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  changeLang(){
    setState(() {
      change = !change;
    });
  }

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
    Map<int, String> names = {
      1: change == true ? "a" : "ا",
      2: change == true ? "b" : "ب",
      3: change == true ? "c" : "ت",
      4: change == true ? "d" : "ث",
      5: change == true ? "e" : "ج",
      6: change == true ? "f" : "ح",
      7: change == true ? "g" : "خ",
      8: change == true ? "h" : "د",
      9: change == true ? "i" : "ذ",
      10: change == true ? "j" : "س",
      11: change == true ? "k" : "ش",
      12: change == true ? "l" : "ص",
      13: change == true ? "m" : "ض",
      14: change == true ? "n" : "ط",
      15: change == true ? "o" : "ظ",
      16: change == true ? "p" : "ع",
      17: change == true ? "q" : "غ",
      18: change == true ? "r" : "ف",
      19: change == true ? "s" : "ق",
      20: change == true ? "t" : "ك",
      21: change == true ? "u" : "ل",
      22: change == true ? "v" : "م",
      23: change == true ? "w" : "ن",
      24: change == true ? "x" : "ه",
      25: change == true ? "y" : "و",
      26: change == true ? "z" : "ي",
      27: change == true ? 'Clear' : "مسح",
      28: change == true ? 'Search' : "بحث",
      29: change == true ? 'Change language' : "تغبير اللغه",
    };
    for (int i = 0; i < names.length; i++) {
      focusNode.add(FocusNode());
      colors.add(Colors.blue);
    }
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
                    // print("value");
                    // print(value);
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
                      crossAxisCount: 12,
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
                                        focusNode[names.entries.last.value ==
                                                key.value
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
                                    return key.value == "Change language" ||
                                            key.value == "تغبير اللغه"
                                        ? changeLang()
                                        : key.value == "Clear" ||
                                                key.value == "مسح"
                                            ? _clearLetter(_controller.text)
                                            : key.value == "Search" ||
                                                    key.value == "بحث"
                                                ? Navigator.push(context,
                                                    MaterialPageRoute(
                                                    builder: (context) {
                                                      return SearchView(
                                                          catogry:
                                                              CatogryItmeModel(
                                                                  catogry:
                                                                      "catogry",
                                                                  image:
                                                                      "image",
                                                                  title:
                                                                      "title",
                                                                  color: color),
                                                          cat:
                                                              "https://alaanetstreaming.com/api/search/?search=${_controller.text}");
                                                    },
                                                  ))
                                                : _addText(key.value);
                                  },
                                ),
                                LeftButtonIntent:
                                    CallbackAction<LeftButtonIntent>(
                                  onInvoke: (intent) {
                                    return changFocus2(
                                        context,
                                        focusNode[names.entries.first.value ==
                                                key.value
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
                                    // height: 10,
                                    // width: 20,
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
