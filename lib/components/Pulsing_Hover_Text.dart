import 'package:flutter/material.dart';

class PulsingHoverText extends StatefulWidget {
  final String text;
  final double fontSize; // базовый размер шрифта

  const PulsingHoverText(
    this.text, {
    super.key,
    this.fontSize = 16,
  });

  @override
  State<PulsingHoverText> createState() => _PulsingHoverTextState();
}

class _PulsingHoverTextState extends State<PulsingHoverText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  bool _isHovering = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setHovering(bool hovering) {
    setState(() {
      _isHovering = hovering;
    });
  }

  double _adaptiveFontSize(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Пример адаптации: масштабируем базовый размер шрифта в зависимости от ширины экрана
    if (screenWidth < 320) {
      return widget.fontSize * 0.8; // маленькие экраны, например старые iPhone SE
    } else if (screenWidth < 400) {
      return widget.fontSize * 0.9;
    } else if (screenWidth < 600) {
      return widget.fontSize;
    } else {
      return widget.fontSize * 1.2; // большие экраны
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = _isHovering ? Colors.deepPurpleAccent.shade100 : Colors.white70;
    final scale = _isHovering ? 1.05 : 1.0;
    final adaptiveFontSize = _adaptiveFontSize(context);

    return MouseRegion(
      onEnter: (_) => _setHovering(true),
      onExit: (_) => _setHovering(false),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return AnimatedScale(
            scale: scale,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Text(
              widget.text,
              style: TextStyle(
                color: baseColor,
                fontSize: adaptiveFontSize,
                fontWeight: FontWeight.w700,
                height: 1.5,
                shadows: [
                  Shadow(
                    color: Colors.deepPurple.withOpacity(_animation.value),
                    blurRadius: 15,
                    offset: const Offset(0, 0),
                  ),
                  Shadow(
                    color: Colors.deepPurple.withOpacity(_animation.value * 0.7),
                    blurRadius: 20,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
