import 'component/component_test.dart';
import 'component/component_unprepared_data.dart';
import 'dart:async';

import 'menu/menu_home.dart';
import 'package:lr_twitter_client/lr_twitter_client.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:console/console.dart';

class AppClient {
  LrTwitterClient twitterClient;
  Db db;
  String connectionString;

  // components
  ComponentTest tests;
  ComponentUnpreparedData unpreparedData;

  // console helper
  final ConsoleHelper console = new ConsoleHelper();

  AppClient(String mongoConnectionString, String twitterAppKey, String twitterAppSecret) {
    twitterClient = new LrTwitterClient.fromApp(twitterAppKey, twitterAppSecret);
    db = new Db(mongoConnectionString);
    connectionString = mongoConnectionString;
  }

  Future<String> init() async {
    Console.init();

    initComponents();
    var menu = new MenuHome(this);

    await menu.show();

    return 'lr_neural_console_client closed';
  }

  void initComponents() {
    tests = new ComponentTest(this);
    unpreparedData = new ComponentUnpreparedData(this);
  }
}

class ConsoleHelper {
  String get sp => new Iterable.generate(Console.columns, (x) => '-').toList().join();

  void writeLine(String line) {
    Console.adapter.writeln(line);
  }

  void writeList(List<String> list) {
    if(list == null || list.isEmpty) writeEmpty();
    else {
      for(int i = 0; i < list.length; i++){
        writeLine((i + 1).toString() + '. ' + list[i]);
      }
    }
  }

  void writeEmpty(){
    writeLine('');
  }

  void clear() {
    Console.eraseDisplay(2);
  }

  void seperator() {
    Console.adapter.writeln(sp);
  }

  String readLine() {
    return Console.readLine();
  }
}
