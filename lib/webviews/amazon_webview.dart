import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class AmazonWebView extends StatefulWidget {
  WebViewController? webViewController;
  Function(WebViewController)? onWebViewCreated;
  String? url;
  JavascriptMode mode;
  AmazonWebView(
      {Key? key,
      required this.webViewController,
      required this.url,
      required this.mode,
      required this.onWebViewCreated})
      : super(key: key);

  @override
  State<AmazonWebView> createState() => _AmazonWebViewState();
}

class _AmazonWebViewState extends State<AmazonWebView>
    with AutomaticKeepAliveClientMixin<AmazonWebView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebView(
      key: UniqueKey(),
      onWebViewCreated: widget.onWebViewCreated,
      initialUrl: widget.url,
      javascriptMode: widget.mode,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
