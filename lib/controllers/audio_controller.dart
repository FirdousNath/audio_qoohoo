import 'dart:async';
import 'dart:io';
import 'package:audio_qoohoo/models/audio_model.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioController extends GetxController {
  final dynamic _recorderController = RecorderController().obs;
  final dynamic _playerController = PlayerController().obs;
  final dynamic _recordingList = <AudioModel>[].obs;
  final dynamic _isRecording = false.obs;
  final dynamic _recordingStarted = false.obs;
  final dynamic _timer = 0.obs;
  Timer _timerController = Timer.periodic(
    const Duration(seconds: 1),
    ((Timer timer) {}),
  );

  bool get isRecordingStarted => _recordingStarted.value;

  bool get isRecording => _isRecording.value;

  int get getTimer => _timer.value;

  List<AudioModel> get getListOfRecordings => _recordingList.value;

  RecorderController getRecordController() {
    return _recorderController.value;
  }

  PlayerController getPlayerController() {
    return _playerController.value;
  }

  void pauseRecording() async {
    _timerController.cancel();
    await _recorderController.value.pause();
    _isRecording.value = false;
  }

  void resumeRecording() async {
    handleTimer();
    await _recorderController.value.record();
    _isRecording.value = true;
  }

  void startRecording() async {
    if (await handlePermission()) {
      _recordingStarted.value = true;
      await _recorderController.value.record();
      _isRecording.value = true;
      handleTimer();
    } else {
      // we can show dialog and then redirect them to setting
      //or show rationale on android
      openAppSettings();
    }
  }

  void stopRecording(bool save) async {
    _timerController.cancel();
    _recordingStarted.value = false;
    String path = await _recorderController.value.stop();
    if (path.contains("file://")) path = path.substring(7);
    _isRecording.value = false;
    if (save) {
      List<AudioModel> temp = List.from(_recordingList.value);
      temp.add(
        AudioModel(
          fileName: path,
          dateTime: DateTime.now(),
          time: _timer.value,
        ),
      );
      _recordingList.value = List<AudioModel>.from(temp);
    }
    _timer.value = 0;
    Get.back();
  }

  Future<void> preparePlayer(int index) async {
    AudioModel audioModel = _recordingList.value[index];
    PlayerController playerController = PlayerController();
    await playerController.preparePlayer(audioModel.fileName);
    _playerController.value = playerController;
  }

  void playRecording(int index) async {
    AudioModel audioModel = _recordingList.value[index];
    await _playerController.value.startPlayer();
    audioModel.togglePlay();
    notifyListeners(audioModel, index);
  }

  void stopPlayingRecording(int index) async {
    AudioModel audioModel = _recordingList.value[index];
    await _playerController.value.pausePlayer();
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
    if (Platform.isAndroid && await Permission.storage.request().isGranted) {
      if (await Permission.microphone.request().isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await Permission.microphone.request().isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }

  void handleTimer() {
    _timerController = Timer.periodic(
      const Duration(seconds: 1),
      ((_timerController) {
        _timer.value = _timer.value + 1;
      }),
    );
  }
}
