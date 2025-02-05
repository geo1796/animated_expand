import 'package:animated_expand/animated_expand.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExpandController tests', () {
    test('Initial state is collapsed by default', () {
      final controller = ExpandController();
      expect(controller.value, ExpandState.collapsed);
      expect(controller.isCollapsed, isTrue);
      expect(controller.isExpanded, isFalse);
    });

    test('Can be initialized as expanded', () {
      final controller = ExpandController(initialValue: ExpandState.expanded);
      expect(controller.value, ExpandState.expanded);
      expect(controller.isExpanded, isTrue);
      expect(controller.isCollapsed, isFalse);
    });

    test('Expands correctly', () {
      final controller = ExpandController();
      controller.expand();
      expect(controller.value, ExpandState.expanded);
    });

    test('Collapses correctly', () {
      final controller = ExpandController(initialValue: ExpandState.expanded);
      controller.collapse();
      expect(controller.value, ExpandState.collapsed);
    });

    test('Toggle switches between states', () {
      final controller = ExpandController();
      controller.toggle();
      expect(controller.value, ExpandState.expanded);
      controller.toggle();
      expect(controller.value, ExpandState.collapsed);
    });

    test('Calling expand() when already expanded does nothing', () {
      final controller = ExpandController(initialValue: ExpandState.expanded);
      controller.expand();
      expect(controller.value, ExpandState.expanded);
    });

    test('Calling collapse() when already collapsed does nothing', () {
      final controller = ExpandController();
      controller.collapse();
      expect(controller.value, ExpandState.collapsed);
    });
  });
}
