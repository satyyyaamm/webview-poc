import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class FlipkartWebView extends StatefulWidget {
  WebViewController? webViewController;
  Function(WebViewController)? onWebViewCreated;
  String? url;
  JavascriptMode mode;
  FlipkartWebView(
      {Key? key,
      required this.webViewController,
      required this.onWebViewCreated,
      required this.mode,
      required this.url})
      : super(key: key);

  @override
  State<FlipkartWebView> createState() => _FlipkartWebViewState();
}

class _FlipkartWebViewState extends State<FlipkartWebView>
    with AutomaticKeepAliveClientMixin<FlipkartWebView> {
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
