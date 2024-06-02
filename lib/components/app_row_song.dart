import 'package:flutter/material.dart';
import 'package:music_app/models/song_model.dart';

class AppRowSong extends StatelessWidget {
  const AppRowSong(this.song, {super.key, this.onTap, this.onPlay});

  final Song song;
  final Function()? onTap;
  final Function()? onPlay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: 24,
          right: 8
        ),
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Image.network(song.image ?? '', fit: BoxFit.cover),
          ),
          title: Text(song.title ?? ''),
          subtitle: Text(song.artist ?? ''),
          trailing: GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.more_horiz),
          )),
    );
  }
}
