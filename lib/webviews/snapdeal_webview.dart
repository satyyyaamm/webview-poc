import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class SnapdealWebView extends StatefulWidget {
  WebViewController? webViewController;
  Function(WebViewController)? onWebViewCreated;
  String? url;
  JavascriptMode mode;
  SnapdealWebView(
      {Key? key,
      required this.webViewController,
      required this.onWebViewCreated,
      required this.mode,
      required this.url})
      : super(key: key);

  @override
  State<SnapdealWebView> createState() => _SnapdealWebViewState();
}

class _SnapdealWebViewState extends State<SnapdealWebView>
    with AutomaticKeepAliveClientMixin<SnapdealWebView> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebView(
      key: UniqueKey(),
      onWebViewCreated: widget.onWebViewCreated,
      initialUrl: 'https://www.snapdeal.com/',
      javascriptMode: JavascriptMode.unrestricted,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
