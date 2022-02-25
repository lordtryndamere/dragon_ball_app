//import 'package:better_player/better_player.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../models/models.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key, this.movie}) : super(key: key);
  final Movie? movie;
  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  // late BetterPlayerController _betterPlayerController;
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
    //     BetterPlayerDataSourceType.network,
    //     widget.movie!.videoUri); //Configuracion del video

    // _betterPlayerController = BetterPlayerController(
    //     const BetterPlayerConfiguration(
    //         fit: BoxFit.fill,
    //         autoPlay: true,
    //         fullScreenByDefault: false,
    //         controlsConfiguration: BetterPlayerControlsConfiguration()),
    //     betterPlayerDataSource: betterPlayerDataSource);
    _controller = VideoPlayerController.network(widget.movie!.videoUri);
    _initializeVideoPlayerFuture = _controller.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _controller,
        //autoPlay: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: const TextStyle(color: Colors.white),
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return AspectRatio(
    //   aspectRatio: 16 / 9,
    //   child: BetterPlayer(controller: _betterPlayerController),
    // );
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Chewie(controller: _chewieController),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
        },
        future: _initializeVideoPlayerFuture,
      ),
    );
  }
}
