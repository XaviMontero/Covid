
import 'dart:convert';

import 'package:covid/src/model/contry/contry.dart';
import 'package:http/http.dart' as http;
class ContryProvider {
  String _url = 'restcountries.eu';
  
  Future<List<Contry>> buscarContry() async {
  
    final url = Uri.https(_url, 'rest/v2/all');
     print(url.toString());
    return await _procesarTicket(url);
  }

  Future<List<Contry>> _procesarTicket(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final result = Contrys.fromJsonList(decodeData);
    //print(result.items);
    return result.items;
  }
}