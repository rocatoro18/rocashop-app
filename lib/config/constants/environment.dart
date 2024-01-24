import 'package:flutter_dotenv/flutter_dotenv.dart';

// PATRON ADAPTADOR (WRAPPER) - SOLO AQUI ESTA LA REFERENCIA AL PAQUETE DOTENV
class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl =
      dotenv.env['API_URL'] ?? 'No está configurado el API_URL';
}
