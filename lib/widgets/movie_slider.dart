import 'dart:ffi';

import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {
   
  const MovieSlider({
  Key? key, 
  required this.movies, 
  required this.onNextPage,
  this.title, 
  }) : super(key: key);
  final List<Movie> movies;
final String? title;
final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = ScrollController();

   // Poder ejecutar codigo la primera vez cuando el 
  //  Widget es contruido
  @override
  void initState() {
    super.initState();
    
    scrollController.addListener(() { 
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
       widget.onNextPage();
      }
    });
    
  }

  // Cuando el widget va a ser destruido
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      
    return Container(
      width: double.infinity,
      height: 250, 
      child: Column( 
        children:  [
          if(widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(widget.title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller:  scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int index){ 
                final movie = widget.movies[index];
                return   _MoviePoster(movie: movie);
              },
            ),
          )
          
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
  super.key, 
  required this.movie
  });
   final  Movie  movie; 

  @override
  Widget build(BuildContext context) {  
    return Container(
      width: 130,
      height: 190, 
      margin: const EdgeInsets.symmetric(horizontal: 10 ),
      child: Column(
        children:  [
           GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
             child: ClipRRect(
              borderRadius:  BorderRadius.circular(20),
               child:  FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
                       ),
             ),
           ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ]
      ),
    );
  }
}