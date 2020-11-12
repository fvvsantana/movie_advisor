import 'package:flutter/material.dart';

import 'package:movie_advisor/common/errors.dart';
import 'package:movie_advisor/data/remote/models/movie_details_rm.dart';
import 'package:movie_advisor/data/remote/remote_data_source.dart';
import 'package:movie_advisor/presentation/common/error_empty_state.dart';
import 'package:movie_advisor/presentation/scenes/movie_details/movie_details.dart';

import 'package:movie_advisor/generated/l10n.dart';

class MovieDetailsPage extends StatefulWidget {
  const MovieDetailsPage({
    @required this.id,
  }) : assert(id != null);

  final int id;
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  CustomError _error;
  MovieDetailsRM _movieDetails;
  bool _isFirstCall = true;
  final _movieRDS = RemoteDataSource();

  /*
    Make an http request to get the movie details data.
    Treat the errors involved on fetching data.
    If errors occurred, set the attribute _error.
    If no errors occurred, set the _movieDetails data.
   */
  void _fetchAndSetMovieDetails() {
    // Refresh page to show loading spinner
    setState(() {
      _error = null;
      _movieDetails = null;
    });

    // Fetch data, treat success and error cases
    _movieRDS.getMovieDetails(widget.id).then((movieDetails) {
      setState(() {
        _movieDetails = movieDetails;
      });
    }).catchError((error) {
      print(error);
      setState(() {
        _error = error;
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstCall) {
      _isFirstCall = false;
      _fetchAndSetMovieDetails();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).movieDetailsAppBarTitle),
        ),
        body: _movieDetails != null
            ? MovieDetails(movieDetails: _movieDetails)
            : _error != null
                ? ErrorEmptyState.fromError(
                    error: _error,
                    onTryAgainTap: _fetchAndSetMovieDetails,
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
      );
}
