import 'package:equatable/equatable.dart';
import 'package:keeplo/models/vahul.dart';

enum VahulStatus { initial, loading, success, failure, searching }
class VahulState extends Equatable{
  final List<Vahul> vahules;
  final List<Vahul> initialVahules;
  final VahulStatus status;
  final String errorMessage;
  final bool hasOrder;

  const VahulState({
    this.vahules = const [],
    this.initialVahules = const [],
    this.status = VahulStatus.initial,
    this.errorMessage = '',
    this.hasOrder = false,
  });

  VahulState copyWith({
    List<Vahul>? vahules,
    List<Vahul>? initialVahules,
    VahulStatus? status,
    String? errorMessage,
    bool? hasOrder,
  }) => VahulState(
    vahules: vahules ?? this.vahules,
    initialVahules: initialVahules ?? this.initialVahules,
    status: status ?? this.status,
    errorMessage: errorMessage ?? this.errorMessage,
    hasOrder: hasOrder ?? this.hasOrder
  );

  @override
  List<Object?> get props => [vahules, status, errorMessage, initialVahules, hasOrder];
}
