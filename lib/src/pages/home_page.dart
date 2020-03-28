import 'package:commons/commons.dart';
import 'package:covid/src/helper/quad_clipper.dart';
import 'package:covid/src/model/contry/contry.dart';
import 'package:covid/src/model/covid/infect.dart';
import 'package:covid/src/pages/estadistica_Page.dart';
import 'package:covid/src/pages/recomended_page.dart';
import 'package:covid/src/provider/contry.provider.dart';
import 'package:covid/src/provider/covid.provider.dart';
import 'package:covid/src/theme/color/light_color.dart';
import 'package:flutter/material.dart';

import 'Dart:math';

class HomePage extends StatelessWidget {
  final Future<List<Contry>> contra;
  HomePage({Key key, this.contra}) : super(key: key);

  double width;
  @override
  void initState() {
    contra.then((valor) {
      contrys.addAll(valor);
    });
    print(contrys.length);
  }

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 200,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.purple,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightpurple)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkpurple)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 40,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Busca un envento",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Escribe algo...",
                            style: TextStyle(
                                color: Colors.white54,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      )))
            ],
          )),
    );
  }

  static Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          _chip("Ver Todos", primary)
        ],
      ),
    );
  }

  final covidProvide = CovidProvider();

  _ticket(BuildContext context) {
    final _secreem = MediaQuery.of(context).size;
    return FutureBuilder(
      future: covidProvide.buscarInfect(),
      builder: (BuildContext context, AsyncSnapshot<List<Infect>> snapshot) {
        if (snapshot.hasData) {
          final tickets = snapshot.data;

          return Container(
            height: _secreem.height * 0.6,
            width: _secreem.height * 1,
            child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (contex, i) {
                  return GestureDetector(
                    child: _card(
                        primary: color[rng.nextInt(4) + 1],
                        backWidget: mapa[rng.nextInt(4) + 1],
                        chipColor: LightColor.orange,
                        chipText1: 'Contagios: ${tickets[i].cases.toString()}',
                        chipText2: tickets[i].country,
                        isPrimaryCard: true,
                        det: 'Muertos: ${tickets[i].deaths}',
                        recuperado: 'Recuperados: ${tickets[i].recovered}',
                        activos: 'Hoy: ${tickets[i].todayCases}',
                        imgPath: bandera(tickets[i].country)),
                    onTap: (){_masInfo(tickets[i].country, contex); },
                  
                  );
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _masInfo(String contry, BuildContext context){
     if(contry.endsWith('Ecuador')){
             Navigator.pushNamed(context, '/detalle', arguments:[ kNavigationEcuador,contry]);
     }
     else if(contry.endsWith('Brazil')){
             Navigator.pushNamed(context, '/detalle', arguments:[ kNavigationBrasil,contry]);
     } else if(contry.endsWith('Colombia')){
             Navigator.pushNamed(context, '/detalle', arguments:[ kNavigationColombia,contry]);
     }else if(contry.endsWith('Peru')){
             Navigator.pushNamed(context, '/detalle', arguments:[ kNavigationPeru,contry]);
     }else if(contry.endsWith('USA')){
             Navigator.pushNamed(context, '/detalle', arguments:[ kNavigationUSA,contry]);
     }else {
      return infoDialog(  
    context,  
    "Aun segimos trabajando por tu pais, si quieres unirte ala comunidad ",  
  
    positiveText: ":(",  
    positiveAction: () {},  
);  
     }


  }
  Widget _card(
      {Color primary = Colors.redAccent,
      String imgPath,
      String chipText1 = '',
      String chipText2 = '',
      Widget backWidget,
      String det = '',
      String activos = '',
      Color chipColor = LightColor.orange,
      String recuperado = '',
      bool isPrimaryCard = false}) {
    return Container(
        height: isPrimaryCard ? 220 : 180,
        width: isPrimaryCard ? width * .32 : width * .32,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
            color: primary.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: LightColor.lightpurple.withAlpha(20))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                    top: 20,
                    left: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: NetworkImage(imgPath),
                    )),
                Positioned(
                  bottom: 10,
                  left: 9,
                  child: _cardInfo(chipText1, det, recuperado, activos,
                      chipText2, LightColor.titleTextColor, chipColor,
                      isPrimaryCard: isPrimaryCard),
                )
              ],
            ),
          ),
        ));
  }

  Widget _cardInfo(String title, String det, String recuperado, String activos,
      String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: width * 0.5,
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isPrimaryCard ? Colors.white : textColor),
                  ),
                  leading: Icon(
                    Icons.accessible,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: width * 0.6,
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: Text(
                    det,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isPrimaryCard ? Colors.white : textColor),
                  ),
                  leading: Icon(
                    Icons.airline_seat_flat,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                width: width * 0.5,
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: Text(
                    recuperado,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isPrimaryCard ? Colors.white : textColor),
                  ),
                  leading: Icon(
                    Icons.accessibility_new,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: width * 0.6,
                alignment: Alignment.topCenter,
                child: ListTile(
                  title: Text(
                    activos,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isPrimaryCard ? Colors.white : textColor),
                  ),
                  leading: Icon(
                    Icons.access_alarms,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          _chip('${courses} ', primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 16),
      ),
    );
  }

  static Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  static Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  static Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  static Widget _decorationContainerD(Color primary, double top, double left,
      {Color secondary, Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  static Widget _decorationContainerE(Color primary, double top, double left,
      {Color secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  static Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    contra.then((v) {
      contrys.addAll(v);
    });

    width = MediaQuery.of(context).size.width;
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.purple,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.star_border),
            _bottomIcons(Icons.book),
            _bottomIcons(Icons.person),
          ],
          onTap: (index) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RecomendedPage()));
          },
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Column(
            children: <Widget>[
              _header(context),
              SizedBox(height: 10),
              _categoryRow(
                  "Listado de paises", LightColor.orange, LightColor.orange),
              _ticket(context),
            ],
          ),
        )));
  }

  Map<int, Widget> mapa = {
    1: _decorationContainerA(LightColor.lightOrange, 50, -30),
    2: _decorationContainerB(Colors.white, 90, -40),
    3: _decorationContainerC(Colors.white, 50, -30),
    4: _decorationContainerD(LightColor.seeBlue, -50, 30,
        secondary: LightColor.lightblack,
        secondaryAccent: LightColor.darkseeBlue),
    5: _decorationContainerE(LightColor.lightBlue, 50, -30),
  };

  Map<int, dynamic> color = {
    1: LightColor.lightOrange,
    2: LightColor.seeBlue,
    3: LightColor.lightpurple,
    4: LightColor.lightBlue,
    5: LightColor.lightGrey,
  };

  var rng = new Random();
  List<Contry> contrys = new List();

  static ContryProvider contryProvider = new ContryProvider();

  String poblacion(String getname) {
    if (contrys != null) {
      for (Contry recupera in contrys) {
        if (recupera.name.endsWith(getname)) {
          return recupera.population.toString();
        }
      }
      return null;
    } else {
      return 'Pais Err';
    }
  }

  String bandera(String getname) {
    if (contrys != null) {
      if (getname.endsWith('USA')){
        return 'https://www.countryflags.io/US/shiny/64.png';
      }
      for (Contry recupera in contrys) {
        if (recupera.name.endsWith(getname)) {
          print(
              'https://www.countryflags.io/${recupera.alpha2Code}/shiny/64.png');
          return 'https://www.countryflags.io/${recupera.alpha2Code}/shiny/64.png';
        }
      }
      return 'https://img.icons8.com/dotty/70/000000/nothing-found.png';
    } else {
      return 'https://img.icons8.com/dotty/70/000000/nothing-found.png';
    }
  }
}
const String kNavigationEcuador = '''
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desde la web</title>
</head>
<body>
<div class='tableauPlaceholder' id='viz1585426281241' style='position: relative'><noscript><a href='https:&#47;&#47;public.tableau.com&#47;profile&#47;paulmenam#!&#47;vizhome&#47;CoronavirusenEcuador&#47;Hoja2?publish=yes'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Co&#47;CoronavirusenEcuador&#47;Dashboard3&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='CoronavirusenEcuador&#47;Dashboard3' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Co&#47;CoronavirusenEcuador&#47;Dashboard3&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1585426281241');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='100%';vizElement.style.height='1077px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='100%';vizElement.style.height='1027px';} else { vizElement.style.width='100%';vizElement.style.height='777px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
</body>
</html>
''';
const String kNavigationBrasil = '''
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desde la web</title>
</head>
<body>
<div class='tableauPlaceholder' id='viz1585432129979' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Re&#47;ReligEstados&#47;ReligionoBrasil&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='ReligEstados&#47;ReligionoBrasil' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Re&#47;ReligEstados&#47;ReligionoBrasil&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1585432129979');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='1024px';vizElement.style.height='795px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='1024px';vizElement.style.height='795px';} else { vizElement.style.width='100%';vizElement.style.height='1427px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
 </body>
</html>
''';
const String kNavigationColombia = '''
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desde la web</title>
</head>
<body>
<div class='tableauPlaceholder' id='viz1585432482653' style='position: relative'><noscript><a href='https:&#47;&#47;www.eltiempo.com&#47;datos&#47;casos-actualizados-de-coronavirus-en-colombia-471650'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ev&#47;EvolucindaadaCOVID-19Colombia&#47;Mapaycasos&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='path' value='views&#47;EvolucindaadaCOVID-19Colombia&#47;Mapaycasos?:embed=y&amp;:toolbar=yes&amp;:embed_code_version=3&amp;:loadOrderID=0&amp;:display_count=yes&amp;:tabs=no' /> <param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Ev&#47;EvolucindaadaCOVID-19Colombia&#47;Mapaycasos&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='tabs' value='no' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1585432482653');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='100%';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='100%';vizElement.style.height=(divElement.offsetWidth*0.75)+'px';} else { vizElement.style.width='100%';vizElement.style.height=(divElement.offsetWidth*1.77)+'px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
 </body>
</html>
''';

