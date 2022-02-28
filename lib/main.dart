import 'package:flutter/material.dart';
import 'package:keys/src/positioned-tiles-stateless.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var demos = [
      ColorSwapDemo(
          title: 'Stateless colors',
          tilesBuilder: () => StatelessColorfulTile()),
      ColorSwapDemo(
          title: 'Stateful colors - broken',
          tilesBuilder: () => const StatefullColorfulTile()),
      ColorSwapDemo(
          title: 'Stateful colors - fixed',
          tilesBuilder: () => StatefullColorfulTile(
                key: UniqueKey(),
              )),
      ColorSwapDemo(
          title: 'Stateful - broken keys (child)',
          tilesBuilder: () => Padding(
                padding: const EdgeInsets.all(10),
                child: StatefullColorfulTile(key: UniqueKey()),
              )),
      ColorSwapDemo(
          title: 'Stateful - fixed keys (parent)',
          tilesBuilder: () => Padding(
                key: UniqueKey(),
                padding: const EdgeInsets.all(10),
                child: const StatefullColorfulTile(),
              ))
    ];

    return ListView.separated(
        itemBuilder: (context, index) => demos[index],
        separatorBuilder: (_, __) => const Divider(),
        itemCount: demos.length);
  }
}

class ColorSwapDemo extends StatelessWidget {
  final String title;
  final SimpleWidgetCreator tilesBuilder;

  const ColorSwapDemo(
      {Key? key, required this.title, required this.tilesBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
      children: [Text(title), PositionedTiles(tilesBuilder: tilesBuilder)]);
}
