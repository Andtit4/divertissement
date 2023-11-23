import 'package:audioplayers/audioplayers.dart';

 jouerSon() {
  final player = AudioPlayer();
  const sonPath = 'playing.mp3';
  player.play(AssetSource(sonPath));

  // ignore: unrelated_type_equality_checks
  if (PlayerState.completed == true) {
    player.play(AssetSource(sonPath));
  }
}

stopAudio() {
  final player = AudioPlayer();
  if (PlayerState.playing == true) {
    print('object');
    player.stop();
  }
  // player.onPlayerStateChanged.listen((event) {
  //   switch (event) {
  //     case PlayerState.playing:
  //       player.stop();
  //       break;
  //     default:
  //       break;
  //   }
  // });
}
