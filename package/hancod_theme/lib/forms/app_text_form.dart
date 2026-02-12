part of '../forms.dart';

class AppTextForm<T> extends FormBuilderFieldDecoration<String> {
  AppTextForm({
    required super.name,
    this.label,
    super.key,
    super.decoration,
    super.onChanged,
    super.enabled,
    super.onSaved,
    super.autovalidateMode = AutovalidateMode.disabled,
    super.onReset,
    super.focusNode,
    super.restorationId,
    super.errorBuilder,
    // Generic validator that handles type conversion
    String? Function(T?)? validator,
    // Generic initial value
    T? initialValue,
    // Generic onSubmitted callback
    void Function(T?)? onSubmitted,
    // All the existing TextField properties
    this.readOnly = false,
    this.maxLines = 1,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.scrollPadding = const EdgeInsets.all(20),
    this.enableInteractiveSelection = true,
    this.maxLengthEnforcement,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.autocorrect = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.keyboardType,
    this.style,
    this.controller,
    this.textInputAction,
    this.strutStyle,
    this.textDirection,
    this.maxLength,
    this.onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.buildCounter,
    this.expands = false,
    this.minLines,
    this.showCursor,
    this.onTap,
    this.onTapOutside,
    this.enableSuggestions = true,
    this.textAlignVertical,
    this.dragStartBehavior = DragStartBehavior.start,
    this.scrollController,
    this.scrollPhysics,
    this.selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.smartDashesType,
    this.smartQuotesType,
    this.selectionHeightStyle = ui.BoxHeightStyle.tight,
    this.autofillHints,
    this.obscuringCharacter = '•',
    this.mouseCursor,
    this.contextMenuBuilder = _defaultContextMenuBuilder,
    this.magnifierConfiguration,
    this.contentInsertionConfiguration,
    this.spellCheckConfiguration,
    this.clipBehavior = Clip.hardEdge,
    @Deprecated(
      'This property will be removed in the next Flutter stable versions. '
      'Use FocusNode.canRequestFocus instead. '
      'Ref: https://docs.flutter.dev/release/breaking-changes/can-request-focus',
    )
    this.canRequestFocus = true,
    this.cursorErrorColor,
    this.cursorOpacityAnimates,
    this.enableIMEPersonalizedLearning = true,
    this.groupId = EditableText,
    this.onAppPrivateCommand,
    this.onTapAlwaysCalled = false,
    @Deprecated(
      'Use `stylusHandwritingEnabled` instead. '
      'This feature was deprecated after v3.27.0-0.2.pre.',
    )
    this.scribbleEnabled = true,
    this.stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    this.selectionControls,
    this.statesController,
    this.undoController,
  })  : assert(initialValue == null || controller == null),
        assert(minLines == null || minLines > 0),
        assert(maxLines == null || maxLines > 0),
        assert(
          (minLines == null) || (maxLines == null) || (maxLines >= minLines),
          "minLines can't be greater than maxLines",
        ),
        assert(
          !expands || (minLines == null && maxLines == null),
          'minLines and maxLines must be null when expands is true.',
        ),
        assert(
          !obscureText || maxLines == 1,
          'Obscured fields cannot be multiline.',
        ),
        assert(maxLength == null || maxLength > 0),
        super(
          // Handle initial value conversion
          initialValue: controller != null
              ? controller.text
              : _convertToString<T>(initialValue),
          // Generic validator with type conversion
          validator: (val) {
            return switch (T) {
              String => validator?.call(val as T?),
              int =>
                validator?.call(val == null ? null : int.tryParse(val) as T?),
              double => validator
                  ?.call(val == null ? null : double.tryParse(val) as T?),
              Type() => validator?.call(val as T?),
            };
          },
          // Value transformer for type conversion
          valueTransformer: (value) {
            return switch (T) {
              String => value as T?,
              int => value == null ? null : int.tryParse(value) as T?,
              double => value == null ? null : double.tryParse(value) as T?,
              _ => value as T?
            };
          },
          builder: (FormFieldState<String?> field) {
            final state = field as _AppTextFormState<T>;

            return TextField(
              restorationId: restorationId,
              controller: state._effectiveController,
              focusNode: state.effectiveFocusNode,
              decoration: state.decoration,
              keyboardType: keyboardType ?? _getDefaultKeyboardType<T>(),
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              readOnly: readOnly,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              enableSuggestions: enableSuggestions,
              maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onTap: onTap,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              onSubmitted: (value) {
                if (value.isEmpty && onSubmitted != null) {
                  onSubmitted(null);
                  return;
                }
                onSubmitted?.call(
                  switch (T) {
                    String => value as T,
                    int => int.tryParse(value) as T?,
                    double => double.tryParse(value) as T?,
                    _ => value as T
                  },
                );
              },
              inputFormatters: _buildInputFormatters<T>(inputFormatters),
              enabled: state.enabled,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              scrollPadding: scrollPadding,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
              dragStartBehavior: dragStartBehavior,
              scrollController: scrollController,
              scrollPhysics: scrollPhysics,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              mouseCursor: mouseCursor,
              contextMenuBuilder: contextMenuBuilder,
              obscuringCharacter: obscuringCharacter,
              autofillHints: autofillHints,
              magnifierConfiguration: magnifierConfiguration,
              contentInsertionConfiguration: contentInsertionConfiguration,
              spellCheckConfiguration: spellCheckConfiguration,
              clipBehavior: clipBehavior,
              canRequestFocus: canRequestFocus,
              cursorErrorColor: cursorErrorColor,
              cursorOpacityAnimates: cursorOpacityAnimates,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              groupId: groupId,
              onAppPrivateCommand: onAppPrivateCommand,
              onTapAlwaysCalled: onTapAlwaysCalled,
              stylusHandwritingEnabled: stylusHandwritingEnabled,
              selectionControls: selectionControls,
              statesController: statesController,
              undoController: undoController,
            );
          },
        );

