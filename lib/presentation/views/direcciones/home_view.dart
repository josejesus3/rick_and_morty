import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';
import 'package:rick_and_morty/presentation/widget/widget.dart';

class HomeView extends ConsumerStatefulWidget {
  static const name = 'homeScreen';
  const HomeView({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    ref.read(rickMortyProvider.notifier).loadNextPage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rickMortyapi = ref.watch(rickMortyProvider);

    return Scaffold(
      backgroundColor: Colors.white10,
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const CustomAppBar(),
          RickMortyListView(
            rickMorty: rickMortyapi,
            loadNextPage: () {
              ref.read(rickMortyProvider.notifier).loadNextPage();
            },
          )
        ],
      ),
    );
  }
}
