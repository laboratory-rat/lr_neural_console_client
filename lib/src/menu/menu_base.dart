import '../app_client.dart';
import 'dart:async';

class MenuBase {
  final AppClient app;
  ConsoleHelper get console => app.console;

  List<MenuComponent> components = [];
  String name;

  MenuBase(this.app);

  Future show() async {
    String badOption = null;

    while (true) {
      console.clear();
      console.writeLine(name);

      if (badOption != null) {
        console.writeLine('"' + badOption + '" is a bad option. Try agan.');
        badOption = null;
      }
      console.seperator();

      for (var i = 0; i < components.length; i++) {
        console.writeLine((i + 1).toString() + '. ' + components[i].title);
      }

      var stringInput = console.readLine();

      try {
        var input = int.parse(stringInput);

        if (components[input - 1].isClose) {
          return;
        } else {
          await components[input - 1].action();
          console.clear();
        }
      } catch (_) {
        badOption = stringInput;
      }
    }
  }
}

class MenuComponent {
  String title;
  MenuAction action;
  bool isClose = false;

  MenuComponent({this.title, this.action, this.isClose});
}

typedef Future<dynamic> MenuAction();
