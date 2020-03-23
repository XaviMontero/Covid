import 'package:covid/src/helper/quad_clipper.dart';
import 'package:covid/src/model/contry/contry.dart';
import 'package:covid/src/model/covid/infect.dart';
import 'package:covid/src/pages/recomended_page.dart';
import 'package:covid/src/provider/contry.provider.dart';
import 'package:covid/src/provider/covid.provider.dart';
import 'package:covid/src/theme/color/light_color.dart';
import 'package:flutter/material.dart';
 
import 'Dart:math';

class HomePage extends StatelessWidget {
 final  Future<List<Contry>> contra; 
  HomePage({Key key,this.contra}) : super(key: key);

  double width;
  @override
  void initState() {
        contra.then((valor){
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
          _chip("See all", primary)
        ],
      ),
    );
  }

  Widget _featuredRowA() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _card(
                primary: LightColor.orange,
                backWidget:
                    _decorationContainerA(LightColor.lightOrange, 50, -30),
                chipColor: LightColor.orange,
                chipText1: "Find the right degree for you",
                chipText2: "8 Cources",
                isPrimaryCard: true,
                imgPath:
                    "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg"),
            _card(
                primary: Colors.white,
                chipColor: LightColor.seeBlue,
                backWidget: _decorationContainerB(Colors.white, 90, -40),
                chipText1: "Become a data scientist",
                chipText2: "8 Cources",
                imgPath:
                    "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*"),
            _card(
                primary: Colors.white,
                chipColor: LightColor.lightOrange,
                backWidget: _decorationContainerC(Colors.white, 50, -30),
                chipText1: "Become a digital marketer",
                chipText2: "8 Cources",
                imgPath:
                    "https://www.visafranchise.com/wp-content/uploads/2019/05/patrick-findaro-visa-franchise-square.jpg"),
            _card(
                primary: Colors.white,
                chipColor: LightColor.seeBlue,
                backWidget: _decorationContainerD(LightColor.seeBlue, -50, 30,
                    secondary: LightColor.lightseeBlue,
                    secondaryAccent: LightColor.darkseeBlue),
                chipText1: "Become a machine learner",
                chipText2: "8 Cources",
                imgPath:
                    "https://d1mo3tzxttab3n.cloudfront.net/static/img/shop/560x580/vint0080.jpg"),
          ],
        ),
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
                  return _card(
                      primary: color[rng.nextInt(4) + 1],
                      backWidget: mapa[rng.nextInt(4) + 1],
                      chipColor: LightColor.orange,
                      chipText1: 'Contagios: ${tickets[i].cases.toString()}',
                      chipText2: tickets[i].country,
                      isPrimaryCard: true,
                      det: 'Muertos: ${tickets[i].deaths}',
                      recuperado: 'Recuperados: ${tickets[i].recovered}',
                      activos: 'Hoy: ${tickets[i].todayCases}',
                      imgPath: bandera(tickets[i].country));
                }),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
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
          _chip( '${courses} ', primary, height: 5, isPrimaryCard: isPrimaryCard)
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

  static Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
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
         contra.then((v){
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
              _categoryRow("Featured", LightColor.orange, LightColor.orange),
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
    List<Contry> contrys = new List() ;

  static ContryProvider contryProvider = new ContryProvider();
   
 
  

   String poblacion(String getname){
    if (contrys!= null){
       
        for(Contry recupera in contrys){
            if (recupera.name.endsWith(getname)){
                  return recupera.population.toString(); 
            }
        }
      return null; 
      }else{
        return 'Pais Err';
      }
 }
  String bandera(String getname){
    if (contrys!= null){
       
        for(Contry recupera in contrys){
            if (recupera.name.endsWith(getname)){
              print('https://www.countryflags.io/${recupera.alpha2Code}/shiny/64.png');
                  return 'https://www.countryflags.io/${recupera.alpha2Code}/shiny/64.png'; 
            }
        }
      return 'https://img.icons8.com/dotty/70/000000/nothing-found.png'; 
      }else{
        return 'https://img.icons8.com/dotty/70/000000/nothing-found.png';
      }
 }

}
