import 'package:movie_advisor/data/remote/remote_data_source.dart';

class Repository{
  final _rds = RemoteDataSource();

  /*
  Future<List<MovieSummaryModel>> getMoviesList() async{
    // Make request
    try {
      final moviesList = await _rds.getMoviesList();
      moviesList.map((rm) => rm.toModel()).toList();
    }catch(error){

    }
  }

   */
}