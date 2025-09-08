import 'package:agent_app_vpn/project_imports.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;
  final bool isPodding;
  const WebViewPage(this.url, this.title, {super.key, required this.isPodding});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // final WebViewController _controller = WebViewController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget.title,
        const [],
        isBack: true,
      ),
      body: Padding(
        padding: widget.isPodding
            ? EdgeInsets.only(top: 25.h, left: 25.w, right: 25.w)
            : EdgeInsets.zero,
        child: WebView(
          backgroundColor: Colors.transparent,
          initialUrl: widget.url,
          // javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
/*
*  WebView(
          backgroundColor: Colors.transparent,
          initialUrl: widget.url, // 线上页面路径
          javascriptMode: JavascriptMode.unrestricted,
        )
* */
