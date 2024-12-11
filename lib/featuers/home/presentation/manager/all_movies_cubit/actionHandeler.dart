import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeftButtonIntent extends Intent {}

class RightButtonIntent extends Intent {}

class UpButtonIntent extends Intent {}

class DownButtonIntent extends Intent {}

class EnterButtonIntent extends Intent {}

class CloseButtonIntent extends Intent {}

class ActionHandler {
  Widget handleArrowAndEnterAction({required Widget child}) {
    return Shortcuts(shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.exit): CloseButtonIntent(),
    }, child: child);
  }
}
