import 'package:animated_expand/animated_expand.dart';
import 'package:flutter/material.dart';

const title = 'AnimatedExpand - Controller Demo';

void main() {
  runApp(MaterialApp(
    title: title,
    home: ExamplePage(),
  ));
}

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final expandController = ExpandController(initialValue: ExpandState.expanded);

  var _childrenColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      floatingActionButton: FloatingActionButton(
        onPressed: expandController.toggle,
        child: Text('Toggle'),
      ),
      body: Center(
        child: AnimatedExpand(
          axis: Axis.horizontal,
          controller: expandController,
          expandedHeader: _expandedHeader,
          collapsedHeader: _collapsedHeader,
          onEnd: () {
            if (expandController.isCollapsed) {
              setState(() => _childrenColor =
                  _childrenColor == Colors.blue ? Colors.red : Colors.blue);
            }
          },
          content: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  5,
                  (i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Child ${i + 1}',
                          style: TextStyle(color: _childrenColor),
                        ),
                      ))),
        ),
      ),
    );
  }

  Widget get _expandedHeader => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: expandController.collapse,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Collapse'),
              SizedBox(width: 4),
              Icon(Icons.arrow_back_ios),
            ],
          ),
        ),
      );

  Widget get _collapsedHeader => InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: expandController.expand,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Expand'),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      );
}
