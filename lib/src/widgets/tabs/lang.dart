import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nations/nations.dart';

class LangTab extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
  const LangTab({Key? key, required this.errorDetails}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            title: const Text('Language'),
            subtitle: Text(Nations.locale.toString()),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Default Gender'),
            subtitle: Text(describeEnum(Nations.config.defaultGender)),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Supported Locales'),
            subtitle: Text(Nations.supportedLocales.toString()),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Loader'),
            subtitle: Text(Nations.config.loader.toString()),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Loader'),
            subtitle: Text('not found builder result => ' +
                Nations.config.notFoundBuilder('key')),
          ),
        ),
        Card(
          child: ListTile(
            title: const Text('Loader'),
            subtitle: Text('not found builder result => ' +
                Nations.config.notFoundBuilder('key')),
          ),
        ),
      ],
    );
  }
}
