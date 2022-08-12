import 'package:get/get.dart';

import '../now_playing_model.dart';

class NowPlayingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return NowPlaying.fromJson(map);
      if (map is List)
        return map.map((item) => NowPlaying.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<NowPlaying?> getNowPlaying(int id) async {
    final response = await get('nowplaying/$id');
    return response.body;
  }

  Future<Response<NowPlaying>> postNowPlaying(NowPlaying nowplaying) async =>
      await post('nowplaying', nowplaying);
  Future<Response> deleteNowPlaying(int id) async =>
      await delete('nowplaying/$id');
}
