import 'package:flutter/material.dart';
import 'package:yumemi_codecheck_repo_search/generated/l10n.dart';

typedef Validate = bool Function(int value);

Future<int?> showPageNumberInputDialog(
  BuildContext context,
  int maxPage,
  Validate validate,
) async {
  final result = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          final dialog = PageNumberInputDialog(
            maxPage: maxPage,
            validate: validate,
          );

          // 横画面では、ダイアログとキーボードが同時に表示できるスペースが無い
          // そこで、ダイアログ全体をスクロールできるようにする
          // AlertDialog.scrollableというプロパティもあるが
          // それは全体がスクロール可能になるわけではないので不採用
          return switch (orientation) {
            Orientation.portrait => dialog,
            Orientation.landscape => SingleChildScrollView(child: dialog),
          };
        },
      );
    },
  );

  return result;
}

class PageNumberInputDialog extends StatefulWidget {
  const PageNumberInputDialog({
    required this.maxPage,
    required this.validate,
    super.key,
  });
  final int maxPage;
  final Validate validate;

  @override
  State<PageNumberInputDialog> createState() => _PageNumberInputDialogState();
}

class _PageNumberInputDialogState extends State<PageNumberInputDialog> {
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
      title: Text(S.current.inputPageNumberDialogTitle),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: textController,
          autofocus: true,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.go,
          decoration: InputDecoration(
            hintText: S.current.inputPageNumberDialogHint(widget.maxPage),
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
              return S.current.validationPleaseEnterANumber;
            }
            final pageNum = int.tryParse(value);
            if (pageNum == null) {
              return S.current.validationPleaseEnterAValidNumber;
            }
            if (!widget.validate(pageNum)) {
              return S.current.validationPageNumberIsOutOfRange;
            }
            return null;
          },
          onFieldSubmitted: submit,
        ),
      ),
      actions: [
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(S.current.cancel),
        ),
        TextButton(
          onPressed: () => submit(textController.text),
          child: Text(S.current.ok),
        ),
      ],
    );
  }
}
