import 'package:flutter/material.dart';
import 'package:header_pin_view/header_pin_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Header Pin View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: HeaderPinnedView(
        headerSliverBuilder: headerSliverBuilder(context),
        sliverPersistentHeader: sliverPersistentHeader(context),
        body: body(context),
        sliverPersistentHeaderHeight: sliverPersistentHeaderHeight,
      ),
    );
  }

  Widget headerSliverBuilder(BuildContext context) {
    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.red,
      child: Center(
        child: Text(
          'Header',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget sliverPersistentHeader(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue,
      child: Center(
        child: Text(
          'Persistent Header',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),

        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
        itemCount: 100,
      ),
    );
  }

  double sliverPersistentHeaderHeight = 60;
}
