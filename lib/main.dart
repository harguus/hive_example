import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_example/controller/controller.dart';
import 'package:hive_example/model/model.dart';

import 'data/HiveDataConfing.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveDataConfig.start();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final Controller c = Get.put(Controller());
    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hive example'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Text for save',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => c.add(Model(name: textController.text)),
                  child: const Text('add'),
                ),
                ElevatedButton(
                  onPressed: () => c.reader(),
                  child: const Text('Reader'),
                ),
                ElevatedButton(
                  onPressed: () => c.delete(textController.text),
                  child: const Text('Delete'),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: GetBuilder<Controller>(
                builder: (_) => ListView.builder(
                  itemCount: c.names.length,
                  itemBuilder: (_, i) {
                    return ListTile(
                      title: Text(c.names[i].name),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
