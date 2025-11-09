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
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          controller: controller,
          hintText: 'Search food items',
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          onTap: () {
            controller.openView();
          },
          onChanged: (String value) {
            controller.openView();
            widget.onSearch(value);
          },
          leading: const Icon(Icons.search),
          trailing: <Widget>[
        

            IconButton( onPressed: (){
              controller.clear();
              widget.onSearch('');
              try{
                controller.text='';
              }catch(_){
               setState(() {});
              }
              
            }, icon:const Icon(Icons.clear)),


            Tooltip(
              message: 'Change theme',
              child: IconButton(
                isSelected: widget.isDark,
                onPressed: () {
                  widget.onThemeToggle(!widget.isDark);
                },
                icon: const Icon(Icons.wb_sunny_outlined),
                selectedIcon: const Icon(Icons.brightness_2_outlined),
              ),
            ),
          ],
        );
      },

      suggestionsBuilder: (BuildContext context, SearchController controller) {
        // Use the controller's current text for live suggestions to avoid any timing issues
        final query = controller.text.trim().toLowerCase();

        // Only show suggestions when user has typed something
        if (query.isEmpty) {
          return const <Widget>[];
        }

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

        //Limit visible suggestions to 5 items

        // Show live suggestions
        return matches.map((f) {
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
              // When tapped, fill the search bar (via the provided controller) and update parent UI
              controller.closeView(title);
              controller.text = title;
              widget.onSearch(title);
            },
          );
        });
      },
    );
  }
}
