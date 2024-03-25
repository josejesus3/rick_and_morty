import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final textTitle = Theme.of(context).textTheme.titleLarge;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Container(
          
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          width: double.infinity,
          height: 50,
          child: Row(
            children: [
               const SizedBox(
                width: 20,
              ),
              const Icon(
                Icons.auto_fix_normal_outlined,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Rick and Morty',
                style: textTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
