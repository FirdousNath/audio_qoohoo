import 'package:audio_qoohoo/constants/colors.dart';
import 'package:audio_qoohoo/controllers/audio_controller.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
        int timer = audioController.getTimer;
        final RecorderController recorderController =
            audioController.getRecordController();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                recordingStarted
                    ? isRecording
                        ? "Recording"
                        : "Recording Paused"
                    : "Start Recording",
                style: const TextStyle(
                  fontSize: 24,
                  color: accentColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              AudioWaveforms(
                waveStyle: const WaveStyle(
                  showDurationLabel: false,
                  showBottom: true,
                  extendWaveform: true,
                  showMiddleLine: false,
                  waveColor: accentColor,
                  waveThickness: 1.5,
                ),
                enableGesture: false,
                size: Size(Get.width, 36.0),
                recorderController: recorderController,
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(Duration(seconds: timer))}'
                        .split('.')[0]
                        .padLeft(8, '0'),
                    style: const TextStyle(
                      color: accentColor,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: recordingStarted
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  if (recordingStarted)
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        depth: 3,
                        shape: NeumorphicShape.flat,
                        boxShape: const NeumorphicBoxShape.circle(),
                        color: backgroundColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      onPressed: () async {
                        audioController.stopRecording(false);
                      },
                    ),
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      depth: 6,
                      shape: NeumorphicShape.flat,
                      boxShape: const NeumorphicBoxShape.circle(),
                      color: backgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        isRecording ? Icons.pause : Icons.mic,
                        color: recordingStarted ? accentColor : primaryColor,
                        size: 30,
                      ),
                    ),
                    onPressed: () async {
                      if (!isRecording) {
                        audioController.startRecording();
                      } else {
                        audioController.pauseRecording();
                      }
                    },
                  ),
                  if (recordingStarted)
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        depth: 4,
                        shape: NeumorphicShape.flat,
                        boxShape: const NeumorphicBoxShape.circle(),
                        color: backgroundColor,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 26,
                        ),
                      ),
                      onPressed: () async {
                        audioController.stopRecording(true);
                      },
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
