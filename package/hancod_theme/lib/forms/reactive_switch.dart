part of '../forms.dart';

class ReactiveCupertinoSwitch extends ReactiveFormField<bool, bool> {
  /// Constructs an instance of [ReactiveCupertinoSwitch].
  ///
  /// The argument [formControlName] must not be null.
  ReactiveCupertinoSwitch({
    required String formControlName,
    super.key,
    String? label,
  }) : super(
          formControlName: formControlName,
          builder: (ReactiveFormFieldState<bool, bool> field) {
            // RatingBar inner widget
            return Row(
              children: [
                if (label != null) ...[
                  Text(label),
                  const SizedBox(width: 12),
                ],
                CupertinoSwitch(
                  value: field.value ?? false,
                  onChanged: (value) {
                    field.didChange(value);
                  },
                ),
              ],
            );
          },
        );

  @override
  ReactiveFormFieldState<bool, bool> createState() =>
      ReactiveFormFieldState<bool, bool>();
}
