import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

/// SearchBarというWidgetはすでにあるので、Repoというprefixを使っている
class RepoSearchBar extends ConsumerStatefulWidget {
  const RepoSearchBar({super.key});

  @override
  ConsumerState<RepoSearchBar> createState() => _RepoSearchBarState();
}

class _RepoSearchBarState extends ConsumerState<RepoSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(queryProvider, (_, query) {
      if (query == null) {
        _controller.clear();
      } else {
        _controller.text = query;
      }
    });

    return SearchBar(
      controller: _controller,
      hintText: S.current.searchPlaceholder,
      leading: const Icon(Icons.search),
      trailing: [
        if (ref.watch(queryProvider) != null)
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: ref.read(queryProvider.notifier).reset,
          ),
      ],
      padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 16)),
      textInputAction: TextInputAction.search,
      onSubmitted: ref.read(queryProvider.notifier).update,
    );
  }
}
