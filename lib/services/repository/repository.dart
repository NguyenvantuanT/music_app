

import 'package:music_app/models/song_model.dart';
import 'package:music_app/services/source/source.dart';

abstract interface class Repository{
  Future<List<Song>?> loadData();
}


class DefaultRepository implements Repository{

  final _localDataSource = LocalDataSource();
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];

    await _remoteDataSource.loadData().then((remoteSong) async {
      if(remoteSong == null) {
        await _localDataSource.loadData().then((localSong){
          if(localSong != null){
             songs.addAll(localSong);
          }
        });
      }else{
        songs.addAll(remoteSong);
      }
    });
    return songs;
  }

}