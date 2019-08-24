import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_demo/router.dart';

class WebviewPage extends StatefulWidget {
  final String url;
  final Map<String, dynamic> params;

  WebviewPage(this.url, {Key key, this.params})
      : assert(url != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    String url = widget.url;
    Map<String, dynamic> params = widget.params;
    if (params != null && params.isNotEmpty) {
      //
      Uri _url = Uri(queryParameters: params);
      url = '$url?${_url.query}';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('122'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: WebView(
        initialUrl: url,
        onPageFinished: (str) async {
          String url = await _controller.currentUrl();
        },
        onWebViewCreated: (WebViewController controller) {
          _controller = controller;
          print('created');
        },
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest navigation) {
          print('================= ${navigation.url}}');
//          Router.push(context, navigation.url, null);
//          _controller.loadUrl(navigation.url);
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
