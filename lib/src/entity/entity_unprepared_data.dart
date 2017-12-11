import 'package:lr_mongo_collection/lr_mongo_collection.dart';
import 'package:lr_twitter_client/lr_twitter_client.dart';

@CollectionOptions('lr_unprepared_data')
class EntityUnpreparedData extends EntityBase implements IEntityBase {
  String name;

  List<String> sources = [];
  int get usersCount => sources == null ? 0 : sources.length; 

  List<TwitterDataTweet> tweets = [];
  int get tweetsCount => tweets.length;

  @override
  Map toMap() {
    var map = super.toMap();

    map['name'] = name;
    map['sources'] = sources;
    map['tweets'] = tweets.map((x) => x.encode()).toList();

    return map;
  }

  @override
  void fromMap(Map m){
    super.fromMap(m);

    name = m['name'];
    sources = m['sources'];
    tweets = m['tweets']?.map((x) => new TwitterDataTweet()..decode(x))?.toList();
  }
}