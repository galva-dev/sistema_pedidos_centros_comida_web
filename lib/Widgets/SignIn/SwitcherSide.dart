import 'package:flutter/material.dart';

class SwitcherSide extends StatefulWidget {
  const SwitcherSide({
    Key key,
    @required Animation<double> animation,
    @required this.containerWidth,
    @required this.welcomeText,
    @required AnimationController controller,
    @required this.width,
    @required this.alignText,
  }) : _animation = animation, _controller = controller, super(key: key);

  final Animation<double> _animation;
  final double containerWidth;
  final double welcomeText;
  final AnimationController _controller;
  final double width;
  final double alignText;

  @override
  _SwitcherSideState createState() => _SwitcherSideState();
}

class _SwitcherSideState extends State<SwitcherSide> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(widget._animation.value, 0.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width:
        MediaQuery.of(context).size.width * 0.37 + widget.containerWidth,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login/4496585.jpg'),
            fit: BoxFit.cover,
            alignment: Alignment(widget._animation.value, 0.0),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment(widget.welcomeText, -0.35),
                    child: Container(
                      width: 350.0,
                      height: 250.0,
                      child: Column(
                        children: [
                          Text(
                            widget._animation.value > 0.0
                                ? 'Que placer volver a verte!'
                                : 'Bienvenido!',
                            style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            widget._animation.value > 0.0
                                ? 'Inicia sesion para poder atender a los clientes'
                                : 'Inicia sesion para poder administrar tu centro de comida',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  setState(() {
                    if (widget._controller.isCompleted) {
                      widget._controller.reverse();
                    } else {
                      widget._controller.forward();
                    }
                  });
                },
                child: Container(
                  height: 60.0,
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border:
                    Border.all(color: Colors.white, width: 2.0),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment(widget.alignText, 0.0),
                          child: Opacity(
                            opacity: (widget._animation.value < 0.0)
                                ? widget._animation.value.abs()
                                : 0.0,
                            child: Text(
                              'Soy empleado',
                              style: TextStyle(
                                fontSize: 17.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(widget.alignText, 0.0),
                          child: Opacity(
                            opacity: (widget._animation.value > 0.0)
                                ? widget._animation.value.abs()
                                : 0.0,
                            child: Text(
                              'Soy administrador',
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}