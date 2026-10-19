import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/home/presentation/providers/home_controller.dart';

export 'home_controller.dart';

final homeControllerProvider = NotifierProvider<HomeController, HomeState>(
  HomeController.new,
);
