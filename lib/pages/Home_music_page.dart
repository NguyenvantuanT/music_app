import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/components/app_row_song.dart';
import 'package:music_app/components/app_search_box.dart';
import 'package:music_app/components/app_tab_bar.dart';
import 'package:music_app/models/song_model.dart';
import 'package:music_app/pages/play_music_page.dart';
import 'package:music_app/services/repository/repository.dart';
import 'package:music_app/themes/color.dart';

class HomeMusicPage extends StatefulWidget {
  const HomeMusicPage({super.key});

  @override
  State<HomeMusicPage> createState() => _HomeMusicPageState();
}

class _HomeMusicPageState extends State<HomeMusicPage> {
  final TextEditingController searchController = TextEditingController();
  List<Song> songs = [];
  List<Song> songSearchs = [];
  bool showSearch = false;
  FocusNode addFocus = FocusNode();

  void loadSong() async {
    final repository = DefaultRepository();
    List<Song>? loadedSongs = await repository.loadData();
    if (loadedSongs != null) {
      setState(() {
        songs.addAll(loadedSongs);
      });
    }
    songSearchs = [...songs];
  }

  @override
  void initState() {
    super.initState();
    loadSong();
  }

  void _search(String value) {
    value = value.toLowerCase();
    songSearchs = songs
        .where((song) => (song.title ?? '').toLowerCase().contains(value))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppTabBar(
          text: 'Music',
          color: AppColor.white,
          onTap: () {
            if (!showSearch) {
              showSearch = true;
              setState(() {});
              addFocus.requestFocus();
              return;
            }
            String text = searchController.text.trim();
            if (text.isEmpty) {
              showSearch = false;
              setState(() {});
              addFocus.unfocus();
            }
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: showSearch,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: _buildSearchBox(),
                ),
              ),
              _buildBody(),
            ],
          ),
        ));
  }

  Widget _buildSearchBox() {
    return AppSearchBox(
      focusNode: addFocus,
      onChanged: _search,
      controller: searchController,
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10)
          .copyWith(top: 10, bottom: 70),
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        thickness: 1,
        indent: 24.0,
        endIndent: 10.0,
      ),
      itemCount: songSearchs.length,
      itemBuilder: (context, index) {
        final song = songSearchs[index];
        return AppRowSong(
          song,
          onPlay: () => _navigatorPlay(song, songs),
        );
      },
    );
  }

  void _navigatorPlay(Song song, List<Song> songs) {
    Route route = MaterialPageRoute(
        builder: (context) => PlayMusicPage(song, songs: songs));
    Navigator.push(context, route);
  }
}
