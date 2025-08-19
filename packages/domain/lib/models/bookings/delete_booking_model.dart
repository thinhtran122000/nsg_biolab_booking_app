class DeleteBookingModel {
  String? message;
  List<String>? messages;
  int? code;
  bool? status;

  DeleteBookingModel({
    this.message,
    this.messages,
    this.code,
    this.status,
  });
  factory DeleteBookingModel.fromJson(Map<String, dynamic>? json) => DeleteBookingModel(
        message: json?['message'],
        messages: json?['messages'] ?? [],
        code: json?['code'],
        status: json?['status'],
      );
}

/*



*/



class Movie {
  Movie({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  DateTime? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json['adult'] ?? false,
        backdropPath: json['backdrop_path'],
        genreIds: json['genre_ids'] == null ? [] : List<int>.from(json['genre_ids'].map((x) => x)),
        id: json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity']?.toDouble(),
        posterPath: json['poster_path'],
        releaseDate: DateTime.parse(json['release_date']),
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average']?.toDouble(),
        voteCount: json['vote_count'],
      );
}
