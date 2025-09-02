abstract class VahulEvent {}

class GetVahulesEvent extends VahulEvent {}

class SearchVahulEvent extends VahulEvent {
  final String text;
  SearchVahulEvent(this.text);
}