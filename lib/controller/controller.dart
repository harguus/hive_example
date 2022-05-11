import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_example/adapter/adapter.dart';

import '../model/model.dart';

class Controller extends GetxController {
  final List<Model> names = [];
  late LazyBox box;

  @override
  void onInit() {
    _openBox();
    super.onInit();
  }

  void _openBox() async {
    Hive.registerAdapter(Adapter());
    box = await Hive.openLazyBox<Model>('names');
  }

  reader() {
    names.clear();
    box.keys.forEach((name) async {
      names.add(await box.get(name));
      update();
    });
    update();
  }

  add(Model n) {
    box.put(n.name, n).then((value) => reader());
  }

  delete(String name) {
    box.delete(name).then((value) => reader());
    update();
  }
}
