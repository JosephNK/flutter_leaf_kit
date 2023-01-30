part of leaf_container_component;

class LeafAnimationContainer extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const LeafAnimationContainer({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: AnimatedBackground(),
        ),
        onBottom(const AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(const AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(const AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Positioned.fill(
          child: Stack(
            children: [
              CenteredText(
                text: text,
                textStyle: textStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget onBottom(Widget child) => Positioned.fill(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      );
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  const AnimatedWave({
    Key? key,
    required this.height,
    required this.speed,
    this.offset = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        height: height,
        width: constraints.biggest.width,
        child: LoopAnimationBuilder<double>(
            duration: (5000 / speed).round().milliseconds,
            tween: 0.0.tweenTo(2 * pi),
            builder: (context, value, child) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.white.withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

enum _BgProps { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MovieTween()
      ..tween(_BgProps.color1,
          const Color(0xffD38312).tweenTo(Colors.lightBlue.shade900))
      ..tween(_BgProps.color2,
          const Color(0xffA83279).tweenTo(Colors.blue.shade600));

    return MirrorAnimationBuilder<Movie>(
      tween: tween,
      duration: 3.seconds,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [value.get(_BgProps.color1), value.get(_BgProps.color2)],
            ),
          ),
        );
      },
    );
  }
}

class CenteredText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;

  const CenteredText({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LeafText(
        text,
        style: textStyle,
        textScaleFactor: 3,
      ),
    );
  }
}
