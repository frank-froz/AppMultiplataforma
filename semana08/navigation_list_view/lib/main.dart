import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'App Navegación',
      theme: const CupertinoThemeData(
        primaryColor: CupertinoColors.black,
        scaffoldBackgroundColor: Color(0xFFF2F2F7),
        barBackgroundColor: Color(0xFFFAFAFA),
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(fontSize: 17, color: CupertinoColors.black),
          navTitleTextStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: CupertinoColors.black,
          ),
        ),
      ),
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
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      child: SafeArea(
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
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x0A000000),
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
                                CupertinoIcons.layers_alt,
                                color: CupertinoColors.systemGrey,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bienvenido',
                                    style: CupertinoTheme.of(context)
                                        .textTheme
                                        .navTitleTextStyle
                                        .copyWith(fontSize: 20),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Gestor de tareas',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: CupertinoColors.systemGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton.filled(
                            onPressed: () => Navigator.pushReplacementNamed(
                              context,
                              '/main',
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
  int _selectedIndex = 0;

  final List<String> _titles = ['Home', 'Profile', 'Tareas'];

  void _showLogoutDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext dialogContext) => CupertinoAlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas salir?'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(dialogContext),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Salir'),
            onPressed: () {
              Navigator.pop(dialogContext); // Cierra el diálogo
              // Navega hasta la raíz y reemplaza con StartPage
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 1:
        return const ProfilePage();
      case 2:
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
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: const Color(0x08000000), blurRadius: 8),
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
                      child: const Icon(
                        CupertinoIcons.square_grid_2x2,
                        color: CupertinoColors.systemGrey,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hola, Usuario',
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navTitleTextStyle
                                .copyWith(fontSize: 20),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Resumen rápido de tu espacio',
                            style: TextStyle(
                              fontSize: 13,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.check_mark_circled),
            label: 'Tareas',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(_titles[_selectedIndex]),
                trailing: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.square_arrow_right),
                  onPressed: () => _showLogoutDialog(context),
                ),
              ),
              child: SafeArea(child: _buildContent()),
            );
          },
        );
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameCtrl = TextEditingController();
  final _surnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  DateTime _birthDate = DateTime(2000, 1, 1);

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
    // Mostrar resumen rápido (en app real persistirías los datos)
    final summary = StringBuffer();
    summary.writeln('${_nameCtrl.text} ${_surnameCtrl.text}');
    summary.writeln(_emailCtrl.text);
    summary.writeln(_phoneCtrl.text);
    summary.writeln('Dirección: ${_addressCtrl.text}');
    summary.writeln(
      'Fecha de nacimiento: ${_birthDate.day}/${_birthDate.month}/${_birthDate.year}',
    );

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Perfil guardado'),
        content: Text(summary.toString()),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.white,
        child: Column(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.systemGrey4,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancelar'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('Listo'),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(
                      color: CupertinoColors.black,
                      fontSize: 22,
                    ),
                  ),
                ),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: _birthDate,
                  maximumDate: DateTime.now(),
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() => _birthDate = newDate);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cupertinoField({
    required TextEditingController controller,
    String? placeholder,
    TextInputType? keyboardType,
  }) {
    return CupertinoTextField(
      controller: controller,
      placeholder: placeholder,
      keyboardType: keyboardType,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      style: const TextStyle(color: CupertinoColors.black, fontSize: 17),
      placeholderStyle: const TextStyle(
        color: CupertinoColors.systemGrey,
        fontSize: 17,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _dateField() {
    return GestureDetector(
      onTap: _showDatePicker,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_birthDate.day}/${_birthDate.month}/${_birthDate.year}',
              style: const TextStyle(
                fontSize: 17,
                color: CupertinoColors.black,
              ),
            ),
            const Icon(
              CupertinoIcons.calendar,
              color: CupertinoColors.systemGrey,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Registro de Usuario',
              style: TextStyle(color: CupertinoColors.black),
            ),
            backgroundColor: Color(0xFFFAFAFA),
            border: Border(
              bottom: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x0A000000),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información personal',
                          style: CupertinoTheme.of(
                            context,
                          ).textTheme.navTitleTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: _cupertinoField(
                                controller: _nameCtrl,
                                placeholder: 'Nombre',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _cupertinoField(
                                controller: _surnameCtrl,
                                placeholder: 'Apellidos',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _cupertinoField(
                          controller: _emailCtrl,
                          placeholder: 'Email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _cupertinoField(
                          controller: _phoneCtrl,
                          placeholder: 'Teléfono',
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        _cupertinoField(
                          controller: _addressCtrl,
                          placeholder: 'Dirección',
                        ),
                        const SizedBox(height: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                                bottom: 6,
                              ),
                              child: Text(
                                'Fecha de nacimiento',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: CupertinoColors.systemGrey,
                                ),
                              ),
                            ),
                            _dateField(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton.filled(
                            onPressed: _save,
                            child: const Text('Guardar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
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
      {'title': 'Comprar materiales', 'done': false},
      {'title': 'Enviar informe', 'done': true},
      {'title': 'Reunión con el equipo', 'done': false},
      {'title': 'Comprar materiales', 'done': false},
      {'title': 'Enviar informe', 'done': true},
      {'title': 'Reunión con el equipo', 'done': false},
      {'title': 'Comprar materiales', 'done': false},
      {'title': 'Enviar informe', 'done': true},
      {'title': 'Reunión con el equipo', 'done': false},
    ];

    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              'Mis Tareas',
              style: TextStyle(color: CupertinoColors.black),
            ),
            backgroundColor: Color(0xFFFAFAFA),
            border: Border(
              bottom: BorderSide(color: Color(0xFFE5E5EA), width: 0.5),
            ),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = tasks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onLongPress: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext popupContext) =>
                              CupertinoActionSheet(
                                title: Text(item['title'] as String),
                                message: const Text('¿Qué deseas hacer?'),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(popupContext);
                                      // Aquí iría la lógica de editar
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.pencil, size: 20),
                                        SizedBox(width: 8),
                                        Text('Editar'),
                                      ],
                                    ),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(popupContext);
                                      // Aquí iría la lógica de marcar como completada
                                    },
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          CupertinoIcons.check_mark_circled,
                                          size: 20,
                                        ),
                                        SizedBox(width: 8),
                                        Text('Marcar como completada'),
                                      ],
                                    ),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Navigator.pop(popupContext);
                                      // Aquí iría la lógica de eliminar
                                    },
                                    isDestructiveAction: true,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(CupertinoIcons.delete, size: 20),
                                        SizedBox(width: 8),
                                        Text('Eliminar'),
                                      ],
                                    ),
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  onPressed: () => Navigator.pop(popupContext),
                                  child: const Text('Cancelar'),
                                ),
                              ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x08000000),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              Container(
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
                                      ? CupertinoIcons.check_mark
                                      : CupertinoIcons.circle,
                                  color: (item['done'] as bool)
                                      ? CupertinoColors.systemGreen
                                      : CupertinoColors.systemGrey2,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      (item['done'] as bool)
                                          ? 'Completada'
                                          : 'Pendiente',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: CupertinoColors.systemGrey,
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
                  );
                }, childCount: tasks.length),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
