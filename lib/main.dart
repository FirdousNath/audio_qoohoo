import 'package:audio_qoohoo/audio_listing_screen.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    const GetMaterialApp(
      home: NeumorphicApp(
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          baseColor: Color(0xFFFFFFFF),
          lightSource: LightSource.topLeft,
          depth: 10,
        ),
        home: AudioListingScreen(),
      ),
    ),
  );
}
