import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class FavoritesService {
  static const String _favoritesKey = 'favorites_movies';

  // CREATE: Agregar película a favoritos
  Future<bool> addFavorite(Movie movie) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();
      
      // Verificar si ya existe
      if (favorites.any((m) => m.id == movie.id)) {
        return false;
      }
      
      final movieWithFavorite = movie.copyWith(isFavorite: true);
      favorites.add(movieWithFavorite);
      
      final jsonList = favorites.map((m) => m.toJson()).toList();
      await prefs.setString(_favoritesKey, json.encode(jsonList));
      return true;
    } catch (e) {
      print('Error al agregar favorito: $e');
      return false;
    }
  }

  // READ: Obtener todos los favoritos
  Future<List<Movie>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson == null || favoritesJson.isEmpty) {
        return [];
      }
      
      final List<dynamic> jsonList = json.decode(favoritesJson);
      return jsonList.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      print('Error al obtener favoritos: $e');
      return [];
    }
  }

  // READ: Verificar si una película es favorita
  Future<bool> isFavorite(int movieId) async {
    try {
      final favorites = await getFavorites();
      return favorites.any((movie) => movie.id == movieId);
    } catch (e) {
      print('Error al verificar favorito: $e');
      return false;
    }
  }

  // UPDATE: Actualizar información de un favorito
  Future<bool> updateFavorite(Movie updatedMovie) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();
      
      final index = favorites.indexWhere((m) => m.id == updatedMovie.id);
      if (index == -1) {
        return false;
      }
      
      favorites[index] = updatedMovie.copyWith(isFavorite: true);
      
      final jsonList = favorites.map((m) => m.toJson()).toList();
      await prefs.setString(_favoritesKey, json.encode(jsonList));
      return true;
    } catch (e) {
      print('Error al actualizar favorito: $e');
      return false;
    }
  }

  // DELETE: Eliminar película de favoritos
  Future<bool> removeFavorite(int movieId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favorites = await getFavorites();
      
      favorites.removeWhere((movie) => movie.id == movieId);
      
      final jsonList = favorites.map((m) => m.toJson()).toList();
      await prefs.setString(_favoritesKey, json.encode(jsonList));
      return true;
    } catch (e) {
      print('Error al eliminar favorito: $e');
      return false;
    }
  }

  // DELETE: Limpiar todos los favoritos
  Future<bool> clearAllFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
      return true;
    } catch (e) {
      print('Error al limpiar favoritos: $e');
      return false;
    }
  }

  // Obtener cantidad de favoritos
  Future<int> getFavoritesCount() async {
    final favorites = await getFavorites();
    return favorites.length;
  }
}
