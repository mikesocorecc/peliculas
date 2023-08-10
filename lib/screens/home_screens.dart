import 'package:flutter/material.dart';
import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    // print(moviesProvider.popularMovies);

    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Peliculas en cines'),
        actions:  [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: (){
                return  ;
            },
          )
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
        children:    [ 
          CardSwiper( movies: moviesProvider.onDisplayMovies), 
          MovieSlider(
            movies: moviesProvider.popularMovies,
            title: 'Populares',
            onNextPage: ()  => moviesProvider.getPopularMovies(),
          ), 
        ]
      ),
      )
    );
  }
}