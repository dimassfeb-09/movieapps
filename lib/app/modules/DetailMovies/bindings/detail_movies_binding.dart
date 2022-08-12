import 'package:get/get.dart';

import '../controllers/detail_movies_controller.dart';

class DetailMoviesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMoviesController>(
      () => DetailMoviesController(),
    );
  }
}
