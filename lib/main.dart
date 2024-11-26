import 'package:bloc_crud/Home.dart';
import 'package:bloc_crud/bloc/bloc/user_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context)=>UserListBloc())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
       
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
