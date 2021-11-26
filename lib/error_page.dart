library error_page;

import 'package:error_page/src/widgets/error_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QueenErrorPage {
  static void boot() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      /// return a button when clicked go to QErrorPage
      // ignore: dead_code
      return Builder(builder: (context) {
        return LayoutBuilder(
          builder: (context, constrain) {
            if (constrain.maxWidth > 100.0 && false) {
              return SadError();
            } else {
              return Material(
                child: Center(
                  child: OutlinedButton(
                    child: Text('Error'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              QErrorPage(errorDetails: details),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
          },
        );
      });
    };
  }
}

class SadError extends StatelessWidget {
  const SadError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text('😢')));
  }
}
