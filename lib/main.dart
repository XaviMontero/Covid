import 'package:covid/src/pages/estadistica_Page.dart';
import 'package:covid/src/provider/contry.provider.dart';
import 'package:flutter/material.dart';
 
import 'src/pages/home_page.dart';
import 'src/theme/theme.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
   ContryProvider contry = new ContryProvider(); 
    return MaterialApp(
      theme: AppTheme.lightTheme,
      
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(contra: contry.buscarContry()),
        '/detalle': (context) => WebViewExample(),
       
      },
    );
  }
}



 