part of '../forms.dart';

class ReactiveCheckboxWithLabel extends StatefulWidget {
  const ReactiveCheckboxWithLabel({
    required this.formControlName,
    required this.label,
    super.key,
    this.labelOnRight = true,
  });
  final String formControlName;
  final String label;
  final bool labelOnRight;

  @override
  State<ReactiveCheckboxWithLabel> createState() =>
      _ReactiveCheckboxWithLabelState();
}

class _ReactiveCheckboxWithLabelState extends State<ReactiveCheckboxWithLabel> {
  bool _isRequired = false;
  FormControl<bool> _resolveFormControl() {
    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(widget);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(widget.formControlName);
    if (control is! FormControl<bool>) {
      throw Exception('Form control is not a bool');
    }

    return control;
  }

  @override
  void initState() {
    super.initState();
    final control = _resolveFormControl();
    _isRequired =
        control.validators.any((validator) => validator is RequiredValidator);
  }

  @override
  Widget build(BuildContext context) {
    final control = _resolveFormControl();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: widget.labelOnRight
          ? [
              ReactiveCheckbox(
                formControlName: widget.formControlName,
                checkColor: AppColors.white,
                activeColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(width: 8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: widget.label),
                    if (_isRequired)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: AppColors.red),
                      ),
                  ],
                ),
              ),
              if (control.hasErrors) ...[
                const SizedBox(width: 8),
                Text(control.errors.entries.firstOrNull?.key ?? ''),
              ],
            ]
          : [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: widget.label),
                    if (_isRequired)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: AppColors.red),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ReactiveCheckbox(
                formControlName: widget.formControlName,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              if (control.hasErrors) ...[
                const SizedBox(width: 8),
                Text(control.errors.entries.firstOrNull?.key ?? ''),
              ],
            ],
    );
  }
}
