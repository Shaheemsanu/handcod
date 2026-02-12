part of '../forms.dart';

typedef PickFileCallback = Future<void> Function();
typedef FilePickerChangeCallback<T> = void Function(MultiFile<T> files);

/// Essential details provided to the builder for custom design
class FilePickerDetails<T> {
  const FilePickerDetails({
    required this.pickFile,
    required this.files,
    required this.onChange,
    required this.isEnabled,
    required this.hasError,
    required this.isEmpty,
    required this.isTouched,
    required this.isDirty,
    required this.isValid,
    required this.context,
    required this.field,
    required this.isMultiple,
    this.errorText,
    this.pickerError,
  });

  /// Callback to trigger file picking
  final PickFileCallback pickFile;

  /// Current files value
  final MultiFile<T> files;

  /// Callback to update files
  final FilePickerChangeCallback<T> onChange;

  /// Whether the field is enabled
  final bool isEnabled;

  /// Whether the field has an error
  final bool hasError;

  /// Error message if any
  final String? errorText;

  /// Whether the field is empty
  final bool isEmpty;

  /// Whether the field has been touched
  final bool isTouched;

  /// Whether the field has been modified
  final bool isDirty;

  /// Whether the field is valid
  final bool isValid;

  /// Any error from the file picker itself
  final String? pickerError;

  /// BuildContext for theme access
  final BuildContext context;

  /// The reactive form field state (for advanced use cases)
  final ReactiveFormFieldState<MultiFile<T>, MultiFile<T>> field;

  /// Whether multiple files are allowed
  final bool isMultiple;

  /// Total number of files (platformFiles + files)
  int get totalFileCount => files.platformFiles.length + files.files.length;

  /// Whether there are any files
  bool get hasFiles => totalFileCount > 0;

  /// Whether single file mode (opposite of isMultiple)
  bool get isSingle => !isMultiple;

  /// Get the first platform file if available, null otherwise
  PlatformFile? get firstPlatformFile =>
      files.platformFiles.isNotEmpty ? files.platformFiles.first : null;

  /// Get the first file if available, null otherwise
  T? get firstFile => files.files.isNotEmpty ? files.files.first : null;

  /// Get all platform files
  List<PlatformFile> get platformFiles => files.platformFiles;

  /// Get all files
  List<T> get allFiles => files.files;

  /// Clear all files
  void clearFiles() {
    onChange(MultiFile<T>());
  }

  /// Remove a specific platform file by index
  void removePlatformFile(int index) {
    if (index >= 0 && index < files.platformFiles.length) {
      final updatedPlatformFiles = List<PlatformFile>.from(files.platformFiles)
        ..removeAt(index);
      onChange(files.copyWith(platformFiles: updatedPlatformFiles));
    }
  }

  /// Remove a specific file by index
  void removeFile(int index) {
    if (index >= 0 && index < files.files.length) {
      final updatedFiles = List<T>.from(files.files)..removeAt(index);
      onChange(files.copyWith(files: updatedFiles));
    }
  }
}

/// Builder that provides essential details for custom design
typedef FilePickerDetailsBuilder<T> = Widget Function(
  FilePickerDetails<T> details,
);

