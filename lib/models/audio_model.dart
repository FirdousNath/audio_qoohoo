import 'package:audio_waveforms/audio_waveforms.dart';

class AudioModel {
  DateTime dateTime;
  bool isPlaying;
  PlayerController audioPlayerController;

  AudioModel({
    required this.dateTime,
    required this.audioPlayerController,
    this.isPlaying = false,
  });

  togglePlay() {
    isPlaying = !isPlaying;
  }
}
