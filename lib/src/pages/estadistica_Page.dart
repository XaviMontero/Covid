import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
  final List<dynamic> response = ModalRoute.of(context).settings.arguments;
   String pagina = response[0];
   String  contry = response[1];
    return Scaffold(
      appBar: AppBar(
        title:   Text('Estadistica ${contry}'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        actions: <Widget>[
         
        
        ],
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return WebView(
          
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            final String contentBase64 = base64Encode(
                const Utf8Encoder().convert(pagina));
            webViewController.loadUrl('data:text/html;base64,$contentBase64');
            webViewController.evaluateJavascript(
                'caches.open("test_caches_entry"); localStorage["test_localStorage"] = "dummy_entry";');
            Scaffold.of(context).showSnackBar(const SnackBar(
              content: Text('Added a test entry to cache.'),
            ));
          },
     
        );
      }),
      floatingActionButton: favoriteButton(),
    );
  }

 

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                final String url = await controller.data.currentUrl();
                Scaffold.of(context).showSnackBar(
                  SnackBar(content: Text('Favorited $url')),
                );
              },
              child: const Icon(Icons.favorite),
            );
          }
          return Container();
        });
  }
}
 
 

 