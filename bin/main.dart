import 'dart:async';

import 'package:console/console.dart';
import 'package:lr_neural_console_client/lr_neural_console_client.dart';
import 'package:args/args.dart';

const connection_string = 'connection-string';
const twitter_key = 'twitter-key';
const twitter_secret = 'twitter-secret';

Future main(List<String> arguments) async {
  final parser = new ArgParser()
    ..addOption(connection_string, help: 'mongo db connection string', abbr: 'c')
    ..addOption(twitter_key, help: 'app key from your twitter app', abbr: 'k')
    ..addOption(twitter_secret, help: 'app secret from your twitter app', abbr: 's')
    ..addFlag('help', abbr: 'h', defaultsTo: false, negatable: false, help: 'show this message');

  final args = parser.parse(arguments);

  if (args['help'] || args[connection_string] == null || args[twitter_key] == null || args[twitter_secret] == null) {
    print(parser.usage);
    return '';
  }

  var app = new AppClient(args[connection_string], args[twitter_key], args[twitter_secret]);
  await app.init();
}
