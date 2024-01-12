import 'package:flutter/material.dart';
import 'package:uas_app/services/api_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<MovieTrending> movieTrendings = [];
  List<MovieTopRated> moviesTopRateds = [];
  List<MovieUpComing> moviesUpComings = [];

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    final ApiService apiService = ApiService();
    final List<MovieTrending> fetchedMovieTrendings =
        await apiService.getMoviesTrending();
    final List<MovieTopRated> fetchedMoviesTopRated =
        await apiService.getMoviesTopRated();
    final List<MovieUpComing> fetchedMoviesUpComing =
        await apiService.getMoviesUpComing();
    setState(() {
      movieTrendings = fetchedMovieTrendings;
      moviesTopRateds = fetchedMoviesTopRated;
      moviesUpComings = fetchedMoviesUpComing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        title: Center(
            child: Text(
          "Explore",
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: 18,
            color: Colors.black,
          ),
        )),
      ),
      body: ListView.builder(
        itemCount: movieTrendings.length +
            moviesTopRateds.length +
            moviesUpComings.length +
            2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Trending",
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
                    for (MovieTrending moviTrending in movieTrendings)
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 300,
                          height: 160,
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
                                  'https://image.tmdb.org/t/p/w185${moviTrending.posterPath}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, top: 90, right: 24),
                                  child: Text(
                                    moviTrending.title,
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
          } else if (index == 3) {
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
                          height: 160,
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
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, top: 90, right: 24),
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
          } else if (index == 4) {
            // Item pertama, tambahkan teks "Popular"
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Text(
                "Upcoming",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 16,
                ),
              ),
            );
          } else if (index == 5) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (MovieUpComing movieUpComing in moviesUpComings)
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 300,
                          height: 160,
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
                                  'https://image.tmdb.org/t/p/w185${movieUpComing.posterPath}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24, top: 90, right: 24),
                                  child: Text(
                                    movieUpComing.title,
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
          }
          return null;
        },
      ),
    );
  }
}
