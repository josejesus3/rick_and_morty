import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/domain/entities/episode.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';
import 'package:rick_and_morty/presentation/provider/provider.dart';
import 'package:rick_and_morty/presentation/provider/rick_morty_episode_provider.dart';

class CharacterScreen extends ConsumerStatefulWidget {
  final String characterId;
  const CharacterScreen({super.key, required this.characterId});

  @override
  CharacterScreenState createState() => CharacterScreenState();
}

class CharacterScreenState extends ConsumerState<CharacterScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(characterIdProvider.notifier).loadChart(widget.characterId);
    ref.read(episodesIdProvider.notifier).loadEpisode(widget.characterId);
  }

  @override
  Widget build(BuildContext context) {
    final RickMorty? rickMorty =
        ref.watch(characterIdProvider)[widget.characterId];

    final Episodes? episode = ref.watch(episodesIdProvider)[widget.characterId];

    if (rickMorty == null) {
      return const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.blue,
        ),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(
            rickMorty: rickMorty,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _CharacterView(
                rickMorty: rickMorty,
                episode: episode,
              ),
              childCount: 1,
            ),
          )
        ],
      ),
    );
  }
}

class _CharacterView extends StatelessWidget {
  final RickMorty rickMorty;
  final Episodes? episode;
  const _CharacterView({required this.rickMorty, required this.episode});

  @override
  Widget build(BuildContext context) {
    print(episode?.airDate);
    print(episode!.created);
    print(episode!.episode);
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  rickMorty.image,
                  width: size.width * 0.3,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: (size.width - 40) * 0.5,
                child: _Text(
                  rickMorty: rickMorty,
                  textStyle: textStyle,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.35,
          width: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: const Border(bottom: BorderSide(width: 2)),
                  borderRadius: BorderRadius.circular(10)),
              width: size.width * 0,
              child: ListTile(
                leading: Text(
                  episode!.episode,
                  style: textStyle.labelLarge,
                ),
                title: Text(episode!.name,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    style: const TextStyle(overflow: TextOverflow.ellipsis)),
                trailing: Text(
                  episode!.airDate,
                  style: textStyle.labelMedium,
                ),
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
      expandedHeight: sized.height * 0.4,
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
          ],
        ),
      ),
    );
  }
}

class _Text extends StatelessWidget {
  final TextTheme textStyle;
  const _Text({
    required this.rickMorty,
    required this.textStyle,
  });

  final RickMorty rickMorty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(rickMorty.name,
            maxLines: 2,
            style: textStyle
                .titleLarge //const TextStyle(color: Colors.white, fontSize: 20),
            ),
        Row(
          children: [
            rickMorty.status != 'Dead'
                ? const Icon(
                    Icons.circle_sharp,
                    color: Colors.green,
                    size: 10,
                  )
                : const Icon(
                    Icons.circle_sharp,
                    color: Colors.red,
                    size: 10,
                  ),
            Text('  ${rickMorty.status}--${rickMorty.species}',
                style: textStyle.titleMedium),
          ],
        ),
        const Text(
          'Origenes:',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Text(
          rickMorty.origin.name,
          style: textStyle.titleMedium,
          maxLines: 2,
        ),
      ],
    );
  }
}
