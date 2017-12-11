import '../entity/entity_unprepared_data.dart';
import 'package:lr_mongo_collection/lr_mongo_collection.dart';

class CollectionUnpreparedData extends CollectionBase<EntityUnpreparedData> implements ICollectionBase{
  CollectionUnpreparedData(String connection) : super(connection);
}