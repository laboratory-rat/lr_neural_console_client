import '../app_client.dart';
import '../component/component_unprepared_data.dart';
import 'menu_base.dart';

class MenuUnpreparedData extends MenuBase{
  final ComponentUnpreparedData component;

  MenuUnpreparedData(AppClient app, this.component) : super(app){
    name = 'Unprepared data';
    components = [
      new MenuComponent(title: 'display collections', action: () => component.list(), isClose: false),
      new MenuComponent(title: 'add collection', action: () => component.add()),
      new MenuComponent(title: 'remove collection', action: null),
      new MenuComponent(title: 'back', isClose: true)
    ];
  }

}