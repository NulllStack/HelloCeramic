import ceramic.Color;
import ceramic.Mesh;
import ceramic.Quad;
import ceramic.Line;
import ceramic.Scene;

// import element.Im;

class Test extends Scene {
	override function create() {
		var line = new Line();
		// var c = line.color.setRGBFloat(1, 1, 1);
		add(line);
	}

	override function update(delta:Float) {
		super.update(delta);
	}
}

class MyLine extends Line {
	public function new() {
        
		super();
		// color.setRGBFloat(1, 1, 1);
	}
}
