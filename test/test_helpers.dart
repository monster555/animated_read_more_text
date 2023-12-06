import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// This function returns a Finder that matches [RichText] widgets containing the specified text.
///
/// The function uses a widget predicate to filter widgets. The predicate takes a [Widget] and checks if it's a [RichText] widget. If it is, the function checks if the plain text of the [RichText] widget contains the specified text. If the text is found, the function returns true, indicating that the widget matches the predicate.
///
/// This function is useful for finding [RichText] widgets in widget tests. For example, it can be used to find a [RichText] widget representing a button with a specific label.
///
/// - [text] The text to search for in the [RichText] widgets.
/// - Return a Finder that matches [RichText] widgets containing the specified text.
Finder findRichTextWithText(String text) => find.byWidgetPredicate(
      (Widget widget) {
        // Check if the widget is a RichText widget
        if (widget is RichText) {
          // If it is, check if the plain text of the RichText widget contains the specified text
          return widget.text.toPlainText().contains(text);
        }
        // If the widget is not a RichText widget, it doesn't match the predicate
        return false;
      },
    );

/// This function builds and renders an [AnimatedReadMoreText] widget in a test environment.
///
/// The function takes a [WidgetTester] and a string of text to display in the widget. It also takes optional parameters for the [maxLines], [expandOnTextTap], and [allowCollapse] properties of the [AnimatedReadMoreText] widget. The function uses these parameters to create an [AnimatedReadMoreText] widget, which it then renders using the [pumpWidget] method of the [WidgetTester].
///
/// This function is useful for reducing code duplication in widget tests. Instead of creating and rendering an [AnimatedReadMoreText] widget in each individual test, you can call this function with the desired parameters.
///
/// - [tester] The [WidgetTester] to use for rendering the widget.
/// - [text] The text to display in the [AnimatedReadMoreText] widget.
/// - [maxLines] The maximum number of lines to display in the [AnimatedReadMoreText] widget.
/// - [expandOnTextTap] Whether the [AnimatedReadMoreText] widget should expand when the text is tapped.
/// - [allowCollapse] Whether the [AnimatedReadMoreText] widget should allow collapsing.
/// - Return a [Future] that completes when the widget has been rendered.
Future<void> pumpAnimatedReadMoreText(
  WidgetTester tester,
  String text, {
  int maxLines = 3,
  bool expandOnTextTap = true,
  bool allowCollapse = true,
}) async {
  await tester.pumpWidget(MaterialApp(
    home: Scaffold(
      body: AnimatedReadMoreText(
        text,
        maxLines: maxLines,
        expandOnTextTap: expandOnTextTap,
      ),
    ),
  ));
}
