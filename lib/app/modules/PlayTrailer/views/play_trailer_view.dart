import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moviesapps/app/modules/home/now_playing_model.dart';

import '../controllers/play_trailer_controller.dart';

class PlayTrailerView extends GetView<PlayTrailerController> {
  NowPlaying arguments = Get.arguments;
  Map<String, dynamic> parameters = Get.parameters;

  @override
  Widget build(BuildContext context) {
    int index = int.parse("${parameters['index']}");

    return Scaffold(
      appBar: AppBar(
        title: Text("Trailer ${arguments.results![index].title}"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'PlayTrailerView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
