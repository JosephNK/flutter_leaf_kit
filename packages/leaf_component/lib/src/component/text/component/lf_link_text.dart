part of lf_text;

// Url RegExp
final RegExp kLinkUrlRegExp = RegExp(
  r'(http|https|ftp):\/\/[\w?=&.\/-;#~%-]+(?![\w\s?&.\/;#~%"=-]*>)',
  caseSensitive: false,
);

// Phone Number RegExp
final RegExp kLinkPhoneNumberRegExp = RegExp(
  r'(0[2-6][0-5]?|01[01346-9])?-?([1-9]{1}[0-9]{2,3})-?([0-9]{4})|((080-[0-9]{3,4}|15(44|66|77|88))-[0-9]{4})',
);

// Email RegExp
final RegExp kLinkEmailRegExp = RegExp(
  r'([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})',
);

const TextStyle kLinkTextHighlightStyle = TextStyle(
  color: Colors.blue,
);

enum LFLinkTextType { url, phoneNumber, email }

typedef LFLinkTextOnTap = void Function(
  LFLinkTextType type,
  String? id,
);

class LFLinkText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? styleUrl;
  final TextStyle? stylePhoneNumber;
  final TextStyle? styleEmail;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final double textScaleFactor;
  final List<InlineSpan> leadingSpans;
  final LFLinkTextOnTap? onTap;

  const LFLinkText(
    this.text, {
    Key? key,
    this.style,
    this.styleUrl = kLinkTextHighlightStyle,
    this.stylePhoneNumber = kLinkTextHighlightStyle,
    this.styleEmail = kLinkTextHighlightStyle,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor = 1.0,
    this.leadingSpans = const [],
    this.onTap,
  }) : super(key: key);

  @override
  State<LFLinkText> createState() => _LFLinkTextState();
}

class _LFLinkTextState extends State<LFLinkText> {
  List<TextSpan> _spans = [];

  late double _textScaleFactor;

  @override
  void initState() {
    super.initState();

    _textScaleFactor = widget.textScaleFactor;

    addSpans();
  }

  @override
  void didUpdateWidget(LFLinkText oldWidget) {
    if (oldWidget.textScaleFactor != widget.textScaleFactor) {
      setState(() {
        _textScaleFactor = widget.textScaleFactor;
      });
    }
    if (oldWidget.text != widget.text) {
      addSpans();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return LFRichText(
      text: LFTextSpan(
        children: [...widget.leadingSpans, ..._spans],
        style: widget.style,
      ),
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      textScaleFactor: _textScaleFactor,
    );
  }

  // TextSpans 배열 만들기
  void addSpans() {
    final text = widget.text;
    final regExp = RegExp(
        '(${kLinkUrlRegExp.pattern})|(${kLinkPhoneNumberRegExp.pattern})|(${kLinkEmailRegExp.pattern})');

    List<TextSpan> spans = [];

    text.splitMapJoin(
      regExp,
      onMatch: (Match match) {
        bool isFind = false;
        String value = match[0] ?? '';

        /// Url Type
        addMatchTextSpan(
          value,
          type: LFLinkTextType.url,
          regExp: kLinkUrlRegExp,
          style: widget.styleUrl,
          onMatch: (textSpan) {
            if (isFind) return;
            isFind = true;
            spans.add(textSpan);
          },
          onTap: (type, id) {
            widget.onTap?.call(type, id);
          },
        );

        /// PhoneNumber Type
        addMatchTextSpan(
          value,
          type: LFLinkTextType.phoneNumber,
          regExp: kLinkPhoneNumberRegExp,
          style: widget.stylePhoneNumber,
          onMatch: (textSpan) {
            if (isFind) return;
            isFind = true;
            spans.add(textSpan);
          },
          onTap: (type, id) {
            widget.onTap?.call(type, id);
          },
        );

        /// Email Type
        addMatchTextSpan(
          value,
          type: LFLinkTextType.email,
          regExp: kLinkEmailRegExp,
          style: widget.styleEmail,
          onMatch: (textSpan) {
            if (isFind) return;
            isFind = true;
            spans.add(textSpan);
          },
          onTap: (type, id) {
            widget.onTap?.call(type, id);
          },
        );

        return '';
      },
      onNonMatch: (String text) {
        spans.add(LFTextSpan(text: text));

        return '';
      },
    );

    setState(() => _spans = spans);
  }
}

extension _LFLinkTextStateMatchAddSpan on _LFLinkTextState {
  // Match to span
  void addMatchTextSpan(
    String match, {
    required LFLinkTextType type,
    required RegExp regExp,
    TextStyle? style,
    ValueChanged<TextSpan>? onMatch,
    LFLinkTextOnTap? onTap,
  }) {
    if (match.contains(regExp)) {
      match.splitMapJoin(
        regExp,
        onMatch: (Match match) {
          final name = match.group(0);
          onMatch?.call(LFTextSpan(
            text: name,
            style: style,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap?.call(type, name);
              },
          ));
          return '';
        },
        onNonMatch: (String text) => '',
      );
    }
  }
}
