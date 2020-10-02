import 'package:flutter/material.dart';

class MoviesListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(10),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w200/uC6TTUhPpQCmgldGyYveKRAu8JN.jpg',
                  errorBuilder: (_, __, ___) => const Text('😢'),
                ),
              ),
            ),
            const Text('title')
          ],
        ),
      );
}
