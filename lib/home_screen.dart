import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: MoviesListPage(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Movies',
              icon: Icon(Icons.ondemand_video),
            ),
            BottomNavigationBarItem(
              label: 'Favorites',
              icon: Icon(Icons.star_border),
            ),
          ],
        ),
      );
}
