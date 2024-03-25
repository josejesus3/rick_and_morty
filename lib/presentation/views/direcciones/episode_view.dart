import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';
import 'package:rick_and_morty/presentation/widget/widget.dart';


class EpisodeView extends ConsumerStatefulWidget {
  static const name = 'episodeScreen';
  const EpisodeView({super.key});

  @override
  EpisodeScreenState createState() => EpisodeScreenState();
}

class EpisodeScreenState extends ConsumerState<EpisodeView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    ref.read(rickMortyProvider.notifier).loadNextPage();
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
