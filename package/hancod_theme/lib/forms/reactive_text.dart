part of '../forms.dart';

/* class ReactiveText<T> extends StatefulWidget {
  const ReactiveText({
    required this.formControlName,
    this.label,
    super.key,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.readOnly = false,
    this.maxLines,
    this.valueAccessor,
  });

  final String? label;
  final String formControlName;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool readOnly;
  final int? maxLines;
  final ControlValueAccessor<T, String>? valueAccessor;
  @override
  State<ReactiveText<T>> createState() => _ReactiveTextState<T>();
}

class _ReactiveTextState<T> extends State<ReactiveText<T>> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!),
        ],
        ReactiveTextField<T>(
          formControlName: widget.formControlName,
          decoration: widget.decoration,
          keyboardType: widget.keyboardType,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          valueAccessor: widget.valueAccessor,
        ),
      ],
    );
  }
} */

///
class ReactiveText<T> extends ReactiveFormField<T, String> {
  /// Creates a [ReactiveText] that contains a [TextField].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveText(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveText(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveText(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveText(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField], the constructor.
  ReactiveText({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    String? label,
    Object groupId = EditableText,
    InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        _defaultContextMenuBuilder,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    bool? ignorePointers,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Color? cursorErrorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    bool stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    TextEditingController? controller,
    Clip clipBehavior = Clip.hardEdge,
    bool enableIMEPersonalizedLearning = true,
    ReactiveFormFieldCallback<T>? onTap,
    ReactiveFormFieldCallback<T>? onEditingComplete,
    ReactiveFormFieldCallback<T>? onSubmitted,
    ReactiveFormFieldCallback<T>? onChanged,
    UndoHistoryController? undoController,
    bool? cursorOpacityAnimates,
    bool onTapAlwaysCalled = false,
    TapRegionCallback? onTapOutside,
    TapRegionUpCallback? onTapUpOutside,
    ContentInsertionConfiguration? contentInsertionConfiguration,
    bool canRequestFocus = true,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration? magnifierConfiguration,
    WidgetStatesController? statesController,
    FutureOr<List<String>>? suggestions,
    bool autoFlipDirection = false,
  })  : _textController = controller,
        _autoFlipDirection = autoFlipDirection,
        super(
          builder: (ReactiveFormFieldState<T, String> field) {
            final state = field as _ReactiveTextState<T>;
            final effectiveDecoration = decoration.applyDefaults(
              Theme.of(state.context).inputDecorationTheme,
            );

            final isRequired = field.control.validators
                .any((validator) => validator is RequiredValidator);

            final hasSuggestions = suggestions != null;

            Widget textField = TextField(
              groupId: groupId,
              controller: state._textController,
              focusNode: state.focusNode,
              decoration: effectiveDecoration.copyWith(
                errorText: state.errorText,
              ),
              keyboardType: T == int
                  ? TextInputType.number
                  : T == double
                      ? const TextInputType.numberWithOptions(decimal: true)
                      : keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              contextMenuBuilder: contextMenuBuilder,
              readOnly: readOnly,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              inputFormatters: [
                if (T == int) FilteringTextInputFormatter.digitsOnly,
                if (T == double)
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d{0,2}$'),
                  ),
                ...?inputFormatters,
              ],
              enabled: field.control.enabled,
              ignorePointers: ignorePointers,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              cursorErrorColor: cursorErrorColor,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              buildCounter: buildCounter,
              autofillHints: autofillHints,
              mouseCursor: mouseCursor,
              obscuringCharacter: obscuringCharacter,
              dragStartBehavior: dragStartBehavior,
              onAppPrivateCommand: onAppPrivateCommand,
              restorationId: restorationId,
              stylusHandwritingEnabled: stylusHandwritingEnabled,
              scrollController: scrollController,
              selectionControls: selectionControls,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              clipBehavior: clipBehavior,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              onTap: onTap != null ? () => onTap(field.control) : null,
              onSubmitted: onSubmitted != null
                  ? (_) => onSubmitted(field.control)
                  : null,
              onEditingComplete: onEditingComplete != null
                  ? () => onEditingComplete.call(field.control)
                  : null,
              onChanged: (value) {
                field.didChange(value);
                onChanged?.call(field.control);
              },
              undoController: undoController,
              cursorOpacityAnimates: cursorOpacityAnimates,
              onTapAlwaysCalled: onTapAlwaysCalled,
              onTapOutside: onTapOutside,
              onTapUpOutside: onTapUpOutside,
              contentInsertionConfiguration: contentInsertionConfiguration,
              canRequestFocus: canRequestFocus,
              spellCheckConfiguration: spellCheckConfiguration,
              magnifierConfiguration: magnifierConfiguration,
              statesController: statesController,
            );

            // Wrap with TypeAheadField if suggestions are provided
            if (hasSuggestions) {
              textField = TypeAheadField<String>(
                autoFlipDirection: state._autoFlipDirection,
                controller: state._textController,
                focusNode: state.focusNode,
                suggestionsCallback: (pattern) async {
                  final suggestionsList = await suggestions;
                  if (pattern.isEmpty) {
                    return suggestionsList;
                  }
                  final query = pattern.toLowerCase();
                  return suggestionsList
                      .where(
                        (String suggestion) =>
                            suggestion.toLowerCase().contains(query),
                      )
                      .toList();
                },
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text(
                    suggestion,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                onSelected: (suggestion) {
                  state._textController.text = suggestion;
                  field.didChange(suggestion);
                  onChanged?.call(field.control);
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    groupId: groupId,
                    controller: controller,
                    focusNode: focusNode,
                    decoration: effectiveDecoration.copyWith(
                      errorText: state.errorText,
                    ),
                    keyboardType: T == int
                        ? TextInputType.number
                        : T == double
                            ? const TextInputType.numberWithOptions(
                                decimal: true,
                              )
                            : keyboardType,
                    textInputAction: textInputAction,
                    style: style,
                    strutStyle: strutStyle,
                    textAlign: textAlign,
                    textAlignVertical: textAlignVertical,
                    textDirection: textDirection,
                    textCapitalization: textCapitalization,
                    autofocus: autofocus,
                    contextMenuBuilder: contextMenuBuilder,
                    readOnly: readOnly,
                    showCursor: showCursor,
                    obscureText: obscureText,
                    autocorrect: autocorrect,
                    smartDashesType: smartDashesType ??
                        (obscureText
                            ? SmartDashesType.disabled
                            : SmartDashesType.enabled),
                    smartQuotesType: smartQuotesType ??
                        (obscureText
                            ? SmartQuotesType.disabled
                            : SmartQuotesType.enabled),
                    enableSuggestions: enableSuggestions,
                    maxLengthEnforcement: maxLengthEnforcement,
                    maxLines: maxLines,
                    minLines: minLines,
                    expands: expands,
                    maxLength: maxLength,
                    inputFormatters: [
                      if (T == int) FilteringTextInputFormatter.digitsOnly,
                      if (T == double)
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}$'),
                        ),
                      ...?inputFormatters,
                    ],
                    enabled: field.control.enabled,
                    ignorePointers: ignorePointers,
                    cursorWidth: cursorWidth,
                    cursorHeight: cursorHeight,
                    cursorRadius: cursorRadius,
                    cursorColor: cursorColor,
                    cursorErrorColor: cursorErrorColor,
                    scrollPadding: scrollPadding,
                    scrollPhysics: scrollPhysics,
                    keyboardAppearance: keyboardAppearance,
                    enableInteractiveSelection: enableInteractiveSelection,
                    buildCounter: buildCounter,
                    autofillHints: autofillHints,
                    mouseCursor: mouseCursor,
                    obscuringCharacter: obscuringCharacter,
                    dragStartBehavior: dragStartBehavior,
                    onAppPrivateCommand: onAppPrivateCommand,
                    restorationId: restorationId,
                    stylusHandwritingEnabled: stylusHandwritingEnabled,
                    scrollController: scrollController,
                    selectionControls: selectionControls,
                    selectionHeightStyle: selectionHeightStyle,
                    selectionWidthStyle: selectionWidthStyle,
                    clipBehavior: clipBehavior,
                    enableIMEPersonalizedLearning:
                        enableIMEPersonalizedLearning,
                    onTap: onTap != null ? () => onTap(field.control) : null,
                    onSubmitted: onSubmitted != null
                        ? (_) => onSubmitted(field.control)
                        : null,
                    onEditingComplete: onEditingComplete != null
                        ? () => onEditingComplete.call(field.control)
                        : null,
                    onChanged: (value) {
                      field.didChange(value);
                      onChanged?.call(field.control);
                    },
                    undoController: undoController,
                    cursorOpacityAnimates: cursorOpacityAnimates,
                    onTapAlwaysCalled: onTapAlwaysCalled,
                    onTapOutside: onTapOutside,
                    onTapUpOutside: onTapUpOutside,
                    contentInsertionConfiguration:
                        contentInsertionConfiguration,
                    canRequestFocus: canRequestFocus,
                    spellCheckConfiguration: spellCheckConfiguration,
                    magnifierConfiguration: magnifierConfiguration,
                    statesController: statesController,
                  );
                },
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                if (label != null) ...[
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: label),
                        if (isRequired)
                          const TextSpan(
                            text: ' *',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
                textField,
              ],
            );
          },
        );
  final TextEditingController? _textController;
  final bool _autoFlipDirection;

  static Widget _defaultContextMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  ReactiveFormFieldState<T, String> createState() => _ReactiveTextState<T>();
}

class _ReactiveTextState<T> extends ReactiveFocusableFormFieldState<T, String> {
  late TextEditingController _textController;

  bool get _autoFlipDirection => (widget as ReactiveText<T>)._autoFlipDirection;

  @override
  void initState() {
    super.initState();
    _initializeTextController();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<T, String> selectValueAccessor() {
    if (control is FormControl<int>) {
      return IntValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<double>) {
      return DoubleValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<DateTime>) {
      return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<TimeOfDay>) {
      return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
    }

    return super.selectValueAccessor();
  }

  void _initializeTextController() {
    final initialValue = value;
    final currentWidget = widget as ReactiveText<T>;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : TextEditingController();
    _textController.text = initialValue ?? '';
  }

  @override
  void dispose() {
    final currentWidget = widget as ReactiveText<T>;
    if (currentWidget._textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }
}
