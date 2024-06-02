

class Song {
  String? id;
  String? title;
  String? album;
  String? artist;
  String? source;
  String? image;
  int? duration;
  bool? favorite;
  int? counter;
  int? replay;

  Song({
   this.id,
   this.title,
   this.album,
   this.artist,
   this.source,
   this.image,
   this.duration,
   this.favorite ,
   this.counter,
   this.replay,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      source: json['source'],
      image: json['image'],
      duration: json['duration'],
      favorite: json['favorite'] == 'true',
      counter: json['counter'],
      replay: json['replay'],
    );
  }

  @override
  String toString() {
    return 'id: $id , titel: $title , img : $image , source: $source \n';
  }
}

