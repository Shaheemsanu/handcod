part of '../forms.dart';

class ReactiveRadioGroup<T> extends ReactiveFormField<T, T> {
  /// Constructs an instance of [ReactiveRadioGroup].
  ///
  /// The argument [formControlName] must not be null.
  /// The argument [options] must not be null or empty.
  ReactiveRadioGroup({
    required super.formControlName,
    required List<RadioOption<T>> options,
    super.key,
    Axis direction = Axis.horizontal,
    double spacing = 24.0,
    double labelSpacing = 4.0,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    // New parameters for label before options
    String? groupLabel,
    Widget? groupLabelWidget,
    double groupLabelSpacing = 24.0,
    TextStyle? groupLabelStyle,
  }) : super(
          builder: (ReactiveFormFieldState<T, T> field) {
            final radioButtons = options.map((option) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<T>(
                    value: option.value,
                    groupValue: field.value,
                    onChanged: field.control.enabled
                        ? (T? value) {
                            field.didChange(value);
                          }
                        : null,
                  ),
                  if (option.label != null) ...[
                    SizedBox(width: labelSpacing),
                    option.labelWidget ?? Text(option.label!),
                  ],
                ],
              );
            }).toList();

            Widget radioGroup;
            if (direction == Axis.horizontal) {
              radioGroup = Row(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: _intersperse(
                  radioButtons,
                  SizedBox(width: spacing),
                ).toList(),
              );
            } else {
              radioGroup = Column(
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                children: _intersperse(
                  radioButtons,
                  SizedBox(height: spacing),
                ).toList(),
              );
            }

            final themedRadioGroup = RadioThemeData(
              fillColor: WidgetStateProperty.resolveWith<Color>((
                states,
              ) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.black;
                }

                return AppColors.grey;
              }),
            );

            // If no group label is provided, return just the radio group
            if (groupLabel == null && groupLabelWidget == null) {
              return RadioTheme(
                data: themedRadioGroup,
                child: radioGroup,
              );
            }
            final isRequired = field.control.validators
                .any((validator) => validator is RequiredValidator);

            // If group label is provided, wrap in a Row with the label
            return Row(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: [
                groupLabelWidget ??
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: groupLabel,
                            style: groupLabelStyle ??
                                const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          if (isRequired)
                            const TextSpan(
                              text: ' *',
                              style: TextStyle(color: AppColors.red),
                            ),
                        ],
                      ),
                    ),
                SizedBox(width: groupLabelSpacing),
                RadioTheme(
                  data: themedRadioGroup,
                  child: radioGroup,
                ),
                SizedBox(width: groupLabelSpacing),
                if (field.control.hasErrors)
                  Text(
                    field.errorText ?? '',
                    style: TextStyle(
                      color: Theme.of(field.context).colorScheme.error,
                    ),
                  ),
              ],
            );
          },
        );

  static Iterable<Widget> _intersperse(
    List<Widget> items,
    Widget separator,
  ) sync* {
    for (var i = 0; i < items.length; i++) {
      if (i > 0) yield separator;
      yield items[i];
    }
  }

  @override
  ReactiveFormFieldState<T, T> createState() => ReactiveFormFieldState<T, T>();
}

/// Represents a single radio button option
class RadioOption<T> {
  const RadioOption({
    required this.value,
    this.label,
    this.labelWidget,
  }) : assert(
          label != null || labelWidget != null,
          'Either label or labelWidget must be provided',
        );
  final T value;
  final String? label;
  final Widget? labelWidget;
}
