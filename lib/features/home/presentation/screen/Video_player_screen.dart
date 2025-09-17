import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:steam/core/constants/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerScreen({super.key, required this.videoUrl});
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  ChewieController? _chewieController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _videoController.initialize().then((_) {
      _chewieController = ChewieController(
        videoPlayerController: _videoController,
        autoPlay: true,
        looping: false,
      );
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myBlack,
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: Text('پخش ویدئو', style: TextStyle(color: AppColors.white)),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            HugeIcons.strokeRoundedArrowRight01,
            color: AppColors.white,
          ),
        ),
      ),
      body: Center(
        child: isLoading
            ? LoadingAnimationWidget.hexagonDots(
                color: AppColors.orange,
                size: 50,
              )
            : Chewie(controller: _chewieController!),
      ),
    );
  }
}

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;
//   const VideoPlayerScreen({super.key, required this.videoUrl});

//   @override
//   State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _videoController;
//   ChewieController? _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     _videoController = VideoPlayerController.networkUrl(
//       Uri.parse(widget.videoUrl),
//     );
//     _chewieController = ChewieController(
//       videoPlayerController: _videoController,
//       autoPlay: true,
//       looping: false,
//     );
//   }

//   @override
//   void dispose() {
//     _chewieController?.dispose();
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: AppColors.orange,
//         title: Text('پخش ویدئو', style: TextStyle(color: AppColors.white)),
//         leading: IconButton(
//           onPressed: () => context.pop(),
//           icon: Icon(
//             HugeIcons.strokeRoundedArrowRight01,
//             color: AppColors.white,
//           ),
//         ),
//       ),
//       body: Center(
//         child: _chewieController != null
//             ? Chewie(controller: _chewieController!)
//             : const CircularProgressIndicator(),
//       ),
//     );
//   }
// }
