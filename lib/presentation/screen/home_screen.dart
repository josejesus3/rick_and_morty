import 'package:flutter/material.dart';
import 'package:rick_and_morty/presentation/screen/screen.dart';
import 'package:rick_and_morty/presentation/views/direcciones/home_view.dart';
import 'package:rick_and_morty/presentation/widget/widget.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final List<Widget> viewRouter = const [
    HomeView(),
    EpisodeView(),
    LocationView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      bottomNavigationBar: BottonNavigation(index: pageIndex, iconSized: 30),
      body: IndexedStack(
        index: pageIndex,
        children: viewRouter,
      ),
    );
  }
}
