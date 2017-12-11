import '../app_client.dart';

class ComponentBase {
  AppClient app;
  ConsoleHelper get console => app.console;

  ComponentBase(this.app);
}
