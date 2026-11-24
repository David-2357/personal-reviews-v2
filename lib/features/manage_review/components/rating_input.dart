import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:personal_reviews/core/extensions/theme_context.dart';

class RatingInput extends StatefulWidget {
  const RatingInput({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<RatingInput> createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar.builder(
          initialRating: widget.value,
          minRating: 0,
          maxRating: 5,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 60,
          glow: false,
          unratedColor: context.colors.surfaceContainerHighest,
          itemBuilder: (context, _) =>
              Icon(Icons.star_rounded, color: context.colors.primary),
          onRatingUpdate: (value) {
            widget.onChanged(value);
          },
        ),
      ],
    );
  }
}
