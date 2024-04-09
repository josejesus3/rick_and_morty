import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/infrastructure/models/episode.dart';
import 'package:rick_and_morty/presentation/provider/episode_provider.dart';
import 'package:rick_and_morty/presentation/provider/character_id_provider.dart';

class CharacterScreen extends ConsumerStatefulWidget {
  final String characterId;
  final List<String> personaje;
  const CharacterScreen({
    super.key,
    required this.characterId,
    required this.personaje,
  });

  @override
  CharacterScreenState createState() => CharacterScreenState();
}

class CharacterScreenState extends ConsumerState<CharacterScreen> {
  List<Episode> episodes = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    ref.read(characterInfoProvider.notifier).loadChart(widget.characterId);
    ref.read(episodeProvider.notifier).loadEpisode(widget.characterId);
  }

  @override
  void dispose() {
    super.dispose();
    episodes = [];
  }

  @override
  Widget build(BuildContext context) {
    final RickMorty? rickMorty =
        ref.watch(characterInfoProvider)[widget.characterId];
    final List<Episode> episode = ref.watch(episodeProvider);

    if (rickMorty == null || episode.isEmpty) {
      return const Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.blue,
          ),
        ),
      );
    }
    episodes = episode;

    return Scaffold(
      backgroundColor: Colors.white10,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            rickMorty: rickMorty,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => CharacterView(
                rickMorty: rickMorty,
                episode: episodes,
                isLoading: isLoading,
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}

class CharacterView extends StatelessWidget {
  final RickMorty rickMorty;
  final List<Episode> episode;
  final bool isLoading;

  const CharacterView({
    super.key,
    required this.rickMorty,
    required this.episode,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          width: 20,
        ),
        Wrap(
          children: [
            _Contenedor(
              rickMorty: rickMorty,
              textStyle: textStyle,
              data: rickMorty.gender,
            ),
            _Contenedor(
              rickMorty: rickMorty,
              textStyle: textStyle,
              data: rickMorty.status,
            ),
            _Contenedor(
              rickMorty: rickMorty,
              textStyle: textStyle,
              data: rickMorty.species,
            ),
          ],
        ),
        ...episode.map(
          (list) => SizedBox(
            height: 100,
            child: ListTile(
              textColor: Colors.white,
              leading: Text(list.episode),
              title: Text(
                list.name,
              ),
              trailing: Text(
                list.created.substring(0, 10),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final RickMorty rickMorty;
  const _CustomSliverAppBar({
    required this.rickMorty,
  });

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight:
          sized.height > 800 ? sized.height * 0.6 : sized.height * 0.4,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 10, right: 20, bottom: 20),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                rickMorty.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0, 0.2],
                    colors: [Colors.black87, Colors.transparent],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 30,
                child: Text(
                  rickMorty.name,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}

class _Contenedor extends StatelessWidget {
  final RickMorty rickMorty;
  final TextTheme textStyle;
  final String data;
  const _Contenedor({
    required this.rickMorty,
    required this.textStyle,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 80,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(data, style: const TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