const String kNavigationPeru= '''
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desde la web</title>
</head>
<body>
<div class='tableauPlaceholder' id='viz1585433120636' style='position: relative'><noscript><a href='#'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Co&#47;Covid19_15850860034290&#47;Covid19&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='Covid19_15850860034290&#47;Covid19' /><param name='tabs' value='no' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;Co&#47;Covid19_15850860034290&#47;Covid19&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1585433120636');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='1200px';vizElement.style.height='1627px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='1200px';vizElement.style.height='1627px';} else { vizElement.style.width='100%';vizElement.style.height='1177px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script> </body>

</html>
''';
const String kNavigationUSA= '''
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Desde la web</title>
</head>
<body>
<div class='tableauPlaceholder' id='viz1585434948968' style='position: relative'><noscript><a href='https:&#47;&#47;twitter.com&#47;COVID19Tracking'><img alt=' ' src='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;CO&#47;COVID19inUSA&#47;COVID-19spreadinUSA&#47;1_rss.png' style='border: none' /></a></noscript><object class='tableauViz'  style='display:none;'><param name='host_url' value='https%3A%2F%2Fpublic.tableau.com%2F' /> <param name='embed_code_version' value='3' /> <param name='site_root' value='' /><param name='name' value='COVID19inUSA&#47;COVID-19spreadinUSA' /><param name='tabs' value='yes' /><param name='toolbar' value='yes' /><param name='static_image' value='https:&#47;&#47;public.tableau.com&#47;static&#47;images&#47;CO&#47;COVID19inUSA&#47;COVID-19spreadinUSA&#47;1.png' /> <param name='animate_transition' value='yes' /><param name='display_static_image' value='yes' /><param name='display_spinner' value='yes' /><param name='display_overlay' value='yes' /><param name='display_count' value='yes' /><param name='origin' value='viz_share_link' /></object></div>                <script type='text/javascript'>                    var divElement = document.getElementById('viz1585434948968');                    var vizElement = divElement.getElementsByTagName('object')[0];                    if ( divElement.offsetWidth > 800 ) { vizElement.style.width='1000px';vizElement.style.height='850px';} else if ( divElement.offsetWidth > 500 ) { vizElement.style.width='1000px';vizElement.style.height='850px';} else { vizElement.style.width='100%';vizElement.style.height='1560px';}                     var scriptElement = document.createElement('script');                    scriptElement.src = 'https://public.tableau.com/javascripts/api/viz_v1.js';                    vizElement.parentNode.insertBefore(scriptElement, vizElement);                </script>
</body>
</html>
''';

