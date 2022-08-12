import 'dart:convert';

import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;

import '../../DetailNowPlaying/playing_trailer_model.dart';

class DetailMoviesController extends GetxController {
  //TODO: Implement DetailMoviesController

  RxInt selectedOverview = 0.obs;

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
