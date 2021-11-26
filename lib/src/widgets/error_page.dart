import 'package:error_page/src/widgets/tabs/home.dart';
import 'package:error_page/src/widgets/tabs/lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QErrorPage extends StatefulWidget {
  final FlutterErrorDetails errorDetails;
  const QErrorPage({Key? key, required this.errorDetails}) : super(key: key);

  @override
  State<QErrorPage> createState() => _QErrorPageState();
}

class _QErrorPageState extends State<QErrorPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Error Page 😢'),
          actions: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.stackOverflow),
              onPressed: () => launch(
                  'https://stackoverflow.com/search?q=%5Bflutter%5D+%5Bdart%5D+${widget.errorDetails.exception.toString()}'),
            ),
            IconButton(
              icon: const Icon(FontAwesomeIcons.google),
              onPressed: () => launch(
                  'https://google.com/search?q=${widget.errorDetails.exception.toString()}'),
            ),
            IconButton(
              icon: const Icon(FontAwesomeIcons.copy),
              onPressed: () => Clipboard.setData(ClipboardData(
                  text: widget.errorDetails.exception.toString())),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: Icon(FontAwesomeIcons.home),
                text: 'Home',
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.language),
                text: 'Lang',
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            HomeTab(errorDetails: widget.errorDetails),
            LangTab(errorDetails: widget.errorDetails),
          ],
        ));
  }
}
