import 'package:flutter/material.dart';

class NeoMorficButtonWidget extends StatefulWidget {
  final bool isRecording;
  const NeoMorficButtonWidget({this.isRecording = false, Key? key})
      : super(key: key);

  @override
  _NeoMorficButtonWidgetState createState() => _NeoMorficButtonWidgetState();
}

class _NeoMorficButtonWidgetState extends State<NeoMorficButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      // Gesture Detector to detect taps
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          child: const Icon(
            Icons.mic_off,
            color: Colors.grey,
            size: 40,
          ),
          // Providing duration parameter
          // to create animation
          duration: const Duration(
            milliseconds: 100,
          ),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            shape: BoxShape.circle,
            boxShadow: widget.isRecording
                ? [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      // Shadow for bottom right corner
                      offset: const Offset(10, 10),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                    const BoxShadow(
                      color: Colors.white,
                      // Shadow for top left corner
                      offset: Offset(-10, -10),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
        ),
      ),
    );
  }
}
