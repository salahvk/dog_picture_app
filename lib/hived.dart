import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UrlList extends HiveObject {
  @HiveField(0)
  List<String> urls;

  UrlList({required this.urls});
}
