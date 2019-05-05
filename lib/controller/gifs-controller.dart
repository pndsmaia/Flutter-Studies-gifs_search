import 'package:gifs_app/model/gifs-model.dart';

class GifsController {
  static Future<Map> getGifs(String search, int offSet) async {
    return await GifsModel.getGifs(search, offSet);
  }

  static int getCount(String search, List data) {
    return GifsModel.getCount(search, data);
  }
}
