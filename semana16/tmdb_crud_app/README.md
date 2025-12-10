# TMDB Movies App 🎬

Aplicación Flutter con diseño HBO Max que consume la API de TMDB e implementa CRUD de favoritos.

## CRUD de Favoritos 📝

| Operación | Acción | Ubicación |
|-----------|--------|-----------|
| **CREATE** | Agregar a favoritos | Toca ❤️ en cualquier película |
| **READ** | Ver favoritos | Ícono ❤️ en AppBar |
| **UPDATE** | Cambiar estado | Toggle del corazón |
| **DELETE** | Eliminar | Botón 🗑️ en favoritos |

**Almacenamiento:** SharedPreferences (local, persistente)

## Instalación 🚀

```bash
cd tmdb_crud_app
flutter pub get
flutter run
```

## Tecnologías

- **Flutter** + Provider (estado)
- **HTTP** (API TMDB)
- **SharedPreferences** (CRUD local)
- **Material Design 3** (tema oscuro estilo HBO)

## Estructura

```
lib/
├── services/
│   ├── tmdb_service.dart        # API TMDB (READ only)
│   └── favorites_service.dart   # CRUD Favoritos
├── providers/
│   └── movie_provider.dart      # Estado global
└── screens/
    ├── home_screen.dart         # 3 tabs: Popular, Cartelera, Top
    ├── search_screen.dart       # Búsqueda
    ├── favorites_screen.dart    # Lista CRUD
    └── movie_detail_screen.dart # Detalles
```

## API Endpoints

- `/movie/popular` - Populares
- `/movie/now_playing` - En cartelera
- `/movie/top_rated` - Mejor valoradas
- `/search/movie` - Búsqueda

**Token configurado en:** `lib/config/api_config.dart`

---

Desarrollado con ❤️ usando Flutter

