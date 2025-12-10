class ApiConfig {
  static const String apiKey = '4d7402e457dcb0335d78575851 0cdb75';
  static const String accessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDc0MDJlNDU3ZGNiMDMzNWQ3ODU3NTg1MTBjZGI3NSIsIm5iZiI6MTc1MDI4MDY0MS4zMTgsInN1YiI6IjY4NTMyOWMxMTRkZmI2NjE2ZjMzMTI2MiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ROeVILTdtCrnU69DBtKHUUm_6Mgx0WzN3gOJiy2EOnA';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  
  static Map<String, String> get headers => {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };
}
