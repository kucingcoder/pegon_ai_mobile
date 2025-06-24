import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pegon_ai_mobile/app/data/variabels.dart';
import 'package:pegon_ai_mobile/app/modules/watch_tutorial/controllers/watch_tutorial_controller.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class WatchTutorialView extends GetView<WatchTutorialController> {
  const WatchTutorialView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          ' Watch Tutorial',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Variabels.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Obx(() {
          final tutorial = controller.tutorial.value;
          final videoId = YoutubePlayerController.convertUrlToId(tutorial.link);

          if (videoId == null) {
            return const Center(child: Text("Invalid YouTube link"));
          }

          final youtubeController = YoutubePlayerController.fromVideoId(
            videoId: videoId,
            autoPlay: true,
            params: const YoutubePlayerParams(
              showControls: true,
              showFullscreenButton: true,
            ),
          );

          return LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildContent(
                        context,
                        youtubeController,
                        tutorial,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  List<Widget> _buildContent(
    BuildContext context,
    YoutubePlayerController controller,
    var tutorial, {
    bool skipVideo = false,
  }) {
    return [
      if (!skipVideo) ...[
        YoutubePlayerScaffold(
          controller: controller,
          aspectRatio: 16 / 9,
          builder: (context, player) => player,
        ),
        const SizedBox(height: 24),
      ],
      Text(
        tutorial.title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        tutorial.date,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        tutorial.description,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      ),
      const SizedBox(height: 32),
    ];
  }
}
