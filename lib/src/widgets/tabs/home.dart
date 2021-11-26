import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
import 'package:flutter_highlight/themes/github.dart';

class HomeTab extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const HomeTab({Key? key, required this.errorDetails}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListView(
      children: [
        Card(
          child: ListTile(
            title: Text(extractErrorFilePath(errorDetails.toString())),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
              errorDetails.exception.toString(),
              style: textTheme.headline3,
            ),
          ),
        ),

        if (errorDetails.context != null)
          Card(
            child: ListTile(
              title: const Text('context'),
              subtitle: Text(
                errorDetails.context!.toString(),
              ),
            ),
          ),
        if (errorDetails.context?.level != null)
          Card(
            child: ListTile(
              title: const Text('Level'),
              subtitle: Text(
                errorDetails.context!.level.toString(),
              ),
            ),
          ),
        if (errorDetails.library != null)
          Card(
            child: ListTile(
              title: Text(
                'library',
                style: textTheme.headline5,
              ),
              subtitle: Text(
                errorDetails.library!,
                style: textTheme.headline6,
              ),
            ),
          ),
        if (errorDetails.context?.linePrefix != null)
          Card(
            child: ListTile(
              title: Text(
                errorDetails.context!.linePrefix!,
                style: textTheme.headline3,
              ),
            ),
          ),
        if (errorDetails.stack != null)
          Card(
            child: ExpansionTile(
                title: Text(
                  'stack',
                  style: textTheme.headline5,
                ),
                children: [
                  Text(
                    errorDetails.stack.toString(),
                  ),
                ]),
          ),

        // Card(
        //   child: ListTile(
        //     title: Text(
        //       errorDetails.toString(),
        //       style: textTheme.headline6,
        //     ),
        //   ),
        // ),
        Card(
          child: ExpansionTile(
            title: Text(errorDetails.toStringShort()),
            children: [
              Text(
                errorDetails.stack.toString(),
                style: textTheme.bodyText1,
              ),
            ],
          ),
        ),
        if (Platform.isWindows)
          readFileContent(extractErrorFilePath(errorDetails.toString())),
      ],
    );
  }
}

String extractErrorFilePath(String error) {
  final lineStart = error.indexOf('file:///');
  final msg = error.replaceRange(0, lineStart + 8, '');
  final endOfLine = msg.indexOf('\n');
  final msgAfterTrimming = msg.substring(0, endOfLine);

  /// remove line number
  final lastLine = msgAfterTrimming.lastIndexOf('.dart') + 5;
  return msgAfterTrimming.substring(0, lastLine);
}

FutureBuilder readFileContent(String path) {
  return FutureBuilder(
    key: UniqueKey(),
    future: File(path).readAsString(),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text(snapshot.error.toString());
      } else if (snapshot.connectionState == ConnectionState.done) {
        return HighlightView(
          // The original code to be highlighted
          snapshot.data,

          // Specify language
          // It is recommended to give it a value for performance
          language: 'dart',

          // Specify highlight theme
          // All available themes are listed in `themes` folder
          theme: draculaTheme,

          // Specify padding
          padding: EdgeInsets.all(12),

          // Specify text style
          textStyle: TextStyle(
            fontFamily: 'My awesome monospace font',
            fontSize: 16,
          ),
        );
      } else {
        return const CircularProgressIndicator();
      }
    },
  );
}
