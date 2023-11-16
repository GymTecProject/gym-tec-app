import 'package:flutter/material.dart';
import 'package:gym_tec/components/ui/buttons/action_btn.dart';
import 'package:gym_tec/components/ui/separators/context_separator.dart';
import 'package:pinput/pinput.dart';

class pinInput extends StatefulWidget {
  final String pin;

  const pinInput({super.key,
    required this.pin});

  @override
  State<pinInput> createState() => _pinInput();
}

class _pinInput extends State<pinInput> {
  final TextEditingController _pinController = TextEditingController();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 70,
      textStyle: TextStyle(fontSize: 30, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );


    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmación del reto',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      body: Center( // Centro todo el contenido de la página
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente en el Column
          crossAxisAlignment: CrossAxisAlignment.center, // Centrar horizontalmente en el Column
          children: [
            const Text(
              'Verificación',
              textAlign: TextAlign.center, // Centrar el texto en su contenedor
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            ContextSeparator(),
            const Text(
              'Ingrese el PIN para validar que el reto se cumplió',
              textAlign: TextAlign.center, // Centrar el texto en su contenedor
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            ContextSeparator(),
            Pinput(
              controller: _pinController,
              length: 4,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  border: Border.all(color: Color.fromRGBO(114, 178, 242, 1)),
                ),
              ),
              submittedPinTheme: defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration!.copyWith(
                  color: Color.fromRGBO(234, 239, 243, 1),
                ),
              ),
              pinAnimationType: PinAnimationType.fade,
              // onCompleted: (pin) => print(pin), // Descomenta esto si necesitas el valor del pin
            ),
            const ContextSeparator(),
            const ContextSeparator(),
            ActionBtn(title: "Validar Reto", onPressed: (){
              String pinValue = _pinController.text;
                // Aquí puedes hacer lo que necesites con el valor del PIN
              print(pinValue); // Por ejemplo, imprimirlo en la consola
              if (widget.pin == pinValue){
                Navigator.pop(context, 'Reto validado exitosamente');
              }
              else{
                Navigator.pop(context, 'El PIN suministrado es incorrecto');
              }
            }, fontWeight: FontWeight.bold,)
          ],
        ),
      ),
    );
  }         
}