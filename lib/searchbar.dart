import 'package:flutter/material.dart';
import 'food_data.dart';

class SearchBarApp extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeToggle;
  final ValueChanged<String> onSearch;

  const SearchBarApp({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
    required this.onSearch,
  });

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          hintText: 'Search food items...',
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),

          onTap: () {
            controller.openView();
          },

          // Called when typing starts or changes
          onChanged: (String value) {
            widget.onSearch(value);
            setState(() {
              _isSearching = value.isNotEmpty;
            });
          },

          // 👇 Leading icon: Search → Back Arrow dynamically
          leading: IconButton(
            icon: Icon(_isSearching ? Icons.arrow_back : Icons.search),
            onPressed: () {
              controller.openView();
              print("search icon is clicked");

              if (_isSearching) {
                // When back button pressed → reset to default state
                print("back icon clicked");
                controller.closeView('');

                controller.text = '';
                widget.onSearch(''); // show all items again
                FocusScope.of(context).unfocus(); // hide keyboard
                setState(() {
                  _isSearching = false;
                });
              }
            },
          ),

          trailing: <Widget>[
            // Clear icon appears only while searching
            if (_isSearching)
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  controller.clear();
                  controller.text = '';
                  widget.onSearch(''); // show all again
                  FocusScope.of(context).unfocus();
                  setState(() {
                    _isSearching = false;
                  });
                },
              ),

            // Theme toggle button
            Tooltip(
              message: 'Change theme',
              child: IconButton(
                icon: Icon(
                  widget.isDark
                      ? Icons.brightness_2_outlined
                      : Icons.wb_sunny_outlined,
                ),
                onPressed: () {
                  widget.onThemeToggle(!widget.isDark);
                },
              ),
            ),
          ],
        );
      },

      // 👇 Suggestions appear dynamically
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final query = controller.text.trim().toLowerCase();

        // No suggestions when empty
        if (query.isEmpty) {
          return const <Widget>[];
        }

        // Filter items by name or description
        final matches = foodItems
            .where(
              (f) =>
                  f['name']!.toLowerCase().contains(query) ||
                  f['description']!.toLowerCase().contains(query),
            )
            .toList();

        if (matches.isEmpty) {
          return [const ListTile(title: Text('No matching results found.'))];
        }

        // Limit to maximum 5 visible items
        final visibleItems = matches.take(5).toList();

        return visibleItems.map((f) {
          final title = f['name']!;
          final subtitle = f['description']!;
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(f['imageUrl']!),
            ),
            title: Text(title),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              // When suggestion tapped
              controller.closeView(title);
              controller.text = title;
              widget.onSearch(title);
              FocusScope.of(context).unfocus();
              setState(() {
                _isSearching = true;
              });
            },
          );
        });
      },
    );
  }
}
