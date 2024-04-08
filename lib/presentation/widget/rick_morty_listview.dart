import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/domain/entities/rick_morty.dart';

class RickMortyListView extends StatefulWidget {
  final List<RickMorty> rickMorty;
  final String? name;
  final String? species;
  final VoidCallback? loadNextPage;

  const RickMortyListView(
      {super.key,
      required this.rickMorty,
      this.name,
      this.species,
      this.loadNextPage});

  @override
  State<RickMortyListView> createState() => _RickMortyListViewState();
}

class _RickMortyListViewState extends State<RickMortyListView> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return Expanded(
      child: ListView.builder(
        itemCount: widget.rickMorty.length,
        controller: scrollController,
        itemBuilder: (context, index) {
          final rickMorty = widget.rickMorty[index];
          return GestureDetector(
            onTap: ()=>context.push('/character/${rickMorty.id}'),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.white24,
                  height: sized.height >=400?sized.height*0.18:sized.height*0.4,
                  child: Row(
                    children: [
                      Image.network(
                        rickMorty.image,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress != null) {
                            return FadeInLeft(
                              child: Container(
                                width: 150,
                                height: 150,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Colors.transparent, Colors.white54],
                                  ),
                                ),
                              ),
                            );
                          }
                          return FadeInLeft(child: child);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(child: _Text(rickMorty: rickMorty))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    required this.rickMorty,
  });

  final RickMorty rickMorty;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.copyWith(
        titleLarge: const TextStyle(color: Colors.white, fontSize: 20),
        titleMedium: const TextStyle(color: Colors.white, fontSize: 14));

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
          'Última ubicación conocida:',
          style: TextStyle(
            color: Colors.white38,
          ),
        ),
        Text(
          rickMorty.location.name,
          style: textStyle.titleMedium,
          maxLines: 2,
        ),
      ],
    );
  }
}
