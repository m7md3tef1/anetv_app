import 'package:anetv/featuers/home/presentation/views/home_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../home/data/local/cacheHelper.dart';
import '../../home/data/models/usersModel.dart';
import '../../home/presentation/manager/all_movies_cubit/actionHandeler.dart';

List<UsersModel>? users = [];
Future getUsers({authToken, url}) async {
  try {
    var response =
        await Dio().get("https://alaanetstreaming.com/wp-json/custom/v1/alou");
    if (response.statusCode == 200) {
      var productsList = response.data;
      print(response.data);
      for (int i = 0; i < response.data.length; i++) {
        print(response.data[i]);
        users!.add(UsersModel.fromJson(response.data[i]));
      }
      return productsList;
    }
  } on DioError catch (e) {
    if (e.response!.statusCode == 401) {
      return CacheHelper.putBool(SharedKeys.isLogin, false);
    } else {
      throw Exception(e.response!.data);
    }
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  void _addText(String newText) {
    final currentText = _controller.text;
    final cursorPosition = _controller.selection.baseOffset;

    if (cursorPosition == -1) {
      _controller.text = currentText + newText;
    } else {
      final updatedText = currentText.replaceRange(
        cursorPosition,
        cursorPosition,
        newText,
      );
      _controller.text = updatedText;
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: cursorPosition + newText.length),
      );
    }
  }

  final List<FocusNode?> focusNode = [];
  void _clearLetter(String letter) {
    String currentText = _controller.text;

    currentText = currentText.replaceAll(letter, '');

    _controller.text = currentText;

    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: currentText.length),
    );
  }

  var i = 0;
  changFocus2(BuildContext context, FocusNode node, index) {
    FocusScope.of(context).requestFocus(node);
    setState(() {
      colors[I] = Colors.blue;
      colors[index] = Colors.grey;
      I = index;
    });
  }

  bool change = true;
  List colors = [];
  @override
  void initState() {
    getUsers();
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

  changeLang() {
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
      27: change == true ? "." : ".",
      28: change == true ? "@" : "@",
      29: change == true ? 'Clear' : "مسح",
      30: change == true ? 'Login' : "تسجيل",
      31: change == true ? 'Change lang' : "تغبير اللغه",
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              autofocus: false,
              onFieldSubmitted: (value) {
                for (int i = 0; i < users!.length; i++) {
                  if (_controller.text.toString().trim() ==
                      users![i].email.toString()) {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const HomeView();
                      },
                    ));
                    CacheHelper.putBool(SharedKeys.isLogin, true);
                    isLogin = CacheHelper.getBool(SharedKeys.isLogin);
                    CacheHelper.putString(
                        SharedKeys.email, _controller.text.toString().trim());
                    email = CacheHelper.getString(SharedKeys.email);
                    // print("Email");
                    // print(Email);
                  }
                }
              },
              onChanged: (value) {},
              decoration: const InputDecoration(
                labelText: "Enter Email",
                border: OutlineInputBorder(),
              ),
            ),
            // Custom keyboard
            ActionHandler().handleArrowAndEnterAction3(
                child: Container(
              color: Colors.black12,
              child: GridView.count(
                  crossAxisCount: 10,
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
                            DownButtonIntent: CallbackAction<DownButtonIntent>(
                              onInvoke: (intent) {
                                return key.key < 21
                                    ? changFocus2(
                                        context,
                                        focusNode[names.entries.last.value ==
                                                key.value
                                            ? 0
                                            : key.key + 9]!,
                                        names.entries.last.value == key.value
                                            ? 0
                                            : key.key + 9)
                                    : "";
                              },
                            ),
                            EnterButtonIntent:
                                CallbackAction<EnterButtonIntent>(
                              onInvoke: (intent) {
                                return key.value == "Change lang" ||
                                        key.value == "تغبير اللغه"
                                    ? changeLang()
                                    : key.value == "Clear" || key.value == "مسح"
                                        ? _clearLetter(_controller.text)
                                        : key.value == "Login" ||
                                                key.value == "تسجيل"
                                            ? {
                                                for (int i = 0;
                                                    i < users!.length;
                                                    i++)
                                                  {
                                                    // print(users![i]
                                                    //     .email
                                                    //     .toString() ==
                                                    //     _controller.text
                                                    //         .toString()
                                                    //         .trim()),
                                                    if (_controller.text
                                                            .toString()
                                                            .trim() ==
                                                        users![i]
                                                            .email
                                                            .toString())
                                                      {
                                                        Navigator.push(context,
                                                            MaterialPageRoute(
                                                          builder: (context) {
                                                            return const HomeView();
                                                          },
                                                        )),
                                                        CacheHelper.putBool(
                                                            SharedKeys.isLogin,
                                                            true),
                                                        isLogin =
                                                            CacheHelper.getBool(
                                                                SharedKeys
                                                                    .isLogin),
                                                        CacheHelper.putString(
                                                            SharedKeys.email,
                                                            _controller.text
                                                                .toString()
                                                                .trim()),
                                                        email = CacheHelper
                                                            .getString(
                                                                SharedKeys
                                                                    .email),
                                                        // print("Email"),
                                                        // print(Email),
                                                      }
                                                    // else if (users!.last.email.toString()!=_controller.text.toString().trim() )
                                                    //   {
                                                    //     ScaffoldMessenger.of(
                                                    //         context)
                                                    //         .showSnackBar(SnackBar(
                                                    //         backgroundColor:
                                                    //         Colors.red,
                                                    //         content: Text(
                                                    //           "This Email Not Found",
                                                    //           style: TextStyle(
                                                    //               fontSize:
                                                    //               15.sp,
                                                    //               color: Colors
                                                    //                   .white),
                                                    //         ))),
                                                    //   }
                                                  }
                                              }
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
                            UpButtonIntent: CallbackAction<UpButtonIntent>(
                              onInvoke: (intent) {
                                return key.key > 10
                                    ? changFocus2(
                                        context,
                                        focusNode[names.entries.first.value ==
                                                key.value
                                            ? 0
                                            : key.key - 9]!,
                                        names.entries.first.value == key.value
                                            ? 0
                                            : key.key - 9)
                                    : "";
                              },
                            ),
                          },
                          child: GestureDetector(
                            onTap: () => key.value == "Change lang" ||
                                    key.value == "تغبير اللغه"
                                ? changeLang()
                                : key.value == "Clear" || key.value == "مسح"
                                    ? _clearLetter(_controller.text)
                                    : key.value == "Login" ||
                                            key.value == "تسجيل"
                                        ? {
                                            for (int i = 0;
                                                i < users!.length;
                                                i++)
                                              {
                                                // print(users!.length-1 ==i),
                                                // print(users![i]
                                                //         .email
                                                //         .toString() ==
                                                //     _controller.text
                                                //         .toString()
                                                //         .trim()),
                                                if (_controller.text
                                                        .toString()
                                                        .trim() ==
                                                    users![i].email.toString())
                                                  {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                      builder: (context) {
                                                        return const HomeView();
                                                      },
                                                    )),
                                                    CacheHelper.putBool(
                                                        SharedKeys.isLogin,
                                                        true),
                                                    isLogin =
                                                        CacheHelper.getBool(
                                                            SharedKeys.isLogin),
                                                    CacheHelper.putString(
                                                        SharedKeys.email,
                                                        _controller.text
                                                            .toString()
                                                            .trim()),
                                                    email =
                                                        CacheHelper.getString(
                                                            SharedKeys.email),
                                                    // print("Email"),
                                                    // print(Email),
                                                  }
                                              }
                                          }
                                        : _addText(key.value),
                            child: Focus(
                              focusNode: focusNode[key.key - 1],
                              child: Container(
                                // height: 10,
                                // width: 50.w,
                                margin: EdgeInsets.only(
                                    right: 2.w, bottom: 2.h, top: 2.h),
                                color: colors[key.key - 1] == Colors.blue
                                    ? Colors.blue
                                    : Colors.grey,
                                alignment: Alignment.center,
                                child: Text(
                                  key.value,
                                  style: TextStyle(
                                      fontSize: 8.sp, color: Colors.white),
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
  }
}

class InsertTextIntent extends Intent {
  const InsertTextIntent(this.text);
  final String text;
}
