import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:moviesapps/app/modules/DetailNowPlaying/playing_trailer_model.dart';
import 'package:moviesapps/app/modules/home/now_playing_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../controllers/detail_now_playing_controller.dart';

class DetailNowPlayingView extends GetView<DetailNowPlayingController> {
  NowPlaying arguments = Get.arguments;
  Map<String, dynamic> parameters = Get.parameters;

  @override
  Widget build(BuildContext context) {
    int index = int.parse("${parameters["index"]}");

    List listMenu = [
      OverviewWidget(index),
      Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder<List<PlayingTrailer?>>(
          future: controller.playingTrailers(
              movieId: arguments.results![index].id.toString()),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("data"),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  YoutubePlayerController _controller = YoutubePlayerController(
                    initialVideoId: snapshot.data![index]!.key.toString(),
                    flags: YoutubePlayerFlags(
                      isLive: false,
                      autoPlay: false,
                    ),
                  );

                  return Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        snapshot.data![index]!.name.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 200,
                        child: YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.amber,
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          arguments.results![index].title.toString(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[900],
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectedOverview.value = 0;
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.selectedOverview.value == 0
                              ? Colors.red
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Overview",
                            style: TextStyle(
                              color: controller.selectedOverview.value == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectedOverview.value = 1;
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: controller.selectedOverview.value == 1
                              ? Colors.red
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Trailer",
                            style: TextStyle(
                              color: controller.selectedOverview.value == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Obx(
              () => Container(
                child: listMenu.elementAt(controller.selectedOverview.value),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OverviewWidget(int index) {
    return Column(
      children: [
        Column(
          children: [
            Center(
              child: Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500${arguments.results![index].posterPath}")),
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Center(
                  child: Text(
                    arguments.results![index].originalTitle.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    arguments.results![index].overview.toString(),
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rating",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "${arguments.results![index].voteAverage} (${arguments.results![index].voteCount})",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 5),
                              RatingBar.builder(
                                ignoreGestures: true,
                                initialRating: double.parse(
                                        "${arguments.results![index].voteAverage}") /
                                    2,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 25,
                                unratedColor: Colors.grey,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Original Language",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            arguments.results![index].originalLanguage
                                .toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Release Date",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            arguments.results![index].releaseDate.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
