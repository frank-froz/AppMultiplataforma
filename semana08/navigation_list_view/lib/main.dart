import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF111111),
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: const Color(0xFFF7F7F8),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0.5,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.zero,
      ),
      listTileTheme: const ListTileThemeData(
        tileColor: Colors.transparent,
        horizontalTitleGap: 12,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(fontSize: 14, color: Colors.black87),
        bodySmall: TextStyle(fontSize: 13, color: Colors.black54),
      ),
    );

    return MaterialApp(
      title: 'App Navegación',
      theme: theme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/main': (context) => const MainMenuPage(),
        '/profile': (context) => const ProfilePage(),
        '/tasks': (context) => const TasksPage(),
      },
    );
  }
}

// Pantalla de inicio con título y botón Entrar
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.04),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F0F1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.layers,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bienvenido',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineSmall,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Gestor de tareas',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/main',
                            ),
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF111111),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            child: const Text('Entrar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  String _title = 'Home';

  Widget _buildContent() {
    switch (_title) {
      case 'Profile':
        return const Center(child: Text('Perfil (desde menú)'));
      case 'Tareas':
        return const TasksPage();
      default:
        return _homeContent();
    }
  }

  Widget _homeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.dashboard, color: Colors.black54),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Usuario',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Resumen rápido de tu espacio',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelect(String item) {
    Navigator.pop(context); // cerrar drawer
    if (item == 'Home') {
      setState(() => _title = 'Home');
    } else if (item == 'Profile') {
      Navigator.pushNamed(context, '/profile');
    } else if (item == 'Tareas') {
      Navigator.pushNamed(context, '/tasks');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        surfaceTintColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFF7F7F8),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.04),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person, color: Colors.black54),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Usuario',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'usuario@ejemplo.com',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              _drawerItem(
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () => _onSelect('Home'),
              ),
              _drawerItem(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: () => _onSelect('Profile'),
              ),
              _drawerItem(
                icon: Icons.checklist_rtl,
                label: 'Tareas',
                onTap: () => _onSelect('Tareas'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                  icon: const Icon(Icons.logout),
                  label: const Text('Cerrar sesión'),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: _buildContent()),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black54),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _surnameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      // Mostrar resumen rápido (en app real persistirías los datos)
      final summary = StringBuffer();
      summary.writeln('${_nameCtrl.text} ${_surnameCtrl.text}');
      summary.writeln(_emailCtrl.text);
      summary.writeln(_phoneCtrl.text);
      summary.writeln('Dirección: ${_addressCtrl.text}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil guardado\n${summary.toString()}')),
      );
      Navigator.pop(context);
    }
  }

  Widget _notionField({
    required TextEditingController controller,
    String? label,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xFFF7F7F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de usuario')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información personal',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _notionField(
                                controller: _nameCtrl,
                                label: 'Nombre',
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Ingrese el nombre'
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _notionField(
                                controller: _surnameCtrl,
                                label: 'Apellidos',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _notionField(
                          controller: _emailCtrl,
                          label: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Ingrese el email';
                            }
                            final emailRegex = RegExp(
                              r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}",
                            );
                            if (!emailRegex.hasMatch(v)) {
                              return 'Email inválido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        _notionField(
                          controller: _phoneCtrl,
                          label: 'Teléfono',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        _notionField(
                          controller: _addressCtrl,
                          label: 'Dirección',
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.tonal(
                            onPressed: _save,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.0),
                              child: Text('Guardar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Página de tareas con lista hardcodeada
class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = const [
      {'title': 'Comprar materiales', 'done': false},
      {'title': 'Enviar informe', 'done': true},
      {'title': 'Reunión con el equipo', 'done': false},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Registro de tareas')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = tasks[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.03),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: (item['done'] as bool)
                              ? const Color(0xFFEFF8F1)
                              : const Color(0xFFF0F0F1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          item['done'] as bool
                              ? Icons.check
                              : Icons.circle_outlined,
                          color: (item['done'] as bool)
                              ? Colors.green
                              : Colors.black26,
                          size: 18,
                        ),
                      ),
                      title: Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        (item['done'] as bool) ? 'Completada' : 'Pendiente',
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
