import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void audioPlayerTaskEntrypoint() {
  AudioServiceBackground.run(() => AudioPlayerTask());
}

void startAudioService() {
  AudioService.start(
    backgroundTaskEntrypoint: audioPlayerTaskEntrypoint,
    androidNotificationChannelName: 'Audio Service Demo',
    androidNotificationIcon: 'mipmap/ic_launcher',
    androidEnableQueue: true,
  );
}

void stopAudioService() {
  AudioService.stop();
}

class AudioPlayerTask extends BackgroundAudioTask {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late BuildContext context;

  @override
  Future<void> onStart(Map<String, dynamic>? params) async {
    AudioServiceBackground.setState(
      controls: [MediaControl.pause],
      playing: true,
      processingState: AudioProcessingState.loading,
    );

    try {
      await _audioPlayer.setAsset('assets/iphone_ringer.mp3');
      await _audioPlayer.play();
      AudioServiceBackground.setState(
        controls: [MediaControl.pause],
        playing: true,
        processingState: AudioProcessingState.ready,
      );
      // _audioPlayer.playbackEventStream.listen((event) {
      //   if (event.processingState == ProcessingState.ready) {
      //     print('ready');
      //   } else
      //     print('no ready');
      //   if (event.processingState == ProcessingState.values) {
      //     // Show dialog when playback completes
      //     showDialog(
      //       context: context,
      //       builder: (context) {
      //         return myDialogDisplaySound(
      //           context: context,
      //           onPress: () => stopAudioService(),
      //         );
      //       },
      //     );
      //   }
      // });
    } catch (e) {
      print('Error: $e');
      onStop();
    }
  }

  @override
  Future<void> onStop() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    await super.onStop();
  }
}
