import 'package:hive/hive.dart';

addUrl(String url) async {
  var box = Hive.box('urlList');
  List<String> urls = List<String>.from(box.get('urls') ?? []);
  urls.add(url);
  await box.put('urls', urls);
}
