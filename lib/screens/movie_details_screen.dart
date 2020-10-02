import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/utils/links.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool _isLoading = false;
  Map<String, dynamic> _movieDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context).settings.arguments;
    _isLoading = true;
    Dio()
        .get('${Links.movieDetailsBaseUrl}/$id')
        .catchError((error) => null) // TODO: treat this error
        .then((response) => setState(() {
              _isLoading = false;
              if (response.data == null) {
                // TODO: treat this error
              }
              _movieDetails = response.data;
            }));
  }

  String _parseGenres(List<dynamic> genres) =>
      (StringBuffer()..writeAll(genres, ', ')).toString();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movie Advisor')),
        body: Center(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(_movieDetails['title']),
                        Container(
                          height: 60,
                          width: 60,
                          padding: const EdgeInsets.all(10),
                          child: Image.network(
                            _movieDetails['poster_url'],
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              '${Links.imagesFolder}/no_image_100.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Text('Synopsis'),
                        Text(_movieDetails['overview']),
                        const Text('Genres'),
                        Text(_parseGenres(_movieDetails['genres'])),
                      ],
                    ),
                  )),
      );
}