  final String? label;
  // All existing properties
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextDirection? textDirection;
  final bool autofocus;
  final String obscuringCharacter;
  final bool obscureText;
  final bool autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool enableSuggestions;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final bool? showCursor;
  static const int noMaxLength = -1;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final VoidCallback? onEditingComplete;
  final double cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final ui.BoxHeightStyle selectionHeightStyle;
  final ui.BoxWidthStyle selectionWidthStyle;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final DragStartBehavior dragStartBehavior;
  bool get selectionEnabled => enableInteractiveSelection;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final MouseCursor? mouseCursor;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final Iterable<String>? autofillHints;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final bool readOnly;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final SpellCheckConfiguration? spellCheckConfiguration;
  final Clip clipBehavior;
  final bool canRequestFocus;
  final Color? cursorErrorColor;
  final bool? cursorOpacityAnimates;
  final bool enableIMEPersonalizedLearning;
  final Object groupId;
  final AppPrivateCommandCallback? onAppPrivateCommand;
  final bool onTapAlwaysCalled;
  final bool stylusHandwritingEnabled;
  final bool scribbleEnabled;
  final TextSelectionControls? selectionControls;
  final WidgetStatesController? statesController;
  final UndoHistoryController? undoController;

  // Helper methods
  static String? _convertToString<T>(T? value) {
    return switch (T) {
      String => value as String?,
      int => value?.toString(),
      double => value?.toString(),
      _ => value?.toString()
    };
  }

  static TextInputType _getDefaultKeyboardType<T>() {
    return switch (T) {
      int => TextInputType.number,
      double => const TextInputType.numberWithOptions(decimal: true),
      _ => TextInputType.text,
    };
  }

  static List<TextInputFormatter> _buildInputFormatters<T>(
    List<TextInputFormatter>? customFormatters,
  ) {
    final formatters = <TextInputFormatter>[];

    // Add type-specific formatters
    if (T == double) {
      formatters.add(
        TextInputFormatter.withFunction(
          (TextEditingValue oldValue, TextEditingValue newValue) {
            if (newValue.text.isEmpty) {
              return newValue;
            }

            if (newValue.text.split('.').length > 2) {
              return oldValue;
            }

            String newString;
            if (newValue.text.startsWith('-')) {
              final digitsAfterMinus = newValue.text.substring(1);
              if (digitsAfterMinus.isEmpty) {
                return newValue;
              }
              newString =
                  '-${digitsAfterMinus.replaceAll(RegExp(r'[^\d.]'), '')}';
            } else {
              newString = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');
            }

            if (newString.startsWith('00')) {
              return oldValue;
            }

            if (newString.contains('.')) {
              final parts = newString.split('.');
              if (parts[1].length > 2) {
                parts[1] = parts[1].substring(0, 2);
                newString = parts.join('.');
              }
              if (parts[0].isEmpty) {
                newString = '0$newString';
              }
            }

            if (newString.endsWith('.')) {
              return newValue.copyWith(
                text: newString,
                selection: TextSelection.collapsed(offset: newString.length),
              );
            }

            try {
              if (newString.isNotEmpty && newString != '-') {
                double.parse(newString);
              }
            } catch (e) {
              return oldValue;
            }

            return TextEditingValue(
              text: newString,
              selection: TextSelection.collapsed(
                offset: math.min(newString.length, newValue.selection.end),
              ),
            );
          },
        ),
      );
    } else if (T == int) {
      formatters.add(
        TextInputFormatter.withFunction(
          (TextEditingValue oldValue, TextEditingValue newValue) {
            String newString;
            if (newValue.text.startsWith('-')) {
              newString = '-${newValue.text.replaceAll(RegExp(r'\D'), '')}';
            } else {
              newString = newValue.text.replaceAll(RegExp(r'\D'), '');
            }
            return newValue.copyWith(
              text: newString,
              selection: newValue.selection.copyWith(
                baseOffset:
                    newValue.selection.baseOffset.clamp(0, newString.length),
                extentOffset:
                    newValue.selection.extentOffset.clamp(0, newString.length),
              ),
            );
          },
        ),
      );
    }

    // Add custom formatters
    if (customFormatters != null) {
      formatters.addAll(customFormatters);
    }

    return formatters;
  }

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  FormBuilderFieldDecorationState<AppTextForm<T>, String> createState() =>
      _AppTextFormState<T>();
}

class _AppTextFormState<T>
    extends FormBuilderFieldDecorationState<AppTextForm<T>, String> {
  TextEditingController? get _effectiveController =>
      widget.controller ?? _controller;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: value);
    _controller!.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _controller!.removeListener(_handleControllerChanged);
    if (null == widget.controller) {
      _controller!.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    setState(() {
      _effectiveController!.text = initialValue ?? '';
    });
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController!.text != value) {
      _effectiveController!.text = value ?? '';
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController!.text != (value ?? '')) {
      didChange(_effectiveController!.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 12),
        ],
        super.build(context),
      ],
    );
  }
}
