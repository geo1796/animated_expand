import 'package:animated_expand/animated_expand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AnimatedExpand tests', () {
    testWidgets('Renders collapsed state initially',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            initialState: ExpandState.collapsed,
          ),
        ),
      );

      expect(find.text('Collapsed Header'), findsOneWidget);
      expect(find.text('Expanded Header'), findsNothing);
      expect(find.text('Content'), findsNothing); // Content should be hidden
    });

    testWidgets('Expands when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            initialState: ExpandState.collapsed,
          ),
        ),
      );

      // Tap the header
      await tester.tap(find.text('Collapsed Header'));
      await tester.pumpAndSettle(); // Wait for animation

      expect(find.text('Expanded Header'), findsOneWidget);
      expect(find.text('Collapsed Header'), findsNothing);
      expect(find.text('Content'), findsOneWidget); // Content should be visible
    });

    testWidgets('Collapses when tapped again', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            initialState: ExpandState.expanded,
          ),
        ),
      );

      // Tap the header
      await tester.tap(find.text('Expanded Header'));
      await tester.pumpAndSettle(); // Wait for animation

      expect(find.text('Collapsed Header'), findsOneWidget);
      expect(find.text('Expanded Header'), findsNothing);
      expect(find.text('Content'), findsNothing); // Content should be hidden
    });

    testWidgets('Works with an external ExpandController',
        (WidgetTester tester) async {
      final controller = ExpandController();

      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            controller: controller,
          ),
        ),
      );

      expect(find.text('Collapsed Header'), findsOneWidget);
      expect(find.text('Content'), findsNothing);

      // Expand using controller
      controller.expand();
      await tester.pumpAndSettle();

      expect(find.text('Expanded Header'), findsOneWidget);
      expect(find.text('Content'), findsOneWidget);
    });

    testWidgets('Reversed order works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            reversed: true,
            initialState: ExpandState.expanded,
          ),
        ),
      );

      // Verify order: Content should come first
      final columnFinder = find.byType(Column);
      final children = tester.widget<Column>(columnFinder).children;

      expect(children[0] is AnimatedSize, true);
      expect(children[1] is GestureDetector, true);
    });

    testWidgets('Triggers onEnd callback when animation completes',
        (WidgetTester tester) async {
      bool animationEnded = false;

      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            onEnd: () => animationEnded = true,
          ),
        ),
      );

      await tester.tap(find.text('Collapsed Header'));
      await tester.pumpAndSettle();

      expect(animationEnded, isTrue);
    });

    testWidgets('Correctly updates alignment and spacing',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: AnimatedExpand(
            expandedHeader: Text('Expanded Header'),
            collapsedHeader: Text('Collapsed Header'),
            content: Text('Content'),
            animationAlignment: Alignment.topLeft,
            spacing: 20.0,
          ),
        ),
      );

      final columnFinder = find.byType(Column);
      final column = tester.widget<Column>(columnFinder);

      expect(column.mainAxisAlignment, equals(MainAxisAlignment.start));
      expect(column.crossAxisAlignment, equals(CrossAxisAlignment.center));
    });
  });
}
