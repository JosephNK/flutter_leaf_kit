part of '../../leaf_store.dart';

EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
