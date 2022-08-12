import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:moviesapps/app/modules/DetailNowPlaying/genres_model.dart';
import 'package:moviesapps/app/modules/DetailNowPlaying/playing_trailer_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailNowPlayingController extends GetxController {
  //TODO: Implement DetailNowPlayingController

  final count = 0.obs;
  RxInt selectedOverview = 0.obs;

  Future<List<Genres>> getGenres() async {
    List<Genres> allGenres = [];
    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=70e4511468c705e99e10996455c17a14&language=en-US");
    final response = await http.get(url);

    List fetchData =
        (jsonDecode(response.body) as Map<String, dynamic>)['genres'];

    fetchData.forEach((element) {
      allGenres.add(Genres.fromJson(element));
    });

    return allGenres;
  }

  Future<List<PlayingTrailer?>> playingTrailers(
      {required String movieId}) async {
    List<PlayingTrailer?> allPlayingTrailer = [];

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '6q-YCaHmS4A',
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );

    Uri url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/videos?api_key=70e4511468c705e99e10996455c17a14&language=en-US");
    final response = await http.get(url);
    List fetchData =
        (jsonDecode(response.body) as Map<String, dynamic>)['results'];

    fetchData.forEach((element) {
      allPlayingTrailer.add(PlayingTrailer.fromJson(element));
    });

    return allPlayingTrailer;
  }
}
