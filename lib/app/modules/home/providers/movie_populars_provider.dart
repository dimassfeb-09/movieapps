import 'package:get/get.dart';

import '../movie_populars_model.dart';

class MoviePopularsProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map is Map<String, dynamic>) return MoviePopulars.fromJson(map);
      if (map is List)
        return map.map((item) => MoviePopulars.fromJson(item)).toList();
    };
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<MoviePopulars?> getMoviePopulars(int id) async {
    final response = await get('moviepopulars/$id');
    return response.body;
  }

  Future<Response<MoviePopulars>> postMoviePopulars(
          MoviePopulars moviepopulars) async =>
      await post('moviepopulars', moviepopulars);
  Future<Response> deleteMoviePopulars(int id) async =>
      await delete('moviepopulars/$id');
}
