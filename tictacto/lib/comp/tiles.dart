import 'package:flutter/material.dart';

class TilesView extends StatefulWidget {
  const TilesView(
      {super.key, required this.tlist, required this.pos, required this.sizW});
  final List<int> tlist;
  final List<double> sizW;
  final int pos;

  @override
  State<TilesView> createState() => _TilesViewState();
}

class _TilesViewState extends State<TilesView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: widget.tlist[widget.pos] == 1
                  ? Colors.blueAccent
                  : widget.tlist[widget.pos] == 2
                      ? Colors.red
                      : Colors.black,
              width: widget.tlist[widget.pos] == 0 ? 0.2 : 2)),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.sizW[widget.pos],
          width: widget.sizW[widget.pos],
          color: Colors.amber[50],
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                border: Border.all(
                    color: widget.tlist[widget.pos] == 1
                        ? Colors.blueAccent
                        : widget.tlist[widget.pos] == 2
                            ? Colors.red
                            : Colors.black,
                    width: widget.tlist[widget.pos] == 0 ? 0.2 : 2)),
            child: Center(
              child: Text(
                widget.tlist[widget.pos] == 0
                    ? " "
                    : widget.tlist[widget.pos] == 1
                        ? 'X'
                        : '0',
                style: TextStyle(
                    fontSize: 85,
                    fontWeight: FontWeight.bold,
                    color: widget.tlist[widget.pos] == 1
                        ? Colors.blueAccent
                        : widget.tlist[widget.pos] == 2
                            ? Colors.red
                            : Colors.black38),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
