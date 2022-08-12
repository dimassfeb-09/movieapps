import 'package:get/get.dart';

import '../playing_trailer_model.dart';

class PlayingTrailerProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return PlayingTrailer.fromJson(map);
      if (map is List)
        return map.map((item) => PlayingTrailer.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<PlayingTrailer?> getPlayingTrailer(int id) async {
    final response = await get('playingtrailer/$id');
    return response.body;
  }

  Future<Response<PlayingTrailer>> postPlayingTrailer(
          PlayingTrailer playingtrailer) async =>
      await post('playingtrailer', playingtrailer);
  Future<Response> deletePlayingTrailer(int id) async =>
      await delete('playingtrailer/$id');
}
