import 'package:animated_read_more_text/animated_read_more_text.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedReadMoreText Example'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              // Example 1: Basic usage
              AnimatedReadMoreText(
                'This is a short text that will be displayed in its entirety because it does not exceed the maximum number of lines.',
              ),

              SizedBox(height: 16),

              // Example 2: Long text with custom styles, custom "Read more" and "Read less" buttons text, and no expand on text tap
              AnimatedReadMoreText(
                'This is a long text that exceeds the maximum number of lines. It will be truncated and an "Expand" button will be displayed, overrising the default "Read more". The text has a custom style with a font size of 16.0 and a color of blue. The "Read more" button also has a custom style with a font size of 14.0 and a color of red.',
                maxLines: 3,
                readMoreText: 'Expand',
                readLessText: 'Collapse',
                textStyle: TextStyle(fontSize: 16.0, color: Colors.blue),
                buttonTextStyle: TextStyle(fontSize: 14.0, color: Colors.red),
                expandOnTextTap: false,
              ),

              SizedBox(height: 16),

              // Example 3: Expand on text tap
              AnimatedReadMoreText(
                'This text block is designed to be user-friendly. By tapping anywhere on the text, not just the ‘Read more’ button, you can expand the content. This feature enhances the user experience by making the entire text block interactive. It provides an intuitive way to access additional content. So, tap on the text and discover more!',
                expandOnTextTap: true,
              ),

              SizedBox(height: 16),

              // Example 4: Non-collapsible text
              AnimatedReadMoreText(
                'This text can be expanded, but not collapsed. Once the "Read more" button is tapped, the text will be displayed in its entirety and cannot be truncated again. This is useful if you want to ensure that the user sees the full text once they have chosen to expand it.',
                allowCollapse: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
