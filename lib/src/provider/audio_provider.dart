import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider with ChangeNotifier {
  final player = AudioPlayer();
  int _currentAudioIndex = 0;
  ImageProvider? _currentImage; // Make _currentImage nullable
  bool _isLoading = true; // Initialize _isLoading with a default value
  final List<Map<String, dynamic>> audioFiles = [
    {
      'id': 1,
      'title': 'Music Festival Background Music',
      'image': 'https://img.freepik.com/vector-gratis/fondo-festival-musica-estilo-plano_23-2147786017.jpg?t=st=1715262120~exp=1715265720~hmac=18d59fe43186f2c4f5a2bc80f61aee232c2a550ca870cd83a06759ce8bcfa3f5&w=740',
      'url': 'https://cdn.pixabay.com/audio/2024/05/07/audio_6f6e418d0b.mp3',
    },
    {
      'id': 2,
      'title': 'El Sonido de la Naturaleza',
      'image': 'https://img.freepik.com/foto-gratis/mujer-sonriente-auriculares-divirtiendose-disfrutando-musica_23-2148137961.jpg?t=st=1715262592~exp=1715266192~hmac=4688f1cbcda1fedb8fc8befd7b4d8cb845084878dc35e213a3a450faf2b34a8c&w=1380',
      'url': 'https://cdn.pixabay.com/audio/2024/04/08/audio_a52987d56b.mp3',
    },
    {
      'id': 3,
      'title': 'Ostia Cabrón',
      'image': 'https://mallorcamusicmagazine.com/wp-content/uploads/Portada-Caronte-CABRON.jpg.webp',
      'url': 'https://cdn.pixabay.com/audio/2024/05/02/audio_4670cc68f5.mp3',
    },
    {
      'id': 4,
      'title': 'Amanecer en el Campo',
      'image': 'https://i.pinimg.com/originals/5b/68/c6/5b68c6a1d76f78a17137d825c115b96d.jpg',
      'url': 'https://cdn.pixabay.com/audio/2024/05/03/audio_a80ebb1756.mp3',
    },
    {
      'id': 5,
      'title': 'Bosque Encantado',
      'image': 'https://www.castelloninformacion.com/wp-content/uploads/2023/12/bosque-encantado-3.jpg',
      'url': 'https://cdn.pixabay.com/audio/2024/05/02/audio_fe37bb93b3.mp3',
    },
    {
      'id': 6,
      'title': 'Shooting Stars',
      'image': 'https://www.greenbiz.com/sites/default/files/styles/16_9_cropped/public/2023-04/shutterstock_349131284.jpg?itok=_Z1U5WO2',
      'url': 'https://cdn.pixabay.com/audio/2024/04/26/audio_ed423c1b96.mp3',
    },
  ];

  /// Constructor
  AudioProvider() {
    _loadImage();
    _loadAudio();
  }

  /// Getters
  ImageProvider? get currentImage => _currentImage;
  int get currentAudioIndex => _currentAudioIndex;
  bool get isLoading => _isLoading;

  /// Methods


  /// [_loadImage] se encarga de cargar la imagen de la lista de audioFiles.
  Future<void> _loadImage() async {
    final Completer<ImageProvider> completer = Completer();
    final ImageStream stream = NetworkImage(audioFiles[_currentAudioIndex]['image']).resolve(ImageConfiguration.empty);
    final listener = ImageStreamListener((ImageInfo info, bool synchronousCall) {
      completer.complete(NetworkImage(audioFiles[_currentAudioIndex]['image']));
    });

    stream.addListener(listener);
    completer.future.then((_) => stream.removeListener(listener));

    _currentImage = await completer.future;
    _isLoading = false;
    notifyListeners();
  }

  /// [_loadAudio] se encarga de cargar el audio de la lista de audioFiles.
  Future<void> _loadAudio() async {
    await player.setUrl(audioFiles[_currentAudioIndex]['url']);
  }

  /// [playPrevious] se encarga de reproducir la canción anterior.
  void playPrevious() {
    if (_currentAudioIndex == 0) {
      _currentAudioIndex = audioFiles.length - 1;
    } else {
      _currentAudioIndex--;
    }

    _isLoading = true;
    notifyListeners();
    _loadImage();
    _loadAudio();
  }

  /// [playNext] se encarga de reproducir la siguiente canción.
  void playNext() {
    if (_currentAudioIndex == audioFiles.length - 1) {
      _currentAudioIndex = 0;
    } else {
      _currentAudioIndex++;
    }

    _isLoading = true;
    notifyListeners();
    _loadImage();
    _loadAudio();
  }
}