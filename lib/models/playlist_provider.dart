import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_player_app/models/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: 'Biz Senle',
      artistName: 'Cem Adrian',
      albumArtImagePath: 'assets/images/1.jpg',
      audioPath: 'assets/music/music-1.mp3',
    ),
    Song(
      songName: 'I Hate it Here',
      artistName: 'Taylor Swift',
      albumArtImagePath: 'assets/images/2.jpg',
      audioPath: 'assets/music/music-2.mp3',
    ),
    Song(
      songName: 'Sen Gel Diyorsun',
      artistName: 'Cem Adrian',
      albumArtImagePath: 'assets/images/3.jpg',
      audioPath: 'assets/music/music-3.mp3',
    ),

    Song(
      songName: 'Heycani Yok',
      artistName: 'Cem Adrian',
      albumArtImagePath: 'assets/images/4.jpg',
      audioPath: 'assets/music/music-4.mp3',
    ),
    Song(
      songName: 'Mihriban',
      artistName: 'Cem Adrian',
      albumArtImagePath: 'assets/images/5.jpg',
      audioPath: 'assets/music/music-5.mp3',
    ),
  ];
  int? _currentSongIndex;

  List<Song> get playlist => _playlist;
  int? get currentSongIndex => _currentSongIndex;

  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  PlaylistProvider() {
    listenToDuration();
  }

  bool _isPlaying = false;

  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(
        AssetSource(path));
    _isPlaying = true;
    notifyListeners();
  }

  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }
void playPreviousSong() async{
    if(_currentDuration.inSeconds > 2){
seek(Duration.zero);
    }else{
      if(_currentSongIndex! > 0){
        currentSongIndex = _currentSongIndex! -1;
      }else{
        currentSongIndex = _playlist.length-1;
      }
    }
}



  void listenToDuration() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();

    });
  }

  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;



  set currentSongIndex(int? newIndex) {
    _currentSongIndex = newIndex;

    if(newIndex != null){
      play();
    }


    notifyListeners();
  }





}
