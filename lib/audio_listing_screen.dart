import 'package:flutter/material.dart';
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
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Qoohoo Audio Demo"),
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
