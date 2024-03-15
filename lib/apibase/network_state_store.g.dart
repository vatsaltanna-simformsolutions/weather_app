// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_state_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NetworkStateStore on _NetworkStateStore, Store {
  late final _$stateAtom =
      Atom(name: '_NetworkStateStore.state', context: context);

  @override
  NetworkState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(NetworkState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  late final _$serverErrorAtom =
      Atom(name: '_NetworkStateStore.serverError', context: context);

  @override
  String? get serverError {
    _$serverErrorAtom.reportRead();
    return super.serverError;
  }

  @override
  set serverError(String? value) {
    _$serverErrorAtom.reportWrite(value, super.serverError, () {
      super.serverError = value;
    });
  }

  @override
  String toString() {
    return '''
state: ${state},
serverError: ${serverError}
    ''';
  }
}
