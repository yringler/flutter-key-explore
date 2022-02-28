import 'dart:math';
import 'package:flutter/material.dart';

typedef SimpleWidgetCreator = Widget Function();

/// Create two colored tiles, and a button to swap their positions.
class PositionedTiles extends StatefulWidget {
  final SimpleWidgetCreator tilesBuilder;

  const PositionedTiles({Key? key, required this.tilesBuilder})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PositionedTilesState();
}

class _PositionedTilesState extends State<PositionedTiles> {
  late List<Widget> tiles;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: tiles,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                tiles.insert(0, tiles.removeLast());
              });
            },
            child: const Text('Swap'),
          )
        ],
      );

  @override
  void initState() {
    super.initState();
    tiles = [widget.tilesBuilder(), widget.tilesBuilder()];
  }
}

/// A colored square.
class ColorfulTile extends StatelessWidget {
  final Color color;

  const ColorfulTile({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox.square(
        dimension: 20,
        child: Container(color: color),
      );
}

/// Get a random color.
Color randomColor() =>
    Colors.primaries[Random().nextInt(Colors.primaries.length)];

/// A randomly colored square. Stateless.
class StatelessColorfulTile extends StatelessWidget {
  final color = randomColor();

  StatelessColorfulTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ColorfulTile(color: color);
}

/// A randomly colored square. Stateful - the color is created and stored in this
/// widget's state object.
class StatefullColorfulTile extends StatefulWidget {
  const StatefullColorfulTile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StatefullColorfulTileState();
}

class _StatefullColorfulTileState extends State<StatefullColorfulTile> {
  late Color color;

  @override
  void initState() {
    super.initState();

    color = randomColor();
  }

  @override
  Widget build(BuildContext context) => ColorfulTile(
        color: color,
      );
}
