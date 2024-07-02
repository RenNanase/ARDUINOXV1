import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(const VideoTutorial());
}

class VideoTutorial extends StatelessWidget {
  const VideoTutorial({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.pink[50],
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink[100],
          title: const Text('V I D E O   T U T O R I A L S'),
          titleSpacing: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Navigate back to the previous screen
            },
          ),
        ),
        body:  VideoGrid(),
      ),
    );
  }
}

class VideoGrid extends StatelessWidget {
  final List<VideoInfo> videos = [
    VideoInfo(
      videoUrl: 'https://youtu.be/cjK1I2KarYU?list=PLeVrdakJu3M43jB2WqKEL4_Hhn94LpOMT',
      name: 'Making a Paintbox RGB',


    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/2oAQ5KoJJU0?list=PLeVrdakJu3M43jB2WqKEL4_Hhn94LpOMT',
      name: 'Making a Fading LED',

    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/qe9_HXo_CPE?list=PLeVrdakJu3M43jB2WqKEL4_Hhn94LpOMT',
      name: 'Making a Police Siren with a 556 Timer',

    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/eIj3fRG-4xk?list=PLeVrdakJu3M43jB2WqKEL4_Hhn94LpOMT',
      name: 'Making the Harry Potter Theme Song',

    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/rkL-eFoyEXo?list=PLeVrdakJu3M43jB2WqKEL4_Hhn94LpOMT',
      name: 'Making Arduino Game-Whack a Mole',

    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/m930o_TbPR0?list=PLeVrdakJu3M43jB2WqKEL4_Hhn94LpOMT',
      name: 'Making Arduino Game-Memory',

    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/96zC_yUOdAM?list=PLiRNARoNN8e1iLA9VebDx5SlwvzhIs6F7',
      name: 'Digital Clock',

    ),
    VideoInfo(
      videoUrl: 'https://youtu.be/58jFAammYcw?list=PLiRNARoNN8e1iLA9VebDx5SlwvzhIs6F7',
      name: 'Digital Keypad Security Door Lock',
    ),
    // Add more video URLs and info
  ];

   VideoGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: videos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2, // Adjust this value to make the video bigger
      ),


      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: VideoWidget(
                  videoInfo: videos[index],
                ),
              ),

              const SizedBox(height: 10),
              Text(videos[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  fontSize:20)
              ),

            ],
          ),
        );
      },
    );
  }
}

class VideoInfo {
  final String videoUrl;
  final String name;


  VideoInfo({
    required this.videoUrl,
    required this.name,

  });
}

class VideoWidget extends StatefulWidget {
  final VideoInfo videoInfo;

  const VideoWidget({ required this.videoInfo, Key? key});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoInfo.videoUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.pink,
      progressColors: const ProgressBarColors(
        playedColor: Colors.pink,
        handleColor: Colors.pink,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}