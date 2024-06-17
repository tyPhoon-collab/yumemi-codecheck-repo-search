import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/common/loading_indicator.dart';
import 'package:yumemi_codecheck_repo_search/service.dart';

class CurrentPageNumber extends ConsumerStatefulWidget {
  const CurrentPageNumber({super.key});

  @override
  ConsumerState<CurrentPageNumber> createState() => _CurrentPageNumberState();
}

class _CurrentPageNumberState extends ConsumerState<CurrentPageNumber> {
  late final textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = ref.watch(repoSearchResultProvider).value?.totalCount;
    final currentPage = ref.watch(repoSearchPageProvider);
    final perPage = ref.watch(repoSearchPerPageProvider);

    if (totalCount == null) {
      return const LoadingIndicator();
    }

    int upperCount() {
      return min(currentPage * perPage, totalCount);
    }

    int lowerCount() {
      return (currentPage - 1) * perPage + 1;
    }

    return TextButton(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          decoration: TextDecoration.underline,
        ),
      ),
      child: Text('${lowerCount()} ~ ${upperCount()} of $totalCount'),
      onPressed: () async {
        final page = await _showPageNumberInputDialog(context, totalCount);
        if (page != null) {
          ref.read(repoSearchPageProvider.notifier).update(page);
        }
      },
    );
  }

  Future<int?> _showPageNumberInputDialog(
    BuildContext context,
    int totalCount,
  ) async {
    final formKey = GlobalKey<FormState>();

    final result = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Input Page Number'),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: textController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Page Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                }
                final pageNum = int.tryParse(value);
                if (pageNum == null) {
                  return 'Please enter a valid number';
                }
                if (!ref
                    .read(repoSearchPageProvider.notifier)
                    .validate(pageNum, totalCount)) {
                  return 'Page number is out of range';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.of(context).pop(int.parse(textController.text));
                }
              },
            ),
          ],
        );
      },
    );
    return result;
  }
}