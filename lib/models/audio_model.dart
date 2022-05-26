import 'package:audio_waveforms/audio_waveforms.dart';

class AudioModel {
  DateTime dateTime;
  bool isPlaying;
  PlayerController audioPLayerController;

  AudioModel({
    required this.dateTime,
    required this.audioPLayerController,
    this.isPlaying = false,
  });

  togglePlay() {
    isPlaying = !isPlaying;
  }
}
