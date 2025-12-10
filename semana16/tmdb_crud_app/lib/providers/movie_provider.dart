import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../services/favorites_service.dart';

class MovieProvider with ChangeNotifier {
  final TmdbService _tmdbService = TmdbService();
  final FavoritesService _favoritesService = FavoritesService();

  List<Movie> _popularMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _searchResults = [];
  List<Movie> _favoriteMovies = [];
  
  bool _isLoading = false;
  String _errorMessage = '';
  
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get searchResults => _searchResults;
  List<Movie> get favoriteMovies => _favoriteMovies;
  
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Cargar películas populares
  Future<void> loadPopularMovies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _popularMovies = await _tmdbService.getPopularMovies();
      await _updateFavoriteStatus(_popularMovies);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cargar películas en cartelera
  Future<void> loadNowPlayingMovies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _nowPlayingMovies = await _tmdbService.getNowPlayingMovies();
      await _updateFavoriteStatus(_nowPlayingMovies);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cargar películas mejor valoradas
  Future<void> loadTopRatedMovies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _topRatedMovies = await _tmdbService.getTopRatedMovies();
      await _updateFavoriteStatus(_topRatedMovies);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Buscar películas
  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _searchResults = await _tmdbService.searchMovies(query);
      await _updateFavoriteStatus(_searchResults);
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cargar favoritos
  Future<void> loadFavorites() async {
    try {
      _favoriteMovies = await _favoritesService.getFavorites();
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
    }
  }

  // Agregar a favoritos (CREATE)
  Future<bool> addToFavorites(Movie movie) async {
    final success = await _favoritesService.addFavorite(movie);
    if (success) {
      await loadFavorites();
      _updateMovieFavoriteStatus(movie.id, true);
      notifyListeners();
    }
    return success;
  }

  // Eliminar de favoritos (DELETE)
  Future<bool> removeFromFavorites(int movieId) async {
    final success = await _favoritesService.removeFavorite(movieId);
    if (success) {
      await loadFavorites();
      _updateMovieFavoriteStatus(movieId, false);
      notifyListeners();
    }
    return success;
  }

  // Toggle favorito
  Future<void> toggleFavorite(Movie movie) async {
    final isFav = await _favoritesService.isFavorite(movie.id);
    
    if (isFav) {
      await removeFromFavorites(movie.id);
    } else {
      await addToFavorites(movie);
    }
  }

  // Verificar si es favorito
  Future<bool> isFavorite(int movieId) async {
    return await _favoritesService.isFavorite(movieId);
  }

  // Actualizar estado de favoritos en listas
  Future<void> _updateFavoriteStatus(List<Movie> movies) async {
    for (var movie in movies) {
      movie.isFavorite = await _favoritesService.isFavorite(movie.id);
    }
  }

  // Actualizar estado de favorito de una película específica
  void _updateMovieFavoriteStatus(int movieId, bool isFavorite) {
    for (var movie in _popularMovies) {
      if (movie.id == movieId) movie.isFavorite = isFavorite;
    }
    for (var movie in _nowPlayingMovies) {
      if (movie.id == movieId) movie.isFavorite = isFavorite;
    }
    for (var movie in _topRatedMovies) {
      if (movie.id == movieId) movie.isFavorite = isFavorite;
    }
    for (var movie in _searchResults) {
      if (movie.id == movieId) movie.isFavorite = isFavorite;
    }
  }

  // Limpiar búsqueda
  void clearSearch() {
    _searchResults = [];
    notifyListeners();
  }
}
