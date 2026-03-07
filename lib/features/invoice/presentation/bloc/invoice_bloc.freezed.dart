// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$InvoiceEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String imagePath) processImage,
    required TResult Function(InvoiceEntity invoice) saveInvoice,
    required TResult Function(String id) getInvoiceDetail,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String imagePath)? processImage,
    TResult? Function(InvoiceEntity invoice)? saveInvoice,
    TResult? Function(String id)? getInvoiceDetail,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String imagePath)? processImage,
    TResult Function(InvoiceEntity invoice)? saveInvoice,
    TResult Function(String id)? getInvoiceDetail,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProcessImage value) processImage,
    required TResult Function(SaveInvoice value) saveInvoice,
    required TResult Function(GetInvoiceDetail value) getInvoiceDetail,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProcessImage value)? processImage,
    TResult? Function(SaveInvoice value)? saveInvoice,
    TResult? Function(GetInvoiceDetail value)? getInvoiceDetail,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProcessImage value)? processImage,
    TResult Function(SaveInvoice value)? saveInvoice,
    TResult Function(GetInvoiceDetail value)? getInvoiceDetail,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceEventCopyWith<$Res> {
  factory $InvoiceEventCopyWith(
    InvoiceEvent value,
    $Res Function(InvoiceEvent) then,
  ) = _$InvoiceEventCopyWithImpl<$Res, InvoiceEvent>;
}

/// @nodoc
class _$InvoiceEventCopyWithImpl<$Res, $Val extends InvoiceEvent>
    implements $InvoiceEventCopyWith<$Res> {
  _$InvoiceEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ProcessImageImplCopyWith<$Res> {
  factory _$$ProcessImageImplCopyWith(
    _$ProcessImageImpl value,
    $Res Function(_$ProcessImageImpl) then,
  ) = __$$ProcessImageImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String imagePath});
}

/// @nodoc
class __$$ProcessImageImplCopyWithImpl<$Res>
    extends _$InvoiceEventCopyWithImpl<$Res, _$ProcessImageImpl>
    implements _$$ProcessImageImplCopyWith<$Res> {
  __$$ProcessImageImplCopyWithImpl(
    _$ProcessImageImpl _value,
    $Res Function(_$ProcessImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? imagePath = null}) {
    return _then(
      _$ProcessImageImpl(
        null == imagePath
            ? _value.imagePath
            : imagePath // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ProcessImageImpl implements ProcessImage {
  const _$ProcessImageImpl(this.imagePath);

  @override
  final String imagePath;

  @override
  String toString() {
    return 'InvoiceEvent.processImage(imagePath: $imagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessImageImpl &&
            (identical(other.imagePath, imagePath) ||
                other.imagePath == imagePath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, imagePath);

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessImageImplCopyWith<_$ProcessImageImpl> get copyWith =>
      __$$ProcessImageImplCopyWithImpl<_$ProcessImageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String imagePath) processImage,
    required TResult Function(InvoiceEntity invoice) saveInvoice,
    required TResult Function(String id) getInvoiceDetail,
  }) {
    return processImage(imagePath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String imagePath)? processImage,
    TResult? Function(InvoiceEntity invoice)? saveInvoice,
    TResult? Function(String id)? getInvoiceDetail,
  }) {
    return processImage?.call(imagePath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String imagePath)? processImage,
    TResult Function(InvoiceEntity invoice)? saveInvoice,
    TResult Function(String id)? getInvoiceDetail,
    required TResult orElse(),
  }) {
    if (processImage != null) {
      return processImage(imagePath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProcessImage value) processImage,
    required TResult Function(SaveInvoice value) saveInvoice,
    required TResult Function(GetInvoiceDetail value) getInvoiceDetail,
  }) {
    return processImage(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProcessImage value)? processImage,
    TResult? Function(SaveInvoice value)? saveInvoice,
    TResult? Function(GetInvoiceDetail value)? getInvoiceDetail,
  }) {
    return processImage?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProcessImage value)? processImage,
    TResult Function(SaveInvoice value)? saveInvoice,
    TResult Function(GetInvoiceDetail value)? getInvoiceDetail,
    required TResult orElse(),
  }) {
    if (processImage != null) {
      return processImage(this);
    }
    return orElse();
  }
}

abstract class ProcessImage implements InvoiceEvent {
  const factory ProcessImage(final String imagePath) = _$ProcessImageImpl;

  String get imagePath;

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessImageImplCopyWith<_$ProcessImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SaveInvoiceImplCopyWith<$Res> {
  factory _$$SaveInvoiceImplCopyWith(
    _$SaveInvoiceImpl value,
    $Res Function(_$SaveInvoiceImpl) then,
  ) = __$$SaveInvoiceImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvoiceEntity invoice});
}

