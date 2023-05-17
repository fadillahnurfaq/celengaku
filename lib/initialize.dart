import 'package:celenganku/models/saving_model.dart';
import 'package:celenganku/models/wish_model.dart';
import 'package:celenganku/my_bloc_observer.dart';
import 'package:celenganku/services/local_storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  Bloc.observer = MyBlocObserver();

  await Hive.initFlutter();
  Hive.registerAdapter(WishModelAdapter());
  Hive.registerAdapter(SavingPlanAdapter());
  Hive.registerAdapter(SavingModelAdapter());

  box = await Hive.openBox(LocalStorageApi.keyName);
}
