import 'package:http/http.dart' as http;
import 'dart:convert';

class GifsModel {
  static Future<Map> getGifs(String search, int offSet) async {
    http.Response response;
    if (search == null || search == '') {
      response = await http.get(
          'https://api.giphy.com/v1/gifs/trending?api_key=zmgasGUAxfjSEZ5557b0ih00FfU5j4Dm&limit=10&rating=G');
    } else {
      response = await http.get(
          'https://api.giphy.com/v1/gifs/search?api_key=zmgasGUAxfjSEZ5557b0ih00FfU5j4Dm&q=$search&limit=9&offset=$offSet&rating=G&lang=pt');
    }
    return json.decode(response.body);
  }

  static int getCount(String search, List data) {
    if (search == null || search == '') {
      return data.length;
    } else {
      return data.length + 1;
    }
  }
}