/// A [ReactiveFilePicker] that contains a [FilePicker].
///
/// This is a convenience widget that wraps a [FilePicker] widget in a
/// [ReactiveFilePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFilePicker<T>
    extends ReactiveFormField<MultiFile<T>, MultiFile<T>> {
  /// Creates a [ReactiveFilePicker] that contains a [FilePicker].
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
  /// ReactiveFilePicker(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFilePicker(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFilePicker(
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
  /// ReactiveFilePicker(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FilePicker] class
  /// and [FilePicker], the constructor.
  ///
  /// ### Custom Builder Example:
  /// ```dart
  /// ReactiveFilePicker(
  ///   formControlName: 'files',
  ///   allowMultiple: true, // Set to false for single file mode
  ///   builder: (details) {
  ///     return Column(
  ///       children: [
  ///         ElevatedButton(
  ///           onPressed: details.isEnabled ? details.pickFile : null,
  ///           child: Text(details.isMultiple ? 'Pick Files' : 'Pick File'),
  ///         ),
  ///         if (details.hasFiles)
  ///           Text('${details.totalFileCount} file(s) selected'),
  ///         if (details.isSingle && details.firstPlatformFile != null)
  ///           Text('Selected: ${details.firstPlatformFile!.name}'),
  ///         if (details.hasError)
  ///           Text(
  ///             details.errorText ?? '',
  ///             style: TextStyle(color: Colors.red),
  ///           ),
  ///         // Show file list for multi-file mode
  ///         if (details.isMultiple && details.hasFiles)
  ///           ...details.platformFiles.map((file) =>
  ///             ListTile(
  ///               title: Text(file.name),
  ///               trailing: IconButton(
  ///                 icon: Icon(Icons.delete),
  ///                 onPressed: () => details.removePlatformFile(
  ///                   details.platformFiles.indexOf(file)
  ///                 ),
  ///               ),
  ///             )
  ///           ),
  ///       ],
  ///     );
  ///   },
  /// ),
  /// ```
  ReactiveFilePicker({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,

    /// Custom builder that provides essential details for design
    /// This is the recommended way to customize the file picker design
    FilePickerDetailsBuilder<T>? builder,
    String? dialogTitle,
    bool allowMultiple = false,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    void Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    bool withData = true,
    bool withReadStream = false,
    bool lockParentWindow = false,
    double disabledOpacity = 0.5,
    String? initialDirectory,
    Widget Function(BuildContext context, String error)? errorBuilder,

    // input decorator props
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool expands = false,
    MouseCursor cursor = SystemMouseCursors.basic,
  }) : super(
          builder: (field) {
            final value = field.value ?? MultiFile<T>();
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            String? pickerError;

            Future<void> pickFile() async {
              var platformFiles = <PlatformFile>[];
              try {
                platformFiles = (await FilePicker.platform.pickFiles(
                      initialDirectory: initialDirectory,
                      dialogTitle: dialogTitle,
                      allowMultiple: allowMultiple,
                      type: type,
                      allowedExtensions: allowedExtensions,
                      onFileLoading: onFileLoading,
                      compressionQuality: compressionQuality,
                      withData: withData,
                      withReadStream: withReadStream,
                      lockParentWindow: lockParentWindow,
                    ))
                        ?.files ??
                    [];
              } on PlatformException catch (e) {
                pickerError = 'Unsupported operation $e';
              } catch (e) {
                pickerError = e.toString();
              }

              if (platformFiles.isNotEmpty) {
                field.control.markAsTouched();
                // In single file mode, replace existing files; in multi-file mode, append
                if (allowMultiple) {
                  field.didChange(
                    value.copyWith(
                      platformFiles: [
                        ...value.platformFiles,
                        ...platformFiles,
                      ],
                    ),
                  );
                } else {
                  // Single file mode: replace with the first selected file
                  field.didChange(
                    value.copyWith(
                      platformFiles: [platformFiles.first],
                      files: [], // Clear typed files when replacing
                    ),
                  );
                }
              }
            }

            final errorText = field.errorText ?? pickerError;
            final hasError = errorText != null;
            final isEmptyValue = field.value == null ||
                ((field.value?.platformFiles.isEmpty ?? false) &&
                    (field.value?.files.isEmpty ?? false));

            // Create details object for the new builder
            final details = FilePickerDetails<T>(
              pickFile: pickFile,
              files: value,
              onChange: (files) {
                field.control.markAsTouched();
                field.didChange(files);
              },
              isEnabled: field.control.enabled,
              hasError: hasError,
              errorText: errorText,
              isEmpty: isEmptyValue,
              isTouched: field.control.touched,
              isDirty: field.control.dirty,
              isValid: field.control.valid,
              pickerError: pickerError,
              context: field.context,
              field: field,
              isMultiple: allowMultiple,
            );

            // Use new builder if provided, otherwise fall back to legacy builder
            Widget? customWidget;
            if (builder != null) {
              customWidget = builder(details);
            }

            // If custom builder is provided, wrap it appropriately
            if (customWidget != null) {
              return IgnorePointer(
                ignoring: !field.control.enabled,
                child: MouseRegion(
                  cursor: cursor,
                  child: Opacity(
                    opacity: field.control.enabled ? 1 : disabledOpacity,
                    child: customWidget,
                  ),
                ),
              );
            }

            // Default behavior with InputDecorator (when no builder is provided)
            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: MouseRegion(
                cursor: cursor,
                child: HoverBuilder(
                  builder: (context, isHovered) {
                    return InputDecorator(
                      isHovering: isHovered,
                      baseStyle: baseStyle,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      expands: expands,
                      isEmpty: isEmptyValue,
                      decoration: effectiveDecoration.copyWith(
                        enabled: field.control.enabled,
                        errorText: errorBuilder == null ? errorText : null,
                        error: errorBuilder != null && hasError
                            ? DefaultTextStyle.merge(
                                style: Theme.of(field.context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(field.context)
                                          .colorScheme
                                          .error,
                                    )
                                    .merge(effectiveDecoration.errorStyle),
                                child: errorBuilder(
                                  field.context,
                                  errorText,
                                ),
                              )
                            : null,
                      ),
                      child: Opacity(
                        opacity: field.control.enabled ? 1 : disabledOpacity,
                        child: const SizedBox.shrink(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
}

class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, bool isHovered) builder;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHoverChanged(enabled: true),
      onExit: (event) => _onHoverChanged(enabled: false),
      child: widget.builder(context, _isHovered),
    );
  }

  void _onHoverChanged({required bool enabled}) {
    setState(() {
      _isHovered = enabled;
    });
  }
}
