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
                      onPressed: () async {
                        await audioController.preparePlayer(index);
                        Get.bottomSheet(
                          Obx(
                            () {
                              bool isPlaying = audioController
                                  .getListOfRecordings[index].isPlaying;
                              int timer = audioController
                                  .getListOfRecordings[index].time;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    Text(
                                      isPlaying ? "Playing" : "Not Playing",
                                      style: const TextStyle(
                                        fontSize: 24,
                                        color: accentColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    AudioFileWaveforms(
                                      playerWaveStyle: const PlayerWaveStyle(
                                        showBottom: true,
                                        fixedWaveColor: primaryColor,
                                        liveWaveColor: accentColor,
                                        waveThickness: 1.5,
                                        scaleFactor: 0.5,
                                      ),
                                      size: Size(Get.width, 26.0),
                                      playerController:
                                          audioController.getPlayerController(),
                                    ),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                    NeumorphicButton(
                                      style: NeumorphicStyle(
                                        depth: 6,
                                        shape: NeumorphicShape.flat,
                                        boxShape:
                                            const NeumorphicBoxShape.circle(),
                                        color: backgroundColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Icon(
                                          isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: isPlaying
                                              ? accentColor
                                              : primaryColor,
                                          size: 30,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (isPlaying) {
                                          audioController
                                              .stopPlayingRecording(index);
                                        } else {
                                          audioController.playRecording(index);
                                        }
                                      },
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              );
                            },
                          ),
                          barrierColor: Colors.transparent,
                          backgroundColor: backgroundColor,
                        );
                      },
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat("dd MMM hh:mm aa")
                              .format(listOfRecordings[index].dateTime),
                          style: const TextStyle(
                            color: accentColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          '${(Duration(seconds: listOfRecordings[index].time))}'
                              .split('.')[0]
                              .padLeft(8, '0'),
                          style: const TextStyle(
                            color: accentColor,
                            fontSize: 12,
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
