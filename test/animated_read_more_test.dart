import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_helpers.dart';

void main() {
  const String longText =
      'Underneath the vast canopy of the ancient forest, a gentle brook meandered its way through the undergrowth. The sunlight filtered through the leaves, casting dappled shadows on the forest floor. Birds chirped merrily from the treetops, their songs echoing through the stillness. A deer grazed peacefully by the water’s edge, its ears twitching at the slightest sound. This was a world untouched by time, a symphony of nature playing its eternal melody.';
  const String shortText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.';

  group('AnimatedReadMoreText widget', () {
    testWidgets('Test AnimatedReadMoreText widget',
        (WidgetTester tester) async {
      // Build your widget
      await pumpAnimatedReadMoreText(tester, longText);

      // Check if the widget is in the tree
      expect(find.byType(AnimatedReadMoreText), findsOneWidget);

      // Check if the LayoutBuilder is in the tree
      expect(find.byType(LayoutBuilder), findsOneWidget);

      // Check if the GestureDetector is in the tree
      expect(find.byType(GestureDetector), findsOneWidget);

      // Check if the AnimatedCrossFade is in the tree
      expect(find.byType(AnimatedCrossFade), findsOneWidget);
    });
  });

  group('maxLines property', () {
    testWidgets('Test AnimatedReadMoreText widget with short text',
        (WidgetTester tester) async {
      // Build your widget
      await pumpAnimatedReadMoreText(tester, shortText);

      // Check if the widget is in the tree
      expect(find.byType(AnimatedReadMoreText), findsOneWidget);

      // Check if the "Show more" button is not in the tree
      expect(findRichTextWithText('Show more'), findsNothing);

      // Check if the "Show less" button is not in the tree
      expect(findRichTextWithText('Show less'), findsNothing);
    });
  });

  group('expandOnTextTap property', () {
    // Test the expandOnTextTap property set to true
    testWidgets('expandOnTextTap property set to true',
        (WidgetTester tester) async {
      await pumpAnimatedReadMoreText(tester, longText, expandOnTextTap: true);

      // Check the crossFadeState of the AnimatedCrossFade widget
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showFirst);

      // Get the bounding box of the text block
      final textBlockRect = tester.getRect(find.byType(AnimatedReadMoreText));

      // Calculate the top-left point of the text block
      final topLeft = textBlockRect.topLeft;

      // Tap the top-left point of the text block to expand it
      await tester.tapAt(topLeft);
      await tester.pumpAndSettle();

      // Check the crossFadeState of the AnimatedCrossFade widget
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showSecond);

      // Tap the top-left point of the text block to collapse it
      await tester.tapAt(topLeft);
      await tester.pumpAndSettle();

      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showFirst);
    });

    // Test the expandOnTextTap property set to false
    testWidgets('expandOnTextTap property set to false',
        (WidgetTester tester) async {
      await pumpAnimatedReadMoreText(tester, longText, expandOnTextTap: false);

      // Check the crossFadeState of the AnimatedCrossFade widget
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showFirst);

      // Get the bounding box of the text block
      final textBlockRect = tester.getRect(find.byType(AnimatedReadMoreText));

      // Calculate the top-left point of the text block
      final topLeft = textBlockRect.topLeft;

      // Tap the top-left point of the text block to expand it
      // It should not expand because expandOnTextTap is set to false
      await tester.tapAt(topLeft);
      await tester.pumpAndSettle();

      // Check the crossFadeState of the AnimatedCrossFade widget
      // Verify that the text block is still collapsed.
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showFirst);
    });
  });

  group('expand and collapse of AnimatedReadMoreText', () {
    testWidgets(
        'expand and collapse of AnimatedReadMoreText widget b ytapping the Read more and Read less buttons',
        (WidgetTester tester) async {
      // Build your widget
      await pumpAnimatedReadMoreText(tester, longText);

      // Check if the widget is in the tree
      expect(find.byType(AnimatedReadMoreText), findsOneWidget);

      // Check if the "Show more" button is in the tree
      expect(findRichTextWithText('Show more'), findsOneWidget);

      // Check the crossFadeState of the AnimatedCrossFade widget
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showFirst);

      // Tap the "Show more" button
      await tester.tap(findRichTextWithText('Show more'));
      await tester.pumpAndSettle();

      // Check if the "Show less" button is in the tree
      expect(findRichTextWithText('Show less'), findsOneWidget);

      // Check the crossFadeState of the AnimatedCrossFade widget
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showSecond);

      // Tap the "Show less" button
      await tester.tap(findRichTextWithText('Show less'));
      await tester.pumpAndSettle();

      // Check if the "Show more" button is in the tree again
      expect(findRichTextWithText('Show more'), findsOneWidget);

      // Check the crossFadeState of the AnimatedCrossFade widget
      expect(
          tester
              .widget<AnimatedCrossFade>(find.byType(AnimatedCrossFade))
              .crossFadeState,
          CrossFadeState.showFirst);
    });

    // Test the allowCollapse property
    testWidgets('allowCollapse property', (WidgetTester tester) async {
      await pumpAnimatedReadMoreText(tester, longText, allowCollapse: false);

      // Check if the "Show less" button is not in the tree
      expect(find.text('Show less'), findsNothing);

      // Check that the widget does not collapse the text once it has been expanded
      // Tap the "Show more" button
      await tester.tap(findRichTextWithText('Show more'));
      await tester.pumpAndSettle();

      // Check if the "Show less" button is not in the tree
      expect(find.text('Show less'), findsNothing);
    });
  });
}
