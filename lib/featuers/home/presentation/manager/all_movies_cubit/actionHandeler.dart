import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LeftButtonIntent extends Intent {}

class RightButtonIntent extends Intent {}

class UpButtonIntent extends Intent {}

class DownButtonIntent extends Intent {}

class EnterButtonIntent extends Intent {}

class CloseButtonIntent extends Intent {}
enum Direction { up, down }
class ActionHandler {
  Widget handleArrowAndEnterAction({required Widget child}) {
    return Shortcuts(shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.exit): CloseButtonIntent(),
      // Define a shortcut for scrolling down (Ctrl + Arrow Down in this example)
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.arrowDown): ScrollIntent(Direction.down),
      // Define a shortcut for scrolling up (Ctrl + Arrow Up)
      LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.arrowUp): ScrollIntent(Direction.up),

    }, child: child);
  }
  Widget handleArrowAndEnterAction2({required Widget child}) {
    return Shortcuts(shortcuts: <LogicalKeySet, Intent>{
      LogicalKeySet(LogicalKeyboardKey.select): EnterButtonIntent(),
      // LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
      // LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
      LogicalKeySet(LogicalKeyboardKey.exit): CloseButtonIntent(),
      // Define a shortcut for scrolling down (Ctrl + Arrow Down in this example)
      LogicalKeySet(  LogicalKeyboardKey.arrowDown): ScrollIntent(Direction.down),
      // Define a shortcut for scrolling up (Ctrl + Arrow Up)
      LogicalKeySet( LogicalKeyboardKey.arrowUp): ScrollIntent(Direction.up),

    }, child: child);
  }
}
class ScrollIntent extends Intent {
  const ScrollIntent(this.direction);
  final Direction direction;
}

class ScrollAction extends Action<ScrollIntent> {
  ScrollAction(this.controller);

  final ScrollController controller;

  @override
  void invoke(covariant ScrollIntent intent) {

    if (intent.direction == Direction.down) {
      controller.animateTo(
        controller.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else if (intent.direction == Direction.up) {
      controller.animateTo(
        controller.position.minScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
}