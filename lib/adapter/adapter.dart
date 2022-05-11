import 'package:hive/hive.dart';

import '../model/model.dart';

class Adapter extends TypeAdapter<Model> {
  @override
  final typeId = 1;

  @override
  Model read(BinaryReader reader) {
    return Model(name: reader.readString());
  }

  @override
  void write(BinaryWriter writer, Model obj) {
    writer.writeString(obj.name);
  }
}
