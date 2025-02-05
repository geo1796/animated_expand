import 'package:animated_expand/animated_expand.dart';
import 'package:flutter/material.dart';

const title = 'AnimatedExpand - Basic Demo';

void main() {
  runApp(MaterialApp(
    title: title,
    home: Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: AnimatedExpand(
          mainAxisAlignment: MainAxisAlignment.center,
          expandedHeader: _exampleExpandedHeader,
          collapsedHeader: _exampleCollapsedHeader,
          content: Column(
              children: List.generate(
                  5,
                  (i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Child ${i + 1}'),
                      ))),
        ),
      ),
    ),
  ));
}

Widget get _exampleCollapsedHeader => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Expand'),
        SizedBox(width: 4),
        Icon(Icons.expand_more),
      ],
    );

Widget get _exampleExpandedHeader => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Collapse'),
        SizedBox(width: 4),
        Icon(Icons.expand_less),
      ],
    );
