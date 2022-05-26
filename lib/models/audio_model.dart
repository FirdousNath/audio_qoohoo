class AudioModel {
  DateTime dateTime;
  bool isPlaying;
  String fileName;
  int time;

  AudioModel({
    required this.dateTime,
    required this.fileName,
    this.isPlaying = false,
    this.time = 0,
  });

  togglePlay() {
    isPlaying = !isPlaying;
  }
}
