abstract class VahulEvent {}


class VahulNewPageEvent extends VahulEvent {
  final int newPage;
  VahulNewPageEvent(this.newPage);
}

class SearchVahulEvent extends VahulEvent {
  final String text;
  SearchVahulEvent(this.text);
}

class OrderListEvent extends VahulEvent {}
class GetVahulesEvent extends VahulEvent {}
class LoadMoreVahulesEvent extends VahulEvent {}
class VahulCleanBloc extends VahulEvent {}