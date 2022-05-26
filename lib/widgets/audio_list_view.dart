import 'package:audio_qoohoo/controllers/audio_controller.dart';
import 'package:audio_qoohoo/models/audio_model.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AudioList extends StatelessWidget {
  const AudioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());
    return Obx(
      () {
        List<AudioModel> listOfRecordings = audioController.getListOfRecordings;
        return Expanded(
          child: ListView.builder(
            itemCount: listOfRecordings.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () async {
                  if (listOfRecordings[index].isPlaying) {
                    audioController.stopPlayingRecording(index);
                  } else {
                    audioController.playRecording(index);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xFF276bfd),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        width: 6,
                      ),
                      Icon(
                        listOfRecordings[index].isPlaying
                            ? Icons.stop
                            : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      AudioFileWaveforms(
                        size: Size(MediaQuery.of(context).size.width / 2, 70),
                        playerController:
                            audioController.getPlayerController(index),
                        density: 1.5,
                        playerWaveStyle: const PlayerWaveStyle(
                          scaleFactor: 0.5,
                          fixedWaveColor: Colors.blue,
                          liveWaveColor: Colors.white,
                          waveCap: StrokeCap.butt,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
