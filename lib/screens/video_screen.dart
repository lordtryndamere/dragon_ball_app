import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class _VideoPlayer extends StatefulWidget {
  const _VideoPlayer({Key? key, required this.movie}) : super(key: key);
  final Movie movie;
  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.movie.videoUri); //Configuracion del video

    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            autoPlay: false,
            fullScreenByDefault: false,
            controlsConfiguration: BetterPlayerControlsConfiguration()),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(controller: _betterPlayerController),
    );
  }
}
