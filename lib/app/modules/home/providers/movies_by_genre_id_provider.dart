import 'package:get/get.dart';

import '../movies_by_genre_id_model.dart';

class MoviesByGenreIdProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return MoviesByGenreId.fromJson(map);
      if (map is List)
        return map.map((item) => MoviesByGenreId.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<MoviesByGenreId?> getMoviesByGenreId(int id) async {
    final response = await get('moviesbygenreid/$id');
    return response.body;
  }

  Future<Response<MoviesByGenreId>> postMoviesByGenreId(
          MoviesByGenreId moviesbygenreid) async =>
      await post('moviesbygenreid', moviesbygenreid);
  Future<Response> deleteMoviesByGenreId(int id) async =>
      await delete('moviesbygenreid/$id');
}
