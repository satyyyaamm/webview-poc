import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_poc/color_controller.dart';
import 'package:webview_poc/webviews/amazon_webview.dart';
import 'package:webview_poc/webviews/flipkart_webview.dart';
import 'package:webview_poc/webviews/snapdeal_webview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'POC WEBVIEW',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

Color snapdeal = Color(0xffE30047);
Color flipkart = Color(0xff047BD5);
Color amazon = Color(0xff041624);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<MyHomePage> {
  // late TabController tabController;
  WebViewController? flipkartController;
  WebViewController? amazonController;
  WebViewController? snapdealController;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // tabController = TabController(length: 3, vsync: this);
    // tabController.addListener(() {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  ColorController colorController = Get.put(ColorController());
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            backgroundColor: colorController.colorcounter.value == 0
                ? amazon
                : colorController.colorcounter.value == 1
                    ? flipkart
                    : colorController.colorcounter.value == 2
                        ? snapdeal
                        : flipkart,
            title: FadeInDown(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 400),
                child: searchbar()),
            bottom: customtabbar(),
            actions: [
              FadeInRight(
                duration: Duration(milliseconds: 500),
                delay: Duration(milliseconds: 400),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => buildPopupDialog(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.add,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              amazonController!.loadUrl('https://www.amazon.in/');
              flipkartController!.loadUrl('https://www.flipkart.com/');
              snapdealController!.loadUrl('https://www.flipkart.com/');
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.update),
          ),
          body: TabBarView(
            // controller: tabController,
            physics: BouncingScrollPhysics(),
            children: [
              AmazonWebView(
                  url: 'https://www.amazon.in/',
                  mode: JavascriptMode.unrestricted,
                  webViewController: amazonController,
                  onWebViewCreated: (controller) => amazonController = controller),
              FlipkartWebView(
                  mode: JavascriptMode.unrestricted,
                  url: 'https://www.flipkart.com/',
                  webViewController: flipkartController,
                  onWebViewCreated: (controller) => flipkartController = controller),
              SnapdealWebView(
                  mode: JavascriptMode.unrestricted,
                  url: 'https://www.snapdeal.com/',
                  webViewController: snapdealController,
                  onWebViewCreated: (controller) => snapdealController = controller),
              // WebView(
              //   key: UniqueKey(),
              //   onWebViewCreated: (controller) => amazonController = controller,
              //   initialUrl: 'https://www.amazon.in/',
              //   javascriptMode: JavascriptMode.unrestricted,
              // ),
              // WebView(
              //   key: UniqueKey(),
              //   onWebViewCreated: (controller) => flipkartController = controller,
              //   initialUrl: 'https://www.flipkart.com/',
              //   javascriptMode: JavascriptMode.unrestricted,
              // ),
              // WebView(
              //   key: UniqueKey(),
              //   onWebViewCreated: (controller) => snapdealController = controller,
              //   initialUrl: 'https://www.snapdeal.com/',
              //   javascriptMode: JavascriptMode.unrestricted,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChip(String label, Color color, String image) {
    return Chip(
      labelPadding: EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.white70,
        child: image != ''
            ? ClipRRect(borderRadius: BorderRadius.circular(50), child: Image.asset(image))
            : Icon(Icons.ac_unit),
      ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: color,
      elevation: 6.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(8.0),
    );
  }

  Widget buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: Text(
        'Add more smart apps',
        style: TextStyle(
          fontSize: 16,
        ),
      )),
      content: Container(
        height: 100,
        child: Wrap(
          // mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(width: 20),
            buildChip('Amazon', amazon, 'assets/amazon.jpeg'),
            SizedBox(width: 20),
            buildChip('Flipkart', flipkart, 'assets/flipkart.png'),
            SizedBox(width: 20),
            buildChip('Snapdeal', snapdeal, 'assets/Snapdeal.png'),
            SizedBox(width: 20),
            buildChip('Jabong', amazon, ''),
            // SizedBox(width: 20),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  TabBar customtabbar() {
    return TabBar(
      // controller: tabController,
      onTap: (count) {
        colorController.colorcounter.value = count;
      },

      tabs: [
        FadeInLeft(
          duration: Duration(milliseconds: 500),
          delay: Duration(milliseconds: 200),
          child: Tab(
            child: Row(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: Image.asset(
                      'assets/amazon.jpeg',
                      fit: BoxFit.fitHeight,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text('Amazon')
              ],
            ),
          ),
        ),
        FadeInLeft(
          duration: Duration(milliseconds: 500),
          delay: Duration(milliseconds: 400),
          child: Tab(
            child: Row(
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: Image.asset(
                      'assets/flipkart.png',
                      fit: BoxFit.fitHeight,
                      height: 30,
                      width: 30,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text('Flipkart')
              ],
            ),
          ),
        ),
        FadeInLeft(
          duration: Duration(milliseconds: 500),
          delay: Duration(milliseconds: 500),
          child: Tab(
            child: Row(
              children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Image.asset(
                        'assets/Snapdeal.png',
                        height: 30,
                        width: 30,
                      )),
                ),
                SizedBox(width: 10),
                Text('Snapdeal')
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextFormField searchbar() {
    return TextFormField(
        controller: searchController,
        decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: () async {
                  amazonController!.runJavascript(
                      "document.getElementById('nav-search-keywords').value='${searchController.text}'");
                  flipkartController!.runJavascript(
                      "document.getElementById('input-searchsearchpage-input').value='${searchController.text}'");
                  // await snapdealController!
                  //     .runJavascript("document.getElementById().value='${searchController.text}'");
                  Future.delayed(Duration(seconds: 1000));
                  amazonController!.runJavascript('document.forms[0].submit()');
                  flipkartController!.runJavascript('document.forms[0].submit()');
                  // await snapdealController!.runJavascript('document.forms[0].submit()');
                  print('searchIconTapped');
                  print('${searchController.text}');
                },
                child: Icon(
                  Icons.search,
                  color: Colors.black,
                )),
            contentPadding: EdgeInsets.only(top: 10, left: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(color: Colors.black),
            hintText: 'Search What Ever Your Want!!',
            fillColor: Colors.white70),
        // controller: _email,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Search cannot be blank';
          }
          return null;
        });
  }
}
