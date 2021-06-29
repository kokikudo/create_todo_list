import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        "add": (BuildContext context) => const AddPage(title: "Add Page"),
      },
      home: MainPage(
        title: "Main",
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> list = [
    'ニンジンを買う',
    'タマネギを買う',
    'ジャガイモを買う',
    'カレールーを買う',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          // widget.~ で定義したプロパティが呼び出せる
          widget.title,
        ),
      ),
      // リストの中のテキストを渡してカード化し、それらをリストにして表示
      body: ListView(children: list.map((String e) => _card(e)).toList()),

      floatingActionButton: FloatingActionButton(
        // 追加処理をするページに移動し、戻ってくるまで処理を中断
        onPressed: () async {
          final newAddText = await Navigator.pushNamed(context, "add");
          // 戻ってきたタイミングで送られてきたデータをアンラップしリストに追加
          if (newAddText != null) {
            setState(() {
              list.add(newAddText.toString());
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // カードにする
  Widget _card(String e) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 300,
        height: 100,
        child: Text(
          e,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String _addText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _addText,
              style: const TextStyle(color: Colors.blue, fontSize: 30),
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  _addText = value;
                });
              },
            ),
            // 余白を設定
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_addText);
              },
              child: const Text(
                "add",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
            ),
            const SizedBox(
              height: 8,
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "cancel",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
