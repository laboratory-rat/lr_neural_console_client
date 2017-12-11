import '../app_client.dart';
import 'menu_base.dart';

class MenuHome extends MenuBase {
  MenuHome(AppClient app) : super(app) {
    name = 'lr_neural_console_application main menu';
    components = [
      new MenuComponent(title: 'test database', action: () => app.tests.testDatabase()),
      new MenuComponent(title: 'unprepared data', action: () => app.unpreparedData.init()),
      new MenuComponent(title: 'close app', action: null, isClose: true)
    ];
  }
}
