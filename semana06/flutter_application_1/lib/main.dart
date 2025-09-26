import 'package:flutter/material.dart';

void main() {
  runApp(const ScientificCalculatorApp());
}

class ScientificCalculatorApp extends StatelessWidget {
  const ScientificCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Científica 991',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF2196F3),
          background: Color(0xFF1A1A1A),
          surface: Color(0xFF2A2A2A),
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '10';
  String expression = '5 + 5';
  String currentMode = 'NORM';

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        display = '0';
        expression = '';
      } else if (value == '=') {
        // No cambiar nada si ya está mostrando el resultado
        return;
      } else if (value == '⌫') {
        if (display.length > 1) {
          display = display.substring(0, display.length - 1);
        } else {
          display = '0';
        }
      } else if (display == '0' && value != '.') {
        display = value;
      } else {
        if (display.length < 12) {
          display = display == '0' ? value : display + value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '2:30',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.signal_cellular_4_bar,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.wifi, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: const Text(
                          '52',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Modo selector
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  _buildModeButton('NORM', currentMode == 'NORM'),
                  const SizedBox(width: 16),
                  _buildModeButton('MATH', currentMode == 'MATH'),
                  const SizedBox(width: 16),
                  _buildModeButton('FRAC', currentMode == 'FRAC'),
                ],
              ),
            ),

            // Display principal
            Expanded(flex: 3, child: _buildDisplay()),

            // Barra de funciones rápidas
            _buildQuickFunctionBar(),

            // Panel de botones principal
            Expanded(flex: 7, child: _buildMainButtonPanel()),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(String mode, bool isActive) {
    return Text(
      mode,
      style: TextStyle(
        color: isActive ? Colors.white : Colors.grey,
        fontSize: 14,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildDisplay() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8E8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Expresión anterior (solo cuando hay una)
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Text(
              expression.isEmpty ? '' : expression,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Menú de opciones
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),

              // Resultado principal
              Expanded(
                child: Text(
                  display,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickFunctionBar() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickButton('≡', Colors.blue),
          _buildQuickButton('⚬\nPRO', Colors.purple),
          _buildQuickButton('Σ', Colors.grey),
          _buildQuickButton('⚙', Colors.grey),
          _buildQuickButton('%', Colors.grey),
          _buildQuickButton('RAD', Colors.grey, isToggle: true),
          _buildQuickButton('MORE', Colors.grey),
          _buildQuickButton('📷\nSCAN', Colors.black),
        ],
      ),
    );
  }

  Widget _buildQuickButton(String label, Color color, {bool isToggle = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: isToggle ? Border.all(color: color, width: 1) : null,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: label.contains('\n') ? 9 : 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildMainButtonPanel() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          // Fila 1: SHIFT, ALPHA, navegación, MODE, 2nd
          _buildButtonRow([
            ButtonData('SHIFT', ButtonStyle.yellow, flex: 2),
            ButtonData('ALPHA', ButtonStyle.purple, flex: 2),
            ButtonData('◀', ButtonStyle.dark),
            ButtonData('▶', ButtonStyle.dark),
            ButtonData('MODE', ButtonStyle.dark),
            ButtonData('2nd', ButtonStyle.dark),
          ]),

          // Fila 2: Funciones científicas principales
          _buildButtonRow([
            ButtonData('Sin', ButtonStyle.dark),
            ButtonData('Cos', ButtonStyle.dark),
            ButtonData('Tan', ButtonStyle.dark),
            ButtonData('Log', ButtonStyle.dark),
            ButtonData('Ln', ButtonStyle.dark),
            ButtonData('√x', ButtonStyle.dark),
          ]),

          // Fila 3: Más funciones
          _buildButtonRow([
            ButtonData('x²', ButtonStyle.dark),
            ButtonData('x³', ButtonStyle.dark),
            ButtonData('xʸ', ButtonStyle.dark),
            ButtonData('10ˣ', ButtonStyle.dark),
            ButtonData('eˣ', ButtonStyle.dark),
            ButtonData('x⁻¹', ButtonStyle.dark),
          ]),

          // Fila 4: Paréntesis y constantes
          _buildButtonRow([
            ButtonData('(', ButtonStyle.dark),
            ButtonData(')', ButtonStyle.dark),
            ButtonData('π', ButtonStyle.dark),
            ButtonData('e', ButtonStyle.dark),
            ButtonData('Ans', ButtonStyle.dark),
            ButtonData('ENG', ButtonStyle.dark),
          ]),

          // Fila 5: Números 7, 8, 9 y operaciones
          _buildButtonRow([
            ButtonData('7', ButtonStyle.number),
            ButtonData('8', ButtonStyle.number),
            ButtonData('9', ButtonStyle.number),
            ButtonData('⌫', ButtonStyle.orange),
            ButtonData('AC', ButtonStyle.orange),
          ]),

          // Fila 6: Números 4, 5, 6 y operaciones
          _buildButtonRow([
            ButtonData('4', ButtonStyle.number),
            ButtonData('5', ButtonStyle.number),
            ButtonData('6', ButtonStyle.number),
            ButtonData('×', ButtonStyle.operator),
            ButtonData('÷', ButtonStyle.operator),
          ]),

          // Fila 7: Números 1, 2, 3 y operaciones
          _buildButtonRow([
            ButtonData('1', ButtonStyle.number),
            ButtonData('2', ButtonStyle.number),
            ButtonData('3', ButtonStyle.number),
            ButtonData('+', ButtonStyle.operator),
            ButtonData('−', ButtonStyle.operator),
          ]),

          // Fila 8: Números 0, punto, Exp, Ans, =
          _buildButtonRow([
            ButtonData('0', ButtonStyle.number),
            ButtonData('.', ButtonStyle.number),
            ButtonData('Exp', ButtonStyle.dark),
            ButtonData('(−)', ButtonStyle.dark),
            ButtonData('=', ButtonStyle.orange),
          ]),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<ButtonData> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) {
          return Expanded(
            flex: button.flex,
            child: Container(
              margin: const EdgeInsets.all(1),
              child: _buildButton(button),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButton(ButtonData button) {
    Color backgroundColor;
    Color textColor;

    switch (button.style) {
      case ButtonStyle.number:
        backgroundColor = const Color(0xFF2A2A2A);
        textColor = Colors.white;
        break;
      case ButtonStyle.operator:
        backgroundColor = const Color(0xFF2A2A2A);
        textColor = Colors.white;
        break;
      case ButtonStyle.orange:
        backgroundColor = const Color(0xFFFF8C00);
        textColor = Colors.white;
        break;
      case ButtonStyle.yellow:
        backgroundColor = const Color(0xFFFFB000);
        textColor = Colors.black;
        break;
      case ButtonStyle.purple:
        backgroundColor = const Color(0xFF6A4C93);
        textColor = Colors.white;
        break;
      case ButtonStyle.dark:
        backgroundColor = const Color(0xFF404040);
        textColor = Colors.white;
        break;
      case ButtonStyle.darkSmall:
        backgroundColor = const Color(0xFF404040);
        textColor = Colors.white;
        break;
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(
        onTap: () => _buttonPressed(button.label),
        borderRadius: BorderRadius.circular(6),
        // ignore: sized_box_for_whitespace
        child: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (button.textBelow != null)
                Text(
                  button.textBelow!,
                  style: TextStyle(
                    color: button.style == ButtonStyle.darkSmall
                        ? Colors.amber
                        : textColor.withOpacity(0.7),
                    fontSize: 8,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              Text(
                button.label,
                style: TextStyle(
                  color: textColor,
                  fontSize: button.style == ButtonStyle.darkSmall ? 10 : 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonData {
  final String label;
  final ButtonStyle style;
  final String? textBelow;
  final int flex;

  ButtonData(this.label, this.style, {this.textBelow, this.flex = 1});
}

enum ButtonStyle { number, operator, orange, yellow, purple, dark, darkSmall }
