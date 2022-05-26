import 'package:audio_qoohoo/controllers/audio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/record_audio_view.dart';
import 'widgets/audio_list_view.dart';

class AudioListingScreen extends StatefulWidget {
  const AudioListingScreen({Key? key}) : super(key: key);

  @override
  _AudioListingScreenState createState() => _AudioListingScreenState();
}

class _AudioListingScreenState extends State<AudioListingScreen> {
  @override
  Widget build(BuildContext context) {
    final AudioController audioController = Get.put(AudioController());
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Qoohoo Audio Demo"),
          actions: [
            IconButton(
              //for good UX we can show confirmation dialog
              onPressed: audioController.resetList,
              icon: const Icon(
                Icons.cleaning_services_outlined,
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            AudioList(),
            RecordAudioView(),
          ],
        ),
      ),
    );
  }
}
