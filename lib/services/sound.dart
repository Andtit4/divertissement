import 'package:audioplayers/audioplayers.dart';


void jouerSon() {
  final player = AudioPlayer();
  const sonPath = 'playing.mp3';

  player.play(AssetSource(sonPath));

  
}
