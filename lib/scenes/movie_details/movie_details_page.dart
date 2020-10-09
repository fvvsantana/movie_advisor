import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:movie_advisor/common/error_empty_state.dart';
import 'package:movie_advisor/utils/request_state.dart';
import 'package:movie_advisor/utils/url_builder.dart';
import 'package:movie_advisor/common/image_from_network.dart';

class MovieDetailsPage extends StatefulWidget {
  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  RequestState _requestState;
  bool _isServerError;
  Map<String, dynamic> _movieDetails;
  bool _isFirstCall = true;
  int _movieId;

  /*
    Make a http request to get the movie details data.
    Update the _requestState and _isServerError during the process.
    Treat the errors involved on fetching data.
    If no errors occurred, set the _movieDetails data.
   */
  void fetchAndSetMovieDetails() {
    setState(() {
      _requestState = RequestState.waiting;
    });
    // Fetch movie details
    Dio().get(UrlBuilder.movieDetails(_movieId)).catchError((error) {
      // Treat errors
      final DioError dioError = error;
      setState(() {
        _requestState = RequestState.error;
        _isServerError = dioError.response != null;
      });
    }).then((response) => setState(() {
          if (response == null) {
            return;
          }
          // Treat more server errors
          if (response.data == null) {
            _requestState = RequestState.error;
            _isServerError = true;
            return;
          }
          _movieDetails = response.data;
          _requestState = RequestState.successful;
          _isServerError = null;
        }));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstCall) {
      _isFirstCall = false;
      _movieId = ModalRoute.of(context).settings.arguments;
      fetchAndSetMovieDetails();
    }
  }

  String _parseGenres(List<String> genres) =>
      (StringBuffer()..writeAll(genres, ', ')).toString();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: Container(
            child: _requestState == RequestState.error
                ? ErrorEmptyState(
                  isServerError: _isServerError,
                  onTryAgainTap: fetchAndSetMovieDetails,
                )
                : _requestState == RequestState.waiting
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _movieDetails['title'],
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Container(
                                height: 300,
                                width: double.infinity,
                                padding: const EdgeInsets.all(10),
                                child: ImageFromNetwork(
                                  imageUrl: _movieDetails['poster_url'],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Synopsis',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Text(_movieDetails['overview']),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Genres',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Text(_parseGenres(_movieDetails['genres']
                                  .cast<String>()
                                  .toList())),
                            ],
                          ),
                        ),
                      )),
      );
}
