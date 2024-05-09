import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/app_colors.dart';
import '../../../provider/audio_provider.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late AudioProvider audioProvider;

  @override
  void initState() {
    super.initState();
    audioProvider = Provider.of<AudioProvider>(context, listen: false);
    audioProvider.player.playerStateStream.listen((playerState) {
      setState(() {});
    });
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

  /// Content
  Widget _content() {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
          child: Column(
            children: [
              // Image | Title |
              _infoMusic(),
              // Play | Previous | Next |
              _buttonSection(),
            ],
          ),
        );
      },
    );
  }

  /// [_infoMusic] se encarga de mostrar la imagen y el título de la canción.
  Widget _infoMusic(){
    return Container(
      padding: const EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 0.0),
      child: Column(
        children: [
          if (audioProvider.isLoading)
            const CircularProgressIndicator()
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                audioProvider.audioFiles[audioProvider.currentAudioIndex]['image'] as String,
                width: 350,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 20),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: Text(
              audioProvider.audioFiles[audioProvider.currentAudioIndex]['title'] as String,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buttonSection] se encarga de mostrar los botones de play, previous y next.
  Widget _buttonSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.skip_previous, size: 35),
          onPressed: () {
            // Play previous song
            audioProvider.playPrevious();
          },
        ),
        IconButton(
          icon: audioProvider.player.playerState.playing
              ? const Icon(Icons.pause, size: 35)
              : const Icon(Icons.play_arrow, size: 35),
          onPressed: () async {
            // Play song
            if (audioProvider.player.playerState.playing) {
              await audioProvider.player.pause();
            } else {
              await audioProvider.player.play();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next, size: 35),
          onPressed: () {
            // Play next song
            audioProvider.playNext();
          },
        ),
      ],
    );
  }
}