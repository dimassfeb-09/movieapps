import 'package:get/get.dart';

import '../genres_model.dart';

class GenresProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return Genres.fromJson(map);
      if (map is List) return map.map((item) => Genres.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<Genres?> getGenres(int id) async {
    final response = await get('genres/$id');
    return response.body;
  }

  Future<Response<Genres>> postGenres(Genres genres) async =>
      await post('genres', genres);
  Future<Response> deleteGenres(int id) async => await delete('genres/$id');
}
