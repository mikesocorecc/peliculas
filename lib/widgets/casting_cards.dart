import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../providers/movies_provider.dart';

class CastingCards extends StatelessWidget {
   
  final int movieId;
  const CastingCards({
    Key? key,
    required this.movieId
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

      return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId), 
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if(!snapshot.hasData){ 
             return Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }

        final List<Cast> cast = snapshot.data!;

         return  Container(
            margin: const EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180, 
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
             itemBuilder: (_, int index) => _CastCard(actor: cast[index]) 
            ),
          );
        },
      );
     
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({
    super.key, 
    required this.actor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100, 
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(actor.fullProfilePath),
            height: 140,
            width: 100,
            fit: BoxFit.cover,
            )
            ),
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,

            ),
      ]),
    );
  }
}