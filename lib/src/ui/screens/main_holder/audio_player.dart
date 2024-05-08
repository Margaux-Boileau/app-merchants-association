import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../config/app_colors.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final player = AudioPlayer();

  // List of audio files
  final List<String> audioFiles = [
    'https://cdn.pixabay.com/audio/2024/05/07/audio_6f6e418d0b.mp3',
    'https://cdn.pixabay.com/audio/2024/04/08/audio_a52987d56b.mp3',
    'https://cdn.pixabay.com/audio/2024/05/02/audio_4670cc68f5.mp3',
    'https://cdn.pixabay.com/audio/2024/05/03/audio_a80ebb1756.mp3',
    'https://cdn.pixabay.com/audio/2024/05/02/audio_fe37bb93b3.mp3',
    'https://cdn.pixabay.com/audio/2024/04/26/audio_ed423c1b96.mp3',
    'https://cdn.pixabay.com/audio/2024/04/29/audio_e420c100de.mp3',
    'https://cdn.pixabay.com/audio/2024/04/17/audio_fc399225d9.mp3',
    'https://cdn.pixabay.com/audio/2024/04/20/audio_d028718c61.mp3',
    'https://cdn.pixabay.com/audio/2024/04/26/audio_786f6967db.mp3',
  ];

  @override
  void initState() {
    super.initState();
    // Stream
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player'),
      ),
      body: _content(),
    );
  }

  /// Design of audio player
  /// Play, Pause, Stop, Next, Previous buttons
  Widget _content() {
    return Column(
      children: [
        //Expanded with : Image of song, Title of song, Slider of song, Play, Next, Previous
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(45.0, 35.0, 45.0, 15.0),
            child: Column(
              children: [
                // Image of song
                Container(
                  height: 300,
                  width: 400,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1525201548942-d8732f6617a0?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Title of song
                const Text(
                  'Crusade - Club Edit',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                ),
                // Slider of song
                Slider(
                  activeColor: AppColors.primaryBlue,
                  value: 0.0,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (double value) {
                    setState(() {});
                  },
                ),
                // Play, Next, Previous
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous, size: 35),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.play_arrow, size: 35),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, size: 35),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
