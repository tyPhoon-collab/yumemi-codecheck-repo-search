import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:yumemi_codecheck_repo_search/provider/search_query_provider.dart';

Future<int?> showPageNumberInputDialog(
  BuildContext context,
  int totalCount,
  int maxPage,
) async {
  final result = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return PageNumberInputDialog(totalCount, maxPage);
    },
  );

  return result;
}

class PageNumberInputDialog extends ConsumerStatefulWidget {
  const PageNumberInputDialog(this.totalCount, this.maxPage, {super.key});
  final int totalCount;
  final int maxPage;

  @override
  ConsumerState<PageNumberInputDialog> createState() =>
      _PageNumberInputDialogState();
}

class _PageNumberInputDialogState extends ConsumerState<PageNumberInputDialog> {
  late final textController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void submit(String text) {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pop(int.parse(text));
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Input Page Number'),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: textController,
          autofocus: true,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            hintText: 'Page: 1 ~ ${widget.maxPage}',
            prefixIcon: const Icon(Icons.numbers_outlined),
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: textController.clear,
            ),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a number';
            }
            final pageNum = int.tryParse(value);
            if (pageNum == null) {
              return 'Please enter a valid number';
            }
            if (!ref.read(pageNumberProvider.notifier).validate(
                  pageNum,
                  widget.totalCount,
                )) {
              return 'Page number is out of range';
            }
            return null;
          },
          onFieldSubmitted: submit,
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => submit(textController.text),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
