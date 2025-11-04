import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imr/app/routes/app_routes.dart';
import 'package:imr/data/models/product_model.dart';
import 'package:imr/presentation/controllers/search_controller.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final MySearchController ctrl = Get.find<MySearchController>();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // keep text field in sync if controller.searchQuery is updated elsewhere
    ever<String>(ctrl.searchQuery, (q) {
      if (_textController.text != q) _textController.text = q;
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onSubmitted(String q) {
    ctrl.search(q.trim());
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // Search input
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: 'Search products, categories...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: Obx(() {
                          return ctrl.searchQuery.value.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _textController.clear();
                                    ctrl.searchQuery.value = '';
                                    ctrl.searchResults.clear();
                                  },
                                )
                              : const SizedBox.shrink();
                        }),
                        border: const OutlineInputBorder(),
                      ),
                      onSubmitted: _onSubmitted,
                      onChanged: (v) {
                        // calls search on each change (you can debounce if needed)
                        ctrl.search(v.trim());
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Content area (recent searches OR results)
              Expanded(
                child: Obx(() {
                  // show recent searches when query empty
                  if (ctrl.searchQuery.value.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Recent searches',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (ctrl.recentSearches.isNotEmpty)
                              TextButton(
                                onPressed: ctrl.clearRecentSearches,
                                child: const Text('Clear'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ctrl.recentSearches.isEmpty
                              ? const Center(child: Text('No recent searches'))
                              : ListView.separated(
                                  itemCount: ctrl.recentSearches.length,
                                  separatorBuilder: (_, __) =>
                                      const Divider(height: 1),
                                  itemBuilder: (_, i) {
                                    final text = ctrl.recentSearches[i];
                                    return ListTile(
                                      leading: const Icon(Icons.history),
                                      title: Text(text),
                                      onTap: () {
                                        _textController.text = text;
                                        ctrl.search(text);
                                      },
                                    );
                                  },
                                ),
                        ),
                      ],
                    );
                  }

                  // when query not empty -> show loading / results / empty
                  if (ctrl.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (ctrl.searchResults.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }

                  // show results list
                  return ListView.separated(
                    itemCount: ctrl.searchResults.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final ProductModel product = ctrl.searchResults[i];

                      // NOTE:
                      // Replace product.toString() below with actual fields from your ProductModel,
                      // e.g. product.name, product.price, product.image, etc.
                      //
                      // Example (if ProductModel has these fields):
                      // title: Text(product.name ?? 'Unnamed'),
                      // subtitle: Text('\$${product.price}'),
                      // leading: product.image != null ? Image.network(product.image) : CircleAvatar(...)

                      return ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(product.toString()),
                        subtitle: const Text('Tap to view details'),
                        onTap: () {
                          // navigate to product detail screen (pass arguments as your app expects)
                          // Example: Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
                          Get.toNamed(
                            AppRoutes.PRODUCT_DETAIL,
                            arguments: product,
                          );
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
