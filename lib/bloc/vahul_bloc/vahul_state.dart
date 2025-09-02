import 'package:equatable/equatable.dart';
import 'package:keeplo/models/vahul.dart';

enum VahulStatus { initial, loading, success, failure, searching }
class VahulState extends Equatable{
  final List<Vahul> vahules;
  final List<Vahul> initialVahules;
  final VahulStatus status;
  final String errorMessage;

  const VahulState({
    this.vahules = const [],
    this.initialVahules = const [],
    this.status = VahulStatus.initial,
    this.errorMessage = ''
  });

  VahulState copyWith({
    List<Vahul>? vahules,
    List<Vahul>? initialVahules,
    VahulStatus? status,
    String? errorMessage,
  }) => VahulState(
    vahules: vahules ?? this.vahules,
    initialVahules: initialVahules ?? this.initialVahules,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage
  );

  @override
  List<Object?> get props => [vahules, status, errorMessage, initialVahules];
}
