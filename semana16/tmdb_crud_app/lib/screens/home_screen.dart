import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../models/movie.dart';
import 'movie_detail_screen.dart';
import 'favorites_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<MovieProvider>(context, listen: false);
      provider.loadPopularMovies();
      provider.loadNowPlayingMovies();
      provider.loadTopRatedMovies();
      provider.loadFavorites();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0C14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0C14),
        elevation: 0,
        title: const Text(
          'PELÍCULAS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.white, size: 26),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FavoritesScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: const Color(0xFF0B0C14),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF5A4FCF),
              indicatorWeight: 3,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white54,
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
              tabs: const [
                Tab(text: 'Populares'),
                Tab(text: 'En Cartelera'),
                Tab(text: 'Top Rated'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _MovieListTab(movieType: MovieType.popular),
          _MovieListTab(movieType: MovieType.nowPlaying),
          _MovieListTab(movieType: MovieType.topRated),
        ],
      ),
    );
  }
}

enum MovieType { popular, nowPlaying, topRated }

class _MovieListTab extends StatelessWidget {
  final MovieType movieType;

  const _MovieListTab({required this.movieType});

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(provider.errorMessage),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    switch (movieType) {
                      case MovieType.popular:
                        provider.loadPopularMovies();
                        break;
                      case MovieType.nowPlaying:
                        provider.loadNowPlayingMovies();
                        break;
                      case MovieType.topRated:
                        provider.loadTopRatedMovies();
                        break;
                    }
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        List<Movie> movies;
        switch (movieType) {
          case MovieType.popular:
            movies = provider.popularMovies;
            break;
          case MovieType.nowPlaying:
            movies = provider.nowPlayingMovies;
            break;
          case MovieType.topRated:
            movies = provider.topRatedMovies;
            break;
        }

        if (movies.isEmpty) {
          return const Center(child: Text('No hay películas disponibles'));
        }

        return RefreshIndicator(
          onRefresh: () async {
            switch (movieType) {
              case MovieType.popular:
                await provider.loadPopularMovies();
                break;
              case MovieType.nowPlaying:
                await provider.loadNowPlayingMovies();
                break;
              case MovieType.topRated:
                await provider.loadTopRatedMovies();
                break;
            }
          },
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return _MovieCard(movie: movies[index]);
            },
          ),
        );
      },
    );
  }
}

class _MovieCard extends StatelessWidget {
  final Movie movie;

  const _MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              movie.posterPath != null
                  ? Image.network(
                      movie.posterUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF1A1B25),
                          child: const Icon(Icons.movie, size: 50, color: Colors.white24),
                        );
                      },
                    )
                  : Container(
                      color: const Color(0xFF1A1B25),
                      child: const Icon(Icons.movie, size: 50, color: Colors.white24),
                    ),
              Positioned(
                top: 4,
                right: 4,
                child: Consumer<MovieProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        movie.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: movie.isFavorite ? Colors.red : Colors.white,
                        size: 16,
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.9),
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFB800), size: 12),
                      const SizedBox(width: 3),
                      Text(
                        movie.voteAverage.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
