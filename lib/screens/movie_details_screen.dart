import 'package:cached_network_image/cached_network_image.dart';
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
                            child: CachedNetworkImage(
                              imageUrl: _movieDetails['poster_url'],
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            /*
                            child: Image.network(
                              _movieDetails['poster_url'],
                              errorBuilder: (_, __, ___) => Image.asset(
                                '${Links.imagesFolder}/no_image_100.png',
                              ),
                            ),
                           */
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
