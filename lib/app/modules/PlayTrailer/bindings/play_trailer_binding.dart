import 'package:get/get.dart';

import '../controllers/play_trailer_controller.dart';

class PlayTrailerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayTrailerController>(
      () => PlayTrailerController(),
    );
  }
}
