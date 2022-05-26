import 'dart:io';

import 'package:audio_qoohoo/constants/colors.dart';
import 'package:audio_qoohoo/controllers/audio_controller.dart';
import 'package:audio_qoohoo/models/audio_model.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:intl/intl.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
              return Container(
                padding: const EdgeInsets.only(top: 6, bottom: 20),
                margin: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                        style: const NeumorphicStyle(
                          depth: 3,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: Icon(
                            listOfRecordings[index].isPlaying
                                ? Icons.stop
                                : Icons.play_arrow,
                            color: primaryColor,
                          ),
                        ),
                        onPressed: () {
                          if (listOfRecordings[index].isPlaying) {
                            audioController.stopPlayingRecording(index);
                          } else {
                            audioController.playRecording(index);
                          }
                        }),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("hh:mm aa dd-MMM")
                              .format(listOfRecordings[index].dateTime),
                          style: const TextStyle(
                            color: accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (Platform.isIOS)
                          const SizedBox(
                            height: 12,
                          ),
                        if (Platform.isIOS)
                          AudioFileWaveforms(
                            enableSeekGesture: true,
                            size: Size(
                                MediaQuery.of(context).size.width / 1.75, 20),
                            playerController:
                                audioController.getPlayerController(index),
                            density: 2,
                            playerWaveStyle: const PlayerWaveStyle(
                              scaleFactor: 0.2,
                              waveThickness: 1.5,
                              fixedWaveColor: primaryColor,
                              liveWaveColor: accentColor,
                              waveCap: StrokeCap.butt,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
