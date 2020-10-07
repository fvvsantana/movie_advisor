import 'package:flutter/material.dart';
import 'package:movie_advisor/screens/movie_details_page.dart';
import 'package:movie_advisor/widgets/image_from_network.dart';

class MoviesListItem extends StatelessWidget {
  const MoviesListItem({this.id, this.title, this.imageUrl});

  final int id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MovieDetailsPage(),
            settings: RouteSettings(arguments: id))),
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: 60,
                padding: const EdgeInsets.all(10),
                child: ImageFromNetwork(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Text(title),
            ],
          ),
        ),
      );
}
