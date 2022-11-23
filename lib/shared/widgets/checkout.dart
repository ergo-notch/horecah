import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Checkout extends StatefulWidget {

  final String url;
  final Function(String endpoint) callback;

  const Checkout({Key? key,required this.url,required this.callback}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (cntx) {
          return WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.contains('confirm')) {
                final endpoint = request.url.split("redirect");
                widget.callback(endpoint.last);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },

          );
        },
      ),
    );
  }
}
