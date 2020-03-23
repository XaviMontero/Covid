
import 'dart:convert';

import 'package:covid/src/model/covid/infect.dart';
 
import 'package:http/http.dart' as http;
class CovidProvider {
  String _url = 'coronavirus-19-api.herokuapp.com';
  
  Future<List<Infect>> buscarInfect() async {
  
    final url = Uri.https(_url, 'countries');
     print(url.toString());
    return await _procesarTicket(url);
  }

  Future<List<Infect>> _procesarTicket(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final result = Infects.fromJsonList(decodeData);
    //print(result.items);
    return result.items;
  }
}