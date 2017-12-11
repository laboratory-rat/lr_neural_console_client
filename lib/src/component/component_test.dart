import '../app_client.dart';
import 'component_base.dart';
import 'dart:async';

class ComponentTest extends ComponentBase {
  ComponentTest(AppClient app) : super(app);

  Future testDatabase() async {
    console.clear();
    console.writeLine('database test starting');

    try {
      console.seperator();
      console.writeLine('opening connection');

      await app.db.open();

      console.seperator();
      console.writeLine('connection opened');
      console.writeLine('database name: ' + app.db.databaseName);

      console.seperator();
      console.writeLine('getting collections');
      
      var collections = await app.db.getCollectionNames();
      
      console.writeEmpty();
      collections.forEach((x) => console.writeLine((collections.indexOf(x) + 1).toString() + '. ' + x));
      console.writeEmpty();

      console.writeLine('closing connection');
      await app.db.close();

      console.seperator();
      console.writeLine('database is ok');
    } catch (e) {
      console.writeLine('some problems with database.');
      console.writeLine(e.toString());
    }

    console.seperator();
    console.writeLine('press any key to return');
    console.readLine();
  }
}
