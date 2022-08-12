import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:moviesapps/app/modules/DetailNowPlaying/genres_model.dart';
import 'package:moviesapps/app/modules/home/movies_by_genre_id_model.dart';
import 'package:moviesapps/app/modules/home/now_playing_model.dart';
import 'package:moviesapps/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  List<String> listMenu = ["All", "Comedy", "Romance", "Fantasy", "War"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigatiorBarCustom(),
      body: ListView(
        children: [
          SizedBox(height: 20),
          Center(
            child: Text(
              "Now Playing",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 220,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: FutureBuilder<NowPlaying?>(
              future: controller.getNowPlaying(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading.."),
                  );
                } else {
                  NowPlaying? nowPlaying = snapshot.data;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(
                              Routes.DETAIL_NOW_PLAYING,
                              arguments: nowPlaying,
                              parameters: {
                                "index": index.toString(),
                              },
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Ink(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.grey[400],
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500${nowPlaying!.results![index].backdropPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text(
                                    "${nowPlaying.results![index].originalTitle}",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  left: 260,
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          FutureBuilder<List<Genres?>>(
            future: controller.getGenresList(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text("LOADING"),
                );
              } else {
                return Container(
                  height: 50,
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Genres? genres = snapshot.data![index];

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            controller.selectedIndex.value = index;
                            controller.genreId.value = genres!.id!.toInt();

                            controller.getMoviesByGenreId(
                                id: genres.id!.toInt());
                          },
                          child: Obx(
                            () => Ink(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                color: (index == controller.selectedIndex.value)
                                    ? Colors.red
                                    : Colors.grey[900],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  genres!.name.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
          Obx(
            () => FutureBuilder<List<MoviesByGenreId?>>(
              future:
                  controller.getMoviesByGenreId(id: controller.genreId.value),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("LOADING..."),
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      MoviesByGenreId? moviesByGenreId = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          print(moviesByGenreId?.id);
                          Get.toNamed(Routes.DETAIL_MOVIES,
                              arguments: moviesByGenreId);
                        },
                        child: Container(
                          height: 200,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500${moviesByGenreId?.backdropPath}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 15,
                                left: 10,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    moviesByGenreId!.originalTitle.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                left: MediaQuery.of(context).size.width * 0.63,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      SizedBox(width: 3),
                                      Text(
                                        "${moviesByGenreId.voteAverage} (${moviesByGenreId.voteCount})",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigatiorBarCustom extends StatelessWidget {
  const BottomNavigatiorBarCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.27,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "All Movies",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.27,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Popular Movie",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.27,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
