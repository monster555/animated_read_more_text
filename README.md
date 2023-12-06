# AnimatedReadMoreText

A Flutter package that provides a customizable widget for displaying text with an optional "Read more/Read less" button, enhancing the user experience for text-heavy content.

## Overview

The **AnimatedReadMoreText** widget is a Flutter package that provides a user-friendly and visually appealing way to present lengthy text content. It dynamically adapts text length based on a predefined maximum line count, ensuring optimal readability on various screen sizes. The widget's key feature is its ability to seamlessly expand or collapse text based on user interaction. This functionality enhances readability by allowing users to focus on specific sections of text without being overwhelmed by lengthy passages. Additionally, the widget's subtle yet impactful animations add a touch of elegance to the user interface, further enhancing the overall reading experience.


https://github.com/monster555/animated_read_more_text/assets/32662133/273d6a58-efc7-4079-b52c-0d0c86090e0e


## Features

- Lightweight and easy to use
- Displays text with a specified maximum number of lines.
- Set custom labels for the "Read more" and "Read less" buttons to match your app's branding and enhance the user experience.
- Customizable appearance and behavior.
- Supports optional styling for the text and button.
- Smooth and customizable animations for text expansion and collapse.

## Usage

To use this package, include it in your `pubspec.yaml` file:

```yaml
dependencies:
  animated_read_more_text: ^0.0.1
```
Import the package in your Dart file:

```dart
import 'package:animated_read_more_text/animated_read_more_text.dart';
```

Use the AnimatedReadMoreText widget in your Flutter application:
```dart
AnimatedReadMoreText(
  yourLongText,
  maxLines: 3,
  // Set a custom text for the expand button. Defaults to Read more
  readMoreText: 'Expand',
  // Set a custom text for the collapse button. Defaults to Read less
  readLessText: 'Collapse',
  // Set a custom text style for the main block of text
  textStyle: TextStyle(
    fontSize: 16,
    color: Colors.red,
  ),
  // Set a custom text style for the expand/collapse button
  buttonTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
)
```

## Example
```dart
AnimatedReadMoreText(
  yourLongText,
  // Set the curve of the animation
  animationCurve: Curves.easeInOut,
  // Set the duration of the animation
  animationDuration: Duration(milliseconds: 500),
)
```
## Contributions
Contributions and bug reports are welcome! Please feel free to create an issue or submit a pull request.

## License
This package is licensed under the MIT License - see the LICENSE file for details.
