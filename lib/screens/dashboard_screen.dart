import 'package:flutter/material.dart';
import 'package:uas_app/services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Movie> movies = [];
  List<MovieTopRated> moviesTopRateds = [];
  List<Movie> searchResults = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final ApiService apiService = ApiService();
    final List<Movie> fetchedMovies = await apiService.getMovies();
    final List<MovieTopRated> fetchedMoviesTopRated =
        await apiService.getMoviesTopRated();
    setState(() {
      movies = fetchedMovies;
      moviesTopRateds = fetchedMoviesTopRated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: ListView.builder(
        itemCount: movies.length +
            moviesTopRateds.length +
            2, // Jumlah item + 1 untuk "Popular"
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Top Rated",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 16,
                ),
              ),
            );
          } else if (index == 1) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (MovieTopRated movieTopRated in moviesTopRateds)
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 300,
                          height: 129,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.10),
                                spreadRadius: 0,
                                blurRadius: 20,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w185${movieTopRated.posterPath}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black45,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, top: 65, right: 24),
                                  child: Text(
                                    movieTopRated.title,
                                    style: TextStyle(
                                      fontFamily: "Poppins-SemiBold",
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            );
          } else if (index == 2) {
            // Item pertama, tambahkan teks "Popular"
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Popular",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 16,
                ),
              ),
            );
          } else {
            // Item ke-2 dan seterusnya, tampilkan daftar film
            final Movie movie = movies[index - 1];
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.10),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: 400,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            movie.title,
                            style: TextStyle(
                              fontFamily: "Poppins-SemiBold",
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            movie.releaseDate,
                            style: TextStyle(
                              fontFamily: "Inter-Regular",
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
