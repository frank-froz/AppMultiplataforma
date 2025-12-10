import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';
import '../models/movie.dart';

class TmdbService {
  // Obtener películas populares
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/popular?page=$page'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar películas populares');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener películas en cartelera
  Future<List<Movie>> getNowPlayingMovies({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/now_playing?page=$page'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar películas en cartelera');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener películas mejor valoradas
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/top_rated?page=$page'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar películas mejor valoradas');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Buscar películas
  Future<List<Movie>> searchMovies(String query, {int page = 1}) async {
    if (query.isEmpty) return [];

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/search/movie?query=${Uri.encodeComponent(query)}&page=$page',
        ),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al buscar películas');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener detalles de una película
  Future<Movie> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/$movieId'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Error al cargar detalles de la película');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  // Obtener películas similares
  Future<List<Movie>> getSimilarMovies(int movieId, {int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.baseUrl}/movie/$movieId/similar?page=$page'),
        headers: ApiConfig.headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar películas similares');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
