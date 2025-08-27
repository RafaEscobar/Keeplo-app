import 'package:equatable/equatable.dart';

enum TokenStatus { initial , verifying, failure, validated }

class TokenState extends Equatable{
  const TokenState({
    this.status = TokenStatus.initial
  });
  final TokenStatus status;

  TokenState copyWith({
    TokenStatus? status
  }) => TokenState(
    status: status ?? this.status
  );

  @override
  List<Object?> get props => [status];
}
