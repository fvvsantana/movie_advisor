import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/utils/error_handling.dart';
import 'package:movie_advisor/utils/url_builder.dart';
import 'package:movie_advisor/widgets/image_from_network.dart';

class MovieDetailsPage extends StatefulWidget {
  static const routeName = '/movie-details';

  @override
  _MovieDetailsPageState createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  bool _isLoading = false;
  Map<String, dynamic> _movieDetails;
  bool _isFirstCall = true;
  int id;

  void tryAgain() {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MovieDetailsPage(),
        settings: RouteSettings(arguments: id),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstCall) {
      _isFirstCall = false;
      id = ModalRoute.of(context).settings.arguments;
      _isLoading = true;
      // Fetch movie details
      Dio().get(UrlBuilder.movieDetails(id)).catchError((error) {
        final DioError dioError = error;
        final isServerError = dioError.response != null;
        showErrorDialog(
          context: context,
          isServerError: isServerError,
          onTryAgainTap: tryAgain,
        );
      }).then((response) => setState(() {
            // Treat more server errors
            if (response.data == null) {
              showErrorDialog(
                context: context,
                isServerError: true,
                onTryAgainTap: tryAgain,
              );
              return;
            }
            _isLoading = false;
            _movieDetails = response.data;
          }));
    }
  }

  String _parseGenres(List<String> genres) =>
      (StringBuffer()..writeAll(genres, ', ')).toString();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: Container(
            child: _isLoading
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
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Synopsis',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(_movieDetails['overview']),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Genres',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Text(_parseGenres(
                              _movieDetails['genres'].cast<String>().toList())),
                        ],
                      ),
                    ),
                  )),
      );
}
