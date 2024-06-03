import 'package:flutter/material.dart';
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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppTabBar(
          text: 'Music',
          icon:const Icon(Icons.light_mode_outlined),
          onTap: () {},
        ),
        body: GestureDetector(
          onTap: () =>  FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Divider(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Visibility(
                      visible: showSearch,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: _buildSearchBox(),
                      ),
                    ),
                    _buildBody(),
                  ],
                ),
              ),
              _buildButtonSearch()
            ],
          ),
        ));
  }

  Widget _buildButtonSearch() {
    return Positioned(
        left: 20,
        right: 20,
        bottom: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                if (!showSearch) {
                  showSearch = true;
                  setState(() {});
                  return;
                }
                String text = searchController.text.trim();
                if (text.isEmpty) {
                  showSearch = false;
                  setState(() {});
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    border: Border.all(color: AppColor.black, width: 1.2),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: const [
                      BoxShadow(
                          color: AppColor.shadow,
                          offset: Offset(0.0, 3.0),
                          blurRadius: 6.0)
                    ]),
                child: const Icon(Icons.search, size: 22.0 , color: AppColor.red,),
              ),
            )
          ],
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
