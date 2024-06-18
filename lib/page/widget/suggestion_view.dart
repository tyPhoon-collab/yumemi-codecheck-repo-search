import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/error_text.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';
import 'package:yumemi_codecheck_repo_search/provider/service_provider.dart';

class SuggestionsView extends ConsumerWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(queryHistoryStreamProvider).when(
          data: (data) {
            if (data.isEmpty) return const SizedBox();

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (final query in data)
                    ListTile(
                      title: Text(query),
                      leading: const Icon(Icons.history),
                      trailing: GestureDetector(
                        onTap: () =>
                            ref.read(queryHistoryServiceProvider).remove(query),
                        child: const Icon(Icons.delete),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();

                        ref
                            .read(repoSearchQueryProvider.notifier)
                            .update(query);
                      },
                    ),
                ],
              ),
            );
          },
          error: (error, stackTrace) =>
              const ErrorText(text: 'Could not fetch query history'),
          loading: () => const SizedBox(),
        );
  }
}