/// @nodoc
class __$$SaveInvoiceImplCopyWithImpl<$Res>
    extends _$InvoiceEventCopyWithImpl<$Res, _$SaveInvoiceImpl>
    implements _$$SaveInvoiceImplCopyWith<$Res> {
  __$$SaveInvoiceImplCopyWithImpl(
    _$SaveInvoiceImpl _value,
    $Res Function(_$SaveInvoiceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invoice = null}) {
    return _then(
      _$SaveInvoiceImpl(
        null == invoice
            ? _value.invoice
            : invoice // ignore: cast_nullable_to_non_nullable
                  as InvoiceEntity,
      ),
    );
  }
}

/// @nodoc

class _$SaveInvoiceImpl implements SaveInvoice {
  const _$SaveInvoiceImpl(this.invoice);

  @override
  final InvoiceEntity invoice;

  @override
  String toString() {
    return 'InvoiceEvent.saveInvoice(invoice: $invoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SaveInvoiceImpl &&
            (identical(other.invoice, invoice) || other.invoice == invoice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invoice);

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SaveInvoiceImplCopyWith<_$SaveInvoiceImpl> get copyWith =>
      __$$SaveInvoiceImplCopyWithImpl<_$SaveInvoiceImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String imagePath) processImage,
    required TResult Function(InvoiceEntity invoice) saveInvoice,
    required TResult Function(String id) getInvoiceDetail,
  }) {
    return saveInvoice(invoice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String imagePath)? processImage,
    TResult? Function(InvoiceEntity invoice)? saveInvoice,
    TResult? Function(String id)? getInvoiceDetail,
  }) {
    return saveInvoice?.call(invoice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String imagePath)? processImage,
    TResult Function(InvoiceEntity invoice)? saveInvoice,
    TResult Function(String id)? getInvoiceDetail,
    required TResult orElse(),
  }) {
    if (saveInvoice != null) {
      return saveInvoice(invoice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProcessImage value) processImage,
    required TResult Function(SaveInvoice value) saveInvoice,
    required TResult Function(GetInvoiceDetail value) getInvoiceDetail,
  }) {
    return saveInvoice(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProcessImage value)? processImage,
    TResult? Function(SaveInvoice value)? saveInvoice,
    TResult? Function(GetInvoiceDetail value)? getInvoiceDetail,
  }) {
    return saveInvoice?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProcessImage value)? processImage,
    TResult Function(SaveInvoice value)? saveInvoice,
    TResult Function(GetInvoiceDetail value)? getInvoiceDetail,
    required TResult orElse(),
  }) {
    if (saveInvoice != null) {
      return saveInvoice(this);
    }
    return orElse();
  }
}

abstract class SaveInvoice implements InvoiceEvent {
  const factory SaveInvoice(final InvoiceEntity invoice) = _$SaveInvoiceImpl;

  InvoiceEntity get invoice;

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SaveInvoiceImplCopyWith<_$SaveInvoiceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetInvoiceDetailImplCopyWith<$Res> {
  factory _$$GetInvoiceDetailImplCopyWith(
    _$GetInvoiceDetailImpl value,
    $Res Function(_$GetInvoiceDetailImpl) then,
  ) = __$$GetInvoiceDetailImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$GetInvoiceDetailImplCopyWithImpl<$Res>
    extends _$InvoiceEventCopyWithImpl<$Res, _$GetInvoiceDetailImpl>
    implements _$$GetInvoiceDetailImplCopyWith<$Res> {
  __$$GetInvoiceDetailImplCopyWithImpl(
    _$GetInvoiceDetailImpl _value,
    $Res Function(_$GetInvoiceDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$GetInvoiceDetailImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$GetInvoiceDetailImpl implements GetInvoiceDetail {
  const _$GetInvoiceDetailImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'InvoiceEvent.getInvoiceDetail(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetInvoiceDetailImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetInvoiceDetailImplCopyWith<_$GetInvoiceDetailImpl> get copyWith =>
      __$$GetInvoiceDetailImplCopyWithImpl<_$GetInvoiceDetailImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String imagePath) processImage,
    required TResult Function(InvoiceEntity invoice) saveInvoice,
    required TResult Function(String id) getInvoiceDetail,
  }) {
    return getInvoiceDetail(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String imagePath)? processImage,
    TResult? Function(InvoiceEntity invoice)? saveInvoice,
    TResult? Function(String id)? getInvoiceDetail,
  }) {
    return getInvoiceDetail?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String imagePath)? processImage,
    TResult Function(InvoiceEntity invoice)? saveInvoice,
    TResult Function(String id)? getInvoiceDetail,
    required TResult orElse(),
  }) {
    if (getInvoiceDetail != null) {
      return getInvoiceDetail(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ProcessImage value) processImage,
    required TResult Function(SaveInvoice value) saveInvoice,
    required TResult Function(GetInvoiceDetail value) getInvoiceDetail,
  }) {
    return getInvoiceDetail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ProcessImage value)? processImage,
    TResult? Function(SaveInvoice value)? saveInvoice,
    TResult? Function(GetInvoiceDetail value)? getInvoiceDetail,
  }) {
    return getInvoiceDetail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ProcessImage value)? processImage,
    TResult Function(SaveInvoice value)? saveInvoice,
    TResult Function(GetInvoiceDetail value)? getInvoiceDetail,
    required TResult orElse(),
  }) {
    if (getInvoiceDetail != null) {
      return getInvoiceDetail(this);
    }
    return orElse();
  }
}

abstract class GetInvoiceDetail implements InvoiceEvent {
  const factory GetInvoiceDetail(final String id) = _$GetInvoiceDetailImpl;

  String get id;

  /// Create a copy of InvoiceEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetInvoiceDetailImplCopyWith<_$GetInvoiceDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$InvoiceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(InvoiceEntity invoice) loaded,
    required TResult Function(String? message) success,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(InvoiceEntity invoice)? loaded,
    TResult? Function(String? message)? success,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(InvoiceEntity invoice)? loaded,
    TResult Function(String? message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvoiceStateCopyWith<$Res> {
  factory $InvoiceStateCopyWith(
    InvoiceState value,
    $Res Function(InvoiceState) then,
  ) = _$InvoiceStateCopyWithImpl<$Res, InvoiceState>;
}

/// @nodoc
class _$InvoiceStateCopyWithImpl<$Res, $Val extends InvoiceState>
    implements $InvoiceStateCopyWith<$Res> {
  _$InvoiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'InvoiceState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(InvoiceEntity invoice) loaded,
    required TResult Function(String? message) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(InvoiceEntity invoice)? loaded,
    TResult? Function(String? message)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(InvoiceEntity invoice)? loaded,
    TResult Function(String? message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements InvoiceState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'InvoiceState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(InvoiceEntity invoice) loaded,
    required TResult Function(String? message) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(InvoiceEntity invoice)? loaded,
    TResult? Function(String? message)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(InvoiceEntity invoice)? loaded,
    TResult Function(String? message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements InvoiceState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
    _$LoadedImpl value,
    $Res Function(_$LoadedImpl) then,
  ) = __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvoiceEntity invoice});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
    _$LoadedImpl _value,
    $Res Function(_$LoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? invoice = null}) {
    return _then(
      _$LoadedImpl(
        null == invoice
            ? _value.invoice
            : invoice // ignore: cast_nullable_to_non_nullable
                  as InvoiceEntity,
      ),
    );
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.invoice);

  @override
  final InvoiceEntity invoice;

  @override
  String toString() {
    return 'InvoiceState.loaded(invoice: $invoice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.invoice, invoice) || other.invoice == invoice));
  }

  @override
  int get hashCode => Object.hash(runtimeType, invoice);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(InvoiceEntity invoice) loaded,
    required TResult Function(String? message) success,
    required TResult Function(String message) error,
  }) {
    return loaded(invoice);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(InvoiceEntity invoice)? loaded,
    TResult? Function(String? message)? success,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(invoice);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(InvoiceEntity invoice)? loaded,
    TResult Function(String? message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(invoice);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements InvoiceState {
  const factory _Loaded(final InvoiceEntity invoice) = _$LoadedImpl;

  InvoiceEntity get invoice;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? message});
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = freezed}) {
    return _then(
      _$SuccessImpl(
        freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SuccessImpl implements _Success {
  const _$SuccessImpl([this.message]);

  @override
  final String? message;

  @override
  String toString() {
    return 'InvoiceState.success(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(InvoiceEntity invoice) loaded,
    required TResult Function(String? message) success,
    required TResult Function(String message) error,
  }) {
    return success(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(InvoiceEntity invoice)? loaded,
    TResult? Function(String? message)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(InvoiceEntity invoice)? loaded,
    TResult Function(String? message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements InvoiceState {
  const factory _Success([final String? message]) = _$SuccessImpl;

  String? get message;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$InvoiceStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'InvoiceState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(InvoiceEntity invoice) loaded,
    required TResult Function(String? message) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(InvoiceEntity invoice)? loaded,
    TResult? Function(String? message)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(InvoiceEntity invoice)? loaded,
    TResult Function(String? message)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements InvoiceState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of InvoiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
