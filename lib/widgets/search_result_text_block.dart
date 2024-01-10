import 'package:flutter/material.dart';

class SearchResultTextBlock extends StatelessWidget {
  final String label;
  final String value;

  const SearchResultTextBlock(
      {Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 5,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
