import 'package:audio_qoohoo/constants/colors.dart';
import 'package:audio_qoohoo/controllers/audio_controller.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
        appBar: NeumorphicAppBar(
          centerTitle: false,
          title: const Text("Qoohoo Recording App"),
          actions: [
            NeumorphicButton(
              onPressed: audioController.resetList,
              style: const NeumorphicStyle(
                depth: 3,
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              padding: const EdgeInsets.all(12.0),
              child: const Icon(
                Icons.cleaning_services,
                color: primaryColor,
              ),
            ),
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
