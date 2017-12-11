import '../app_client.dart';
import '../collection/collection_unprepared_data.dart';
import '../menu/menu_unprepared_data.dart';
import 'component_base.dart';
import 'dart:async';

class ComponentUnpreparedData extends ComponentBase {
  CollectionUnpreparedData collection;

  ComponentUnpreparedData(AppClient app) : super(app) {}

  Future init() async {
    collection = new CollectionUnpreparedData(app.connectionString);

    final menu = new MenuUnpreparedData(app, this);
    await menu.show();
  }

  Future list() async {
    console.clear();

    try {
      var entities = await collection.findAll();

      console.writeLine('unprepared data:');
      console.writeEmpty();

      if (entities == null) {
        console.writeLine('no unprepared data found');
      } else {
        entities.forEach((x) {
          console.writeLine((entities.indexOf(x) + 1).toString() + '. ' + x.name);
        });
      }

      console.writeLine('total: ' + entities.length);
    } catch (e) {
      console.writeLine('error');
      console.writeLine(e);
    }

    console.readLine();
  }

  Future add() async {
    String name;
    List<String> sources;
    int maxCount;

    console.clear();

    console.writeLine('Creating new unprepared data collection.');
    console.writeLine('Enter "stop" to return.');
    console.writeLine('Enter name for new collection:');

    while (name == null || name.trim() == "") {
      name = console.readLine();
    }

    if (name.trim() == 'stop') return;

    // get sources

    String sourcesString;
    while (true) {
      bool boolResponse = false;

      console.clear();
      console.writeLine('Enter sources (twitter users) for collection ' + name + '. Use "," to separate entities.');

      sourcesString = console.readLine();

      if (sourcesString == null || sourcesString.trim() == '')
        continue;
      else if (sourcesString.trim() == "stop") return;

      sources = sourcesString.split(',').map((x) => '@' + x.trim()).toList();
      if (sources.length > 0) {
        var response;

        while (true) {
          console.clear();
          console.writeLine('Use this sources?');
          console.writeEmpty();
          console.writeList(sources);
          console.writeEmpty();
          console.writeLine('y/n');

          response = console.readLine();
          response = response.trim();

          if (response == 'y') {
            boolResponse = true;
          } else if (response == 'n') {
            boolResponse = false;
          } else {
            continue;
          }

          break;
        }

        if (!boolResponse) continue;
      }

      if(boolResponse) break;
    }

    // get max count

    String maxCountString;

    while (true) {
      console.clear();
      console.writeLine('Enter max data count (-1 to maximaze, stop to exit):');

      maxCountString = console.readLine();
      maxCountString = maxCountString.trim();

      if(maxCountString == 'stop') return;

      try {
        maxCount = int.parse(maxCountString);

        if(maxCount < -1) continue;
        break;

      } catch (_) {}
    }

    // show 

    console.clear();
    console.writeLine('Name: ' + name);
    console.writeLine('Sources:');
    console.writeList(sources);
    console.writeEmpty();
    console.writeLine('Max count: ' + maxCount.toString());

    console.readLine();
  }
}
