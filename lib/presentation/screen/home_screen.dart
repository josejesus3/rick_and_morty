import 'package:flutter/material.dart';

import 'package:rick_and_morty/presentation/views/home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.white10, body: HomeView());
  }
}
