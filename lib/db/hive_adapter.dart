import 'package:dog_picture_app/db/hiveGen.dart';
import 'package:hive/hive.dart';

class UrlListAdapter extends TypeAdapter<UrlList> {
  @override
  final typeId = 0;

  @override
  UrlList read(BinaryReader reader) {
    final urlsLength = reader.readInt();
    final urls = List<String>.generate(urlsLength, (_) => reader.readString());
    return UrlList(urls: urls);
  }

  @override
  void write(BinaryWriter writer, UrlList obj) {
    writer.writeInt(obj.urls.length);
    obj.urls.forEach(writer.writeString);
  }
}
