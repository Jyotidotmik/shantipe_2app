import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
//--------------------CarouselSliderWidget-------------------------
class CarouselSliderWidget extends StatefulWidget {
  final List<String> images;
  const CarouselSliderWidget({super.key, required this.images});
  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}
class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.images.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = widget.images[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    print('Error loading image: $exception');
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 210,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
              widget.images.asMap().entries.map((entry) {
                final isActive = entry.key == _currentIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isActive ? 12 : 10,
                  height: isActive ? 12 : 10,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? Colors.blue : Colors.grey.shade400),
                );
              }).toList(),
        ),
      ],
    );
  }
}