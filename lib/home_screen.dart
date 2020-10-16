import 'package:flutter/material.dart';
import 'package:movie_advisor/presentation/scenes/movies_list/movies_list_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentBarIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: MoviesListPage(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentBarIndex,
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
          onTap: (index) {
            setState(() {
              _currentBarIndex = index;
            });
          },
          /*
          onTap: (index) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MoviesListPage(),
            ),
          ),
           */
        ),
      );
}
