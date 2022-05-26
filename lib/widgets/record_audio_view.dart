import 'package:audio_qoohoo/controllers/audio_controller.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordAudioView extends StatelessWidget {
  const RecordAudioView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());

    return Obx(
      () {
        bool recordingStarted = audioController.isRecordingStarted;
        bool isRecording = audioController.isRecording;
        final RecorderController recorderController =
            audioController.getRecordController();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AudioWaveforms(
              waveStyle: const WaveStyle(
                showDurationLabel: false,
                showBottom: true,
                extendWaveform: true,
                showMiddleLine: false,
              ),
              enableGesture: false,
              size: Size(Get.width, 56.0),
              recorderController: recorderController,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: recordingStarted
                  ? MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: [
                if (recordingStarted)
                  GestureDetector(
                    child: Icon(
                      Icons.delete,
                      color: Colors.red.shade400,
                      size: 40,
                    ),
                    onTap: () async {
                      audioController.stopRecording(false);
                    },
                  ),
                GestureDetector(
                  child: Icon(
                    isRecording ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.blue,
                    size: 40,
                  ),
                  onTap: () async {
                    if (!isRecording) {
                      audioController.startRecording();
                    } else {
                      audioController.pauseRecording();
                    }
                  },
                ),
                if (recordingStarted)
                  GestureDetector(
                    child: Icon(
                      Icons.send,
                      color: Colors.green.shade400,
                      size: 40,
                    ),
                    onTap: () async {
                      audioController.stopRecording(true);
                    },
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }
}
