import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';
import 'package:rick_and_morty/presentation/widget/widget.dart';

class LocationView extends ConsumerStatefulWidget {
  static const name = 'locationScreen';
  const LocationView({super.key});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends ConsumerState<LocationView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    ref.read(rickMortyProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final rickMortyapi = ref.watch(rickMortyProvider);
    final index = ref.watch(rickMortyBotton);
    const iconSized = 35.0;

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
