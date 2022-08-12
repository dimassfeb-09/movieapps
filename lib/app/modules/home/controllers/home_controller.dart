import 'dart:convert';

import 'package:get/get.dart';
import 'package:moviesapps/app/modules/DetailNowPlaying/genres_model.dart';
import 'package:moviesapps/app/modules/home/movie_populars_model.dart';
import 'package:moviesapps/app/modules/home/movies_by_genre_id_model.dart';
import 'package:moviesapps/app/modules/home/now_playing_model.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  //TODO: Implement HomeController

  RxInt selectedIndex = 0.obs;
  RxInt genreId = 28.obs;

  Future<NowPlaying?> getNowPlaying() async {
    String BEARER =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MGU0NTExNDY4YzcwNWU5OWUxMDk5NjQ1NWMxN2ExNCIsInN1YiI6IjYyZjIyZTQ0NWJlMDBlMDA3ZDNkNTAxYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B16TpJz1cR8IGVuDJ3Lkbm76NYYL433pHRQsBwNP35s";
    String API_KEY = "70e4511468c705e99e10996455c17a14";
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/now_playing/?api_key=$API_KEY&page=1");
    var response = await http.get(
      url,
      headers: {
        "Authorization": BEARER,
        "Content-Type": "application/json;charset=utf-8",
      },
    );

    Map<String, dynamic> fetchData = jsonDecode(response.body);

    NowPlaying nowPlaying = NowPlaying.fromJson(fetchData);

    return nowPlaying;
  }

  Future<MoviePopulars?> getMoviePopular() async {
    String BEARER =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MGU0NTExNDY4YzcwNWU5OWUxMDk5NjQ1NWMxN2ExNCIsInN1YiI6IjYyZjIyZTQ0NWJlMDBlMDA3ZDNkNTAxYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B16TpJz1cR8IGVuDJ3Lkbm76NYYL433pHRQsBwNP35s";
    String API_KEY = "70e4511468c705e99e10996455c17a14";
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY");
    var response = await http.get(
      url,
      headers: {
        "Authorization": BEARER,
        "Content-Type": "application/json;charset=utf-8",
      },
    );

    Map<String, dynamic> fetchData = jsonDecode(response.body);

    MoviePopulars moviePopulars = MoviePopulars.fromJson(fetchData);

    return moviePopulars;
  }

  Future<List<Genres?>> getGenresList() async {
    String BEARER =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MGU0NTExNDY4YzcwNWU5OWUxMDk5NjQ1NWMxN2ExNCIsInN1YiI6IjYyZjIyZTQ0NWJlMDBlMDA3ZDNkNTAxYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B16TpJz1cR8IGVuDJ3Lkbm76NYYL433pHRQsBwNP35s";
    String API_KEY = "70e4511468c705e99e10996455c17a14";
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=$API_KEY");
    var response = await http.get(
      url,
      headers: {
        "Authorization": BEARER,
        "Content-Type": "application/json;charset=utf-8",
      },
    );

    List fetchData =
        (jsonDecode(response.body) as Map<String, dynamic>)['genres'];
    List<Genres?> allData = fetchData.map((e) => Genres.fromJson(e)).toList();

    return allData;
  }

  Future<List<MoviesByGenreId?>> getMoviesByGenreId({required int id}) async {
    String BEARER =
        "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3MGU0NTExNDY4YzcwNWU5OWUxMDk5NjQ1NWMxN2ExNCIsInN1YiI6IjYyZjIyZTQ0NWJlMDBlMDA3ZDNkNTAxYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.B16TpJz1cR8IGVuDJ3Lkbm76NYYL433pHRQsBwNP35s";
    String API_KEY = "70e4511468c705e99e10996455c17a14";
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$id&with_watch_monetization_types=flatrate&api_key=$API_KEY");
    var response = await http.get(
      url,
      headers: {
        "Authorization": BEARER,
        "Content-Type": "application/json;charset=utf-8",
      },
    );

    List fetchData =
        (jsonDecode(response.body) as Map<String, dynamic>)['results'];
    List<MoviesByGenreId?> allData =
        fetchData.map((e) => MoviesByGenreId.fromJson(e)).toList();

    return allData;
  }
}
