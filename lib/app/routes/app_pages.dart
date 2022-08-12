import 'package:get/get.dart';

import '../modules/DetailMovies/bindings/detail_movies_binding.dart';
import '../modules/DetailMovies/views/detail_movies_view.dart';
import '../modules/DetailNowPlaying/bindings/detail_now_playing_binding.dart';
import '../modules/DetailNowPlaying/views/detail_now_playing_view.dart';
import '../modules/PlayTrailer/bindings/play_trailer_binding.dart';
import '../modules/PlayTrailer/views/play_trailer_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_NOW_PLAYING,
      page: () => DetailNowPlayingView(),
      binding: DetailNowPlayingBinding(),
    ),
    GetPage(
      name: _Paths.PLAY_TRAILER,
      page: () => PlayTrailerView(),
      binding: PlayTrailerBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MOVIES,
      page: () => const DetailMoviesView(),
      binding: DetailMoviesBinding(),
    ),
  ];
}
