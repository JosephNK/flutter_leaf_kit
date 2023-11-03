part of leaf_bloc;

EventTransformer<Event> debounce<Event>({
  Duration duration = const Duration(milliseconds: 300),
}) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}
