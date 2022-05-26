import 'package:audio_qoohoo/models/audio_model.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioController extends GetxController {
  final dynamic _recorderController = RecorderController().obs;
  final dynamic _recordingList = <AudioModel>[].obs;
  final dynamic _isRecording = false.obs;
  final dynamic _recordingStarted = false.obs;

  bool get isRecordingStarted => _recordingStarted.value;

  bool get isRecording => _isRecording.value;

  List<AudioModel> get getListOfRecordings => _recordingList.value;

  RecorderController getRecordController() {
    return _recorderController.value;
  }

  PlayerController getPlayerController(int index) {
    AudioModel audioModel = _recordingList.value[index];
    return audioModel.audioPlayerController;
  }

  void pauseRecording() async {
    await _recorderController.value.pause();
    _isRecording.value = false;
  }

  void resumeRecording() async {
    await _recorderController.value.record();
    _isRecording.value = true;
  }

  void startRecording() async {
    if (await handlePermission()) {
      _recordingStarted.value = true;
      await _recorderController.value.record();
      _isRecording.value = true;
    } else {
      // we can show dialog and then redirect them to setting
      //or show rationale on android
      openAppSettings();
    }
  }

  void stopRecording(bool save) async {
    _recordingStarted.value = false;
    String path = await _recorderController.value.stop();
    path = path.substring(7);

    _isRecording.value = false;
    if (save) {
      PlayerController playerController = PlayerController();
      playerController.preparePlayer(path);

      List<AudioModel> temp = List.from(_recordingList.value);
      temp.add(
        AudioModel(
          audioPlayerController: playerController,
          dateTime: DateTime.now(),
        ),
      );
      _recordingList.value = List<AudioModel>.from(temp);
    }
  }

  void playRecording(int index) async {
    AudioModel audioModel = _recordingList.value[index];
    await audioModel.audioPlayerController.startPlayer();
    audioModel.togglePlay();
    notifyListeners(audioModel, index);
  }

  void stopPlayingRecording(int index) async {
    AudioModel audioModel = _recordingList.value[index];
    await audioModel.audioPlayerController.pausePlayer();
    audioModel.togglePlay();
    notifyListeners(audioModel, index);
  }

  void notifyListeners(AudioModel audioModel, int index) {
    List<AudioModel> temp = List.from(_recordingList.value);
    temp[index] = audioModel;
    _recordingList.value = List<AudioModel>.from(temp);
  }

  void resetList() {
    _recordingList.value = List<AudioModel>.empty();
  }

  Future<bool> handlePermission() async {
    if (await Permission.microphone.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
