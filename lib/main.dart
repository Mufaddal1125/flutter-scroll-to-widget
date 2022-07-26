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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // create list of global keys
  List<GlobalKey> _fruitKeys = [];

  // create scroll controller for scrolling to fruit
  final _scrollController = ScrollController();

  @override
  void initState() {
    // add key for each fruit to _fruitKeys
    _fruitKeys = fruits.map((e) => GlobalKey()).toList();
    super.initState();
  }

  var fruits = [
    'Apple',
    'Banana',
    'Cherry',
    'Grape',
    'Kiwi',
    'Mango',
    'Orange',
    'Pear',
    'Strawberry',
    'Watermelon',
    'Elderberry',
    'Eggfruit',
    'Evergreen',
    'Huckleberry',
    'Entawak',
    'Grapefruit',
    'Grapes',
    'Gooseberries',
    'Guava',
    'Honeydew',
    'Kumquat',
    'Lemon',
    'Lime',
    'Lychee',
    'Mandarina',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scroll to Widget'),
      ),
      body: Center(
        child: ListView.builder(
          // assign scroll controller to list view
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Colors.yellow,
              ),
              child: ListTile(
                // assign key to each item
                key: _fruitKeys[index],
                title: Text(fruits[index]),
              ),
            );
          },
          itemCount: fruits.length,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Scroll to Gooseberries',
        onPressed: _scrollToWidget,
        label: const Text('Scroll to Gooseberries'),
        icon: const Icon(Icons.arrow_upward_rounded),
      ),
    );
  }

  void _scrollToWidget() async {
    // find the index of fruit to scroll to in fruits
    // let's scroll to Gooseberries
    final index = fruits.indexOf('Gooseberries');
    // get global key of Gooseberries
    final key = _fruitKeys[index];
    // find the render box of Gooseberries
    var box = key.currentContext?.findRenderObject();

    // if box is not in the view port, scroll to it
    if (box == null) {
      // speed to scroll to Gooseberries
      double scrollSpeed;
      // find the key of the render box which is currently in view
      var currentKeyIndex = _fruitKeys.indexWhere(
          (element) => element.currentContext?.findRenderObject() != null);
      // if currently visible fruit is before fruit to scroll to,
      // then speed should be negative otherwise positive
      scrollSpeed = currentKeyIndex > index ? 100 : -100;

      // scroll until render object is found
      while (box == null) {
        var offset = _scrollController.offset - scrollSpeed;
        await _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeInOut,
        );
        box = key.currentContext?.findRenderObject();
      }
    }

    _scrollController.position.ensureVisible(
      box,
      // How far into view the item should be scrolled (between 0 and 1)
      // with 1 being the bottom of the view and 0 being the top.
      alignment: 0.2,
      duration: const Duration(milliseconds: 200),
    );
  }
}
