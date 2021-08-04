import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

WebViewController? controllerGlobal;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebViewController? _webViewController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 50));
    _webViewController!.reload();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(190, 158, 78, 1),
            child: SafeArea(
                bottom: false,
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: _onRefresh,
                  controller: _refreshController,
                  child: WebView(
                    onWebViewCreated: (controller) {
                      _webViewController = controller;
                    },
                    initialUrl: 'https://www.e-parwarda.com',
                    javascriptMode: JavascriptMode.unrestricted,
                    gestureNavigationEnabled: true,
                  ),
                ))));
  }
}
