import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QErrorPage extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const QErrorPage({Key? key, required this.errorDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error 👑'),
        actions: [
          //// open url in stack overflow seatch
          IconButton(
            icon: const Icon(FontAwesomeIcons.stackOverflow),
            onPressed: () {
              launch(
                  'https://stackoverflow.com/search?q=%5Bflutter%5D+%5Bdart%5D+${errorDetails.exception.toString()}');
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.google),
            onPressed: () {
              launch(
                  'https://google.com/search?q=${errorDetails.exception.toString()}');
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.share),
            onPressed: () {
              /// copy the exception to clipboard
              Clipboard.setData(
                  ClipboardData(text: errorDetails.exception.toString()));
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorDetails.exception.toString()),
          Text(errorDetails.stack.toString()),
        ],
      ),
    );
  }
}
