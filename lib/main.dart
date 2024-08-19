import 'package:bloc_curd/bloc/user_list_bloc.dart';
import 'package:bloc_curd/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => UserListBloc())],
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
