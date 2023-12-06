import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A Flutter widget for displaying text with an optional "Read more/Read less" button.
///
/// The `AnimatedReadMoreText` widget allows you to present text with a maximum
/// number of lines and provides a button to expand or collapse the content for
/// improved readability.
///
/// ## Usage
///
/// To use this widget, provide the required `text` parameter with the content you
/// want to display. Customize the appearance and behavior by adjusting various
/// optional parameters such as `maxLines`, `readMoreText`, `readLessText`,
/// `textStyle`, and more.
class AnimatedReadMoreText extends StatefulWidget {
  /// Creates an AnimatedReadMoreText widget.
  ///
  /// This widget is designed for displaying text with optional "Read more/Read less"
  /// functionality. It provides a convenient way to present content with a maximum
  /// number of visible lines and offers a button to expand or collapse the text for
  /// improved user interaction.
  ///
  /// ## Example
  ///
  /// ```dart
  /// AnimatedReadMoreText(
  ///   'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
  ///   maxLines: 3,
  ///   readMoreText: 'Show more', // default: 'Read more'
  ///   readLessText: 'Show less', // default: 'Read less'
  /// )
  /// ```
  const AnimatedReadMoreText(
    this.text, {
    super.key,
    this.maxLines = 3,
    this.readMoreText = 'Read more',
    this.readLessText = 'Read less',
    this.textStyle,
    this.buttonTextStyle,
    this.isSuffixButton = true,
    this.allowCollapse = true,
    this.expandOnTextTap = true,
    this.animationCurve = Curves.easeOutBack,
    this.animationDuration = const Duration(milliseconds: 300),
  })  : assert(maxLines > 1, 'maxLines must be greater than 1'),
        assert(text.length > 0, 'text cannot be empty'),
        assert(readMoreText.length > 0, 'readMoreText cannot be empty'),
        assert(readLessText.length > 0, 'readLessText cannot be empty');

  /// The text to be displayed in the widget.
  final String text;

  /// The maximum number of lines to display before collapsing the text.
  /// Must be greater than 1.
  final int maxLines;

  /// The text to display for the "Read more" button.
  /// Must not be an empty string.
  final String readMoreText;

  /// The text to display for the "Read less" button.
  /// Must not be an empty string.
  final String readLessText;

  /// The style to apply to the "Read more/Read less" button.
  final TextStyle? buttonTextStyle;

  /// The style to apply to the displayed text.
  final TextStyle? textStyle;

  /// Determines if the "Read more/Read less" button is displayed as a suffix.
  final bool isSuffixButton;

  /// Controls whether the text can be collapsed.
  final bool allowCollapse;

  /// Enables text expansion when tapped.
  final bool expandOnTextTap;

  /// The animation curve for expanding and collapsing the text.
  final Curve animationCurve;

  /// The duration of the animation.
  final Duration animationDuration;

  @override
  State<AnimatedReadMoreText> createState() => _AnimatedReadMoreTextState();
}

class _AnimatedReadMoreTextState extends State<AnimatedReadMoreText> {
  /// Whether the text is expanded.
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        assert(constraints.hasBoundedWidth,
            'The parent widget must provide bounded width constraints');

        // Obtain the text style that will be used for rendering. If the widget doesn't provide a specific style,
        // use the default style of the current text context.
        final style = widget.textStyle ?? DefaultTextStyle.of(context).style;
        final fontSize =
            style.fontSize ?? DefaultTextStyle.of(context).style.fontSize!;

        // Form a TextSpan object representing the text to be displayed, along with its associated style.
        final textSpan = TextSpan(text: widget.text, style: style);

        // Initialize a TextPainter to measure and layout the text. Set constraints such as the maximum number
        // of lines and text direction.
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final bool showButton = textPainter.didExceedMaxLines &&
            (widget.allowCollapse || !_isExpanded);

        // Find the position of the last character within the available width and considering the maximum number of lines.
        final endPosition = textPainter.getPositionForOffset(Offset(
          constraints.maxWidth,
          // Determine whether the text should be truncated based on the current expansion state.
          // If not expanded, create a substring of the text up to the calculated end position;
          // otherwise, use the full text.
          fontSize * widget.maxLines,
        ));

        // Determine the truncated text based on the current expansion state.
        final truncatedText = !_isExpanded
            ? widget.text.substring(0, endPosition.offset)
            : widget.text;

