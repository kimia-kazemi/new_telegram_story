import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../constant/constant_mesurements.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String url;

  const CustomVideoPlayer({super.key, required this.url});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _isBuffering = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.url),
    );

    // Listen for buffering and errors
    _videoPlayerController.addListener(() {
      if (mounted) {
        setState(() {
          _isBuffering = _videoPlayerController.value.isBuffering;

          // Detect playback error
          if (_videoPlayerController.value.hasError) {
            _hasError = true;
            _isLoading = false;
          }
        });
      }
    });

    try {
      await _videoPlayerController.initialize();

      // If initialized but stuck at 0 duration, assume network issue
      if (_videoPlayerController.value.duration == null ||
          _videoPlayerController.value.duration!.inSeconds == 0) {
        throw Exception("Network error: Video duration is 0");
      }

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: true,
        showControls: false,
        allowFullScreen: false,
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Colors.grey[300]!, Colors.grey],
        ),
      ),
      child: Center(
        child: _isLoading
            ? CircularProgressIndicator() // Initial loading
            : _hasError
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.all(
                          TSDefaultMeasurement.defaultDesktopPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.wifi_off, size: 50, color: Colors.red),
                          SizedBox(height: 10),
                          Text("Failed to load videoCheck internet"),
                          TextButton(
                            onPressed: _initializeVideo,
                            child: Text("Retry"),
                          ),
                        ],
                      ),
                    ),
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Chewie(controller: _chewieController!),
                      if (_isBuffering)
                        Container(
                          color: Colors.black54,
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                    ],
                  ),
      ),
    );
  }
}
