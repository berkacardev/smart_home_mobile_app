import 'di.dart';

abstract class StarterInitializer {
  static Future<void> initialize() async {
    DependencyInjection.initializeDependencies();
  }
}