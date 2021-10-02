import 'package:flutter/material.dart';
import 'package:spotify_player_clone/base/constats.dart';
import 'package:video_player/video_player.dart';

class SpotifyPlayer extends StatefulWidget {
  const SpotifyPlayer({Key? key}) : super(key: key);

  @override
  _SpotifyPlayerState createState() => _SpotifyPlayerState();
}

class _SpotifyPlayerState extends State<SpotifyPlayer> {
  bool showPlayer = true;
  double currentSliderValue = 0.0;
  double lengthOfSong = 133;

  String getCurrentTime(double value) {
    int minutes = 0;
    int seconds = 0;

    double currentValue = (value * 133) / 100;

    minutes = currentValue ~/ 60;
    seconds = (currentValue % 60).toInt();

    return "$minutes:$seconds";
  }

  String getRemainingTime(double value) {
    double currentValue = (value * 133) / 100;

    double currentRemainningTime = lengthOfSong - currentValue;

    int minutes = 0;
    int seconds = 0;
    minutes = currentRemainningTime ~/ 60;
    seconds = (currentRemainningTime % 60).toInt();

    return "$minutes:$seconds";
  }

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/videos/edamame2.mp4");

    _initializeVideoPlayerFuture = _controller.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Background Video
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showPlayer = showPlayer ? false : true;
                  });
                  print("Tapped Background");
                },
                child: Container(
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(showPlayer ? 0.5 : 0),
                  ),
                  //height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        // If the VideoPlayerController has finished initialization, use
                        // the data it provides to limit the aspect ratio of the video.
                        _controller.play();
                        return AspectRatio(
                          aspectRatio: MediaQuery.of(context).size.width /
                              MediaQuery.of(context).size.height,
                          // Use the VideoPlayer widget to display the video.
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        // If the VideoPlayerController is still initializing, show a
                        // loading spinner.
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),

          // UI
          showPlayer
              ? SafeArea(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Header (Playlist name)
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Today's Top Hi...",
                                style: kBodyText.copyWith(color: Colors.white),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),

                        // Media Controls and Song Name
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              // Name and favorite
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "edamame (feat. Rich Brian)",
                                        style: kHeadline6.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "bbno\$, Rich Brian",
                                        style: kBodyText.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.favorite_outline,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              // Slider
                              Container(
                                child: Column(
                                  children: [
                                    Slider.adaptive(
                                      value: currentSliderValue,
                                      min: 0,
                                      max: 100,
                                      activeColor: Colors.white,
                                      label:
                                          currentSliderValue.round().toString(),
                                      onChanged: (double value) {
                                        setState(() {
                                          currentSliderValue = value;
                                        });
                                      },
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            getCurrentTime(currentSliderValue),
                                            style: kOverline,
                                          ),
                                          Text(
                                            "-${getRemainingTime(currentSliderValue)}",
                                            style: kOverline,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Controls
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.shuffle_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.skip_previous,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    iconSize: 45,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.pause_circle_filled,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.skip_next,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.repeat,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    iconSize: 15,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.devices,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        IconButton(
                                          iconSize: 15,
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.share,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          iconSize: 15,
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.playlist_add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SafeArea(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage("assets/bby.jpg"),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "By BBNo\$",
                            style: kHeadline6.copyWith(
                                color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
        ],
      ),
    );
  }
}