        return GestureDetector(
          onTap: () {
            if (widget.expandOnTextTap &&
                (widget.allowCollapse || !_isExpanded)) {
              _toggleExpanded();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedCrossFade(
                firstChild: _ExpandableTextSpan(
                  showButton: showButton,
                  text: truncatedText,
                  style: widget.textStyle,
                  buttonTextStyle: widget.buttonTextStyle,
                  readMoreLessText: widget.readMoreText,
                  isSuffixButton: true,
                  // isSuffixButton: widget.isSuffixButton,
                  onPressed: _toggleExpanded,
                ),
                secondChild: _ExpandableTextSpan(
                  showButton: showButton,
                  text: widget.text,
                  style: widget.textStyle,
                  buttonTextStyle: widget.buttonTextStyle,
                  readMoreLessText: widget.readLessText,
                  isSuffixButton: true,
                  // isSuffixButton: widget.isSuffixButton && widget.allowCollapse,
                  onPressed: _toggleExpanded,
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: widget.animationDuration,
                sizeCurve: widget.animationCurve,
              ),
              if (!widget.isSuffixButton &&
                  (widget.allowCollapse || !_isExpanded) &&
                  showButton)
                ReadMoreButton(
                  isExpanded: _isExpanded,
                  readMoreText: widget.readMoreText,
                  readLessText: widget.readLessText,
                  onPressed: _toggleExpanded,
                ),
            ],
          ),
        );
      },
    );
  }

  /// Toggles the expansion state of the widget.
  ///
  /// This method flips the value of [_isExpanded] and triggers a widget rebuild
  /// to reflect the updated state.
  void _toggleExpanded() => setState(() => _isExpanded = !_isExpanded);
}

/// A widget that creates an expandable text span with an optional "Read more/Read less" button.
///
/// The `ExpandableTextSpan` widget allows you to present a portion of text with an optional
/// button to expand or collapse the content for improved readability.
class _ExpandableTextSpan extends StatelessWidget {
  /// Creates an ExpandableTextSpan widget.
  ///
  /// To use this widget, provide the required parameters such as `text`,
  /// `readMoreLessText`, `isSuffixButton`, and `onPressed`. Customize the
  /// appearance and behavior by adjusting optional parameters like `style` and
  /// `buttonTextStyle`.
  const _ExpandableTextSpan({
    required this.showButton,
    required this.text,
    this.style,
    this.buttonTextStyle,
    required this.readMoreLessText,
    required this.isSuffixButton,
    required this.onPressed,
  });

  /// A boolean indicating whether the button should be displayed.
  final bool showButton;

  /// The text to be displayed in the widget.
  final String text;

  /// The style to apply to the displayed text.
  final TextStyle? style;

  /// The style to apply to the "Read more/Read less" button.
  final TextStyle? buttonTextStyle;

  /// The text to display for the "Read more/Read less" button.
  final String readMoreLessText;

  /// Determines if the button is displayed as a suffix.
  final bool isSuffixButton;

  /// The callback function executed when the button is tapped.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text,
        style: style,
        children: [
          if (isSuffixButton && showButton)
            _buildExpandCollapseTextSpan(' $readMoreLessText'),
        ],
      ),
    );
  }

  /// Builds a [TextSpan] for the "Read more/Read less" button.
  ///
  /// This method constructs a [TextSpan] with the provided `text`, `buttonTextStyle`,
  /// and an [onPressed] action using a [TapGestureRecognizer].
  TextSpan _buildExpandCollapseTextSpan(String text) {
    return TextSpan(
      text: text,
      style: buttonTextStyle ??
          const TextStyle(
            fontWeight: FontWeight.bold,
          ),
      recognizer: TapGestureRecognizer()..onTap = onPressed,
    );
  }
}

/// A widget that represents a "Read more/Read less" button.
///
/// The `ReadMoreButton` widget provides a button that changes its text based
/// on whether the associated content is expanded or collapsed.
class ReadMoreButton extends StatelessWidget {
  /// Creates a ReadMoreButton widget.
  ///
  /// To use this widget, provide the required parameters such as `isExpanded`,
  /// `readMoreText`, `readLessText`, and `onPressed`.
  const ReadMoreButton({
    super.key,
    required this.isExpanded,
    required this.readMoreText,
    required this.readLessText,
    required this.onPressed,
  });

  /// A boolean indicating whether the associated content is expanded.
  final bool isExpanded;

  /// The text to display when the content is collapsed.
  final String readMoreText;

  /// The text to display when the content is expanded.
  final String readLessText;

  /// The callback function executed when the button is tapped.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            isExpanded ? readLessText : readMoreText,
          ),
        ),
      ),
    );
  }
}
