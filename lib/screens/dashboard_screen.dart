import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:uas_app/services/api_service.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Movie> movies = [];
  List<MovieTopRated> moviesTopRateds = [];
  List<Movie> filteredMovies = [];
  TextEditingController _searchController = TextEditingController();

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
      filteredMovies = fetchedMovies; // Awalnya diatur ke semua film
    });
  }

  void _searchMovies(String query) {
    setState(() {
      if (query.isEmpty) {
        // Jika query kosong, tampilkan semua film
        filteredMovies = movies;
      } else {
        // Jika query tidak kosong, filter film berdasarkan query
        filteredMovies = movies
            .where((movie) =>
                movie.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(74.0),
        child: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(),
            child: Container(
              width: double.infinity,
              height: 54,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _searchMovies,
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontFamily: "Inter-Regular",
                        fontSize: 15,
                      ),
                      suffixIcon: Icon(
                        FluentIcons.search_12_regular,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _buildMovieList(),
    );
  }

  Widget _buildMovieList() {
    if (filteredMovies.isEmpty) {
      // Jika tidak ada film yang sesuai dengan pencarian, tampilkan teks "Movies not found"
      return Center(
        child: Text(
          'Movies not found',
          style: TextStyle(
            fontFamily: "Poppins-Medium",
            fontSize: 16,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: filteredMovies.length + moviesTopRateds.length + 3,
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
          } else if (index ==
              filteredMovies.length + moviesTopRateds.length + 2) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(
                  'No more movies found',
                  style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: 16,
                  ),
                ),
              ),
            );
          } else {
            if (index - 3 < filteredMovies.length) {
              final Movie movie = filteredMovies[index - 3];
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
            } else {
              return null;
            }
          }
        },
      );
    }
  }
}
