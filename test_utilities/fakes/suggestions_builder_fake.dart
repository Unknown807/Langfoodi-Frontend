import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SuggestionsBuilderFake extends Fake {
  static SuggestionsBuilder createFakeSuggestionsBuilder() {
    return (BuildContext context, SearchController controller) {
      return List<ListTile>.generate(3, (int index) {
        final String item = 'item $index';
        return ListTile(
          title: Text(item),
          onTap: () {},
        );
      });
    };
  }
}