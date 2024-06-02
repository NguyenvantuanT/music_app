import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:music_app/components/app_mediumButton.dart';
import 'package:music_app/components/app_tab_bar.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/themes/color.dart';

class PlayMusicPage extends StatefulWidget {
  const PlayMusicPage(this.song, {super.key, required, required this.songs});

  final Song song;
  final List<Song> songs;

  @override
  State<PlayMusicPage> createState() => _PlayMusicPageState();
}

class _PlayMusicPageState extends State<PlayMusicPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isPlaying = false;
  int _currentSongIndex = 0;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer.onDurationChanged.listen((Duration d) {
      setState(() {
        _duration = d;
      });
    });
    _audioPlayer.onPositionChanged.listen((Duration p) {
      setState(() {
        _position = p;
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      _nextSong();
    });
    _currentSongIndex = widget.songs.indexOf(widget.song);
    // _playPause();
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const delta = 64;
    final radius = (size.width - delta) / 1.8;
    final song = widget.songs;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const AppTabBar(text: 'Now Playing'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(song[_currentSongIndex].album ?? ''),
            const Text('_ ____ _'),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10)
                      .copyWith(bottom: 40),
              child: _buildImageSong(radius, song),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.share_outlined),
                ),
                Column(
                  children: [
                    Text(song[_currentSongIndex].title ?? ''),
                    Text(song[_currentSongIndex].artist ?? '')
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.favorite_border),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Slider(
                activeColor: AppColor.black,
                value: _position.inSeconds.toDouble(),
                max: _duration.inSeconds.toDouble(),
                onChanged: (double value) {
                  _seekTo(value);
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatDuration(_position)),
                  Text(_formatDuration(_duration)),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AppMediumbutton(
                  icon: const Icon(
                    Icons.shuffle,
                    size: 24,
                    color: AppColor.grey,
                  ),
                  onTap: () {},
                ),
                AppMediumbutton(
                  icon: const Icon(
                    Icons.skip_previous,
                    size: 36,
                    color: AppColor.grey,
                  ),
                  onTap: _backSong,
                ),
                AppMediumbutton(
                  icon: Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 48,
                    color: AppColor.grey,
                  ),
                  onTap: _playPause,
                ),
                AppMediumbutton(
                  icon: const Icon(
                    Icons.skip_next,
                    size: 36,
                    color: AppColor.grey,
                  ),
                  onTap: _nextSong,
                ),
                AppMediumbutton(
                  icon: const Icon(
                    Icons.repeat,
                    size: 24,
                    color: AppColor.grey,
                  ),
                  onTap: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Transform _buildImageSong(double radius, List<Song> song) {
    return Transform.rotate(
      angle: _isRotating ? _calculateAngle() : 0.0,
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          child: Image.network(
            song[_currentSongIndex].image ?? '',
            fit: BoxFit.cover,
          )),
    );
  }

  void _seekTo(double seconds) {
    final newPosition = Duration(seconds: seconds.round());
    _audioPlayer.seek(newPosition);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer
          .play(UrlSource(widget.songs[_currentSongIndex].source ?? ''));
    }
    setState(() {
      _isPlaying = !_isPlaying;
      _isRotating = true;
    });
  }

  void _backSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex - 1) % widget.songs.length;
      _isPlaying = false;
    });
    _playPause();
  }

  void _nextSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex + 1) % widget.songs.length;
      _isPlaying = false;
    });
    _playPause();
  }

  double _calculateAngle() {
    const double circleRadians = 2 * 3.14; // 1 vòng tròn = 2 * pi radian
    const double rotationSpeed =
        circleRadians / 20; // Quay một vòng tròn trong 20 giây
    final double currentTimeInSeconds = DateTime.now().millisecondsSinceEpoch /
        1000; // Thời gian hiện tại tính bằng giây
    return currentTimeInSeconds *
        rotationSpeed; // Góc quay hiện tại được tính dựa trên thời gian
  }
}
