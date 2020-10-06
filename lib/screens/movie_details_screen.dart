import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/utils/error_handling.dart';
import 'package:movie_advisor/utils/links.dart';
import 'package:movie_advisor/widgets/image_from_network.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isLoading = false;
  Map<String, dynamic> _movieDetails;
  bool _isFirstCall = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isFirstCall) {
      _isFirstCall = false;
      final id = ModalRoute.of(context).settings.arguments;
      _isLoading = true;
      // Fetch movie details
      Dio().get('${Links.movieDetailsBaseUrl}/$id').catchError((error) {
        final DioError dioError = error;
        final isServerError = dioError.response != null;
        ErrorHandling.showErrorDialog(
          isServerError,
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(),
            settings: RouteSettings(arguments: id),
          ),
        );
      }).then((response) => setState(() {
            // Treat more server errors
            if (response.data == null) {
              ErrorHandling.showErrorDialog(
                true,
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailsScreen(),
                  settings: RouteSettings(arguments: id),
                ),
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
