import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_advisor/utils/links.dart';

class MovieDetailsScreen extends StatefulWidget {
  static const routeName = '/movie-details';

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  String text;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final id = ModalRoute.of(context).settings.arguments;
    Dio()
        .get('${Links.movieDetailsBaseUrl}/$id')
        .then((response) => setState(() {
      text = response.data.toString();
    }));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Movie Advisor')),
      body: Center(
        child: Text(text),
      ),
    );
}
