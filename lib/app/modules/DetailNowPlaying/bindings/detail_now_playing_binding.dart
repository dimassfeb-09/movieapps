import 'package:get/get.dart';

import '../controllers/detail_now_playing_controller.dart';

class DetailNowPlayingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailNowPlayingController>(
      () => DetailNowPlayingController(),
    );
  }
}
