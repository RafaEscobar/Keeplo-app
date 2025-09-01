import 'package:equatable/equatable.dart';
import 'package:keeplo/models/user.dart';

enum TokenStatus { initial , verifying, failure, validated }

class TokenState extends Equatable{
  const TokenState({
    this.status = TokenStatus.initial,
    this.userTemp
  });
  final TokenStatus status;
  final User? userTemp;

  TokenState copyWith({
    TokenStatus? status,
    User? userTemp
  }) => TokenState(
    status: status ?? this.status,
    userTemp: userTemp ?? this.userTemp
  );

  @override
  List<Object?> get props => [status, userTemp];
}
