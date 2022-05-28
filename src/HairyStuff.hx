import hxnoise.Perlin;
import ceramic.Color;
import ceramic.AlphaColor;
import ceramic.Scene;
import ceramic.Line;

class HairyStuff extends Scene {
	var fibre_brick:FibreBrick;

	override function create() {
		super.create();
		fibre_brick = new FibreBrick(width / 3.5, height / 4, 100, 100);
	}

	override function update(delta:Float) {
		super.update(delta);
		fibre_brick.update();
	}
}

class FibreBrick {
	var brick = new Array<Array<Fibre>>();
	var width:Int;
	var height:Int;
	var x:Float;
	var y:Float;

	var step:Float = 0;
	var noiseStep = 0.01;
	var noiseOffset = 0.03;

	var xStep:Float = 0;
	var yStep:Float = 0;
	var xOffset:Float = 0;
	var yOffset:Float = 0;

	var perlinNoise:Perlin = new Perlin();

	public function new(x:Float, y:Float, width_amount:Int, height_amount:Int) {
		this.x = x;
		this.y = y;

		for (x in 0...width_amount) {
			var temp_arr = new Array<Fibre>();
			for (y in 0...height_amount) {
				var fibre = new Fibre(x * 2.8 + this.x, y * 2.8 + this.y);
				app.scenes.main.add(fibre);
				temp_arr.push(fibre);
			}
			brick.push(temp_arr);
		}
	}

	public function update() {
		step += noiseStep;

		xStep += noiseStep;
		yStep += noiseStep;

		xOffset = xStep;
		for (x in 0...100) {
			yOffset = yStep;
			for (y in 0...100) {
				var factor = noise(xOffset, yOffset);
				brick[x][y].update(factor);
				yOffset += noiseOffset;
			}
			xOffset += noiseOffset;
		}
	}

	function noise(x:Float, ?y:Float = 0, ?z:Float = 0) {
		return perlinNoise.OctavePerlin(x, y, z, 4, 0.55, 0.45);
		// return perlinNoise.OctavePerlin(x, y, z, 5, 0.55, 0.45);
	}
}

class Fibre extends Line {
	var start_x:Float;
	var start_y:Float;

	var end_x:Float;
	var end_y:Float;

	var radians:Float = 0;
	var radius:Float = 50;

	static inline var LENGTH:Float = 50;

	public function new(startX:Float, startY:Float, c:Color = Color.BLACK) {
		super();
		start_x = startX;
		start_y = startY;

		end_x = start_x + LENGTH;
		end_y = start_y + LENGTH;

		thickness = 2;
		this.color = c;
	}

	public function update(noiseFactor:Float) {
		radians = noiseFactor * (2 * Math.PI);
		radius = LENGTH * noiseFactor;
		alpha = noiseFactor;
		var c = Color.fromRGBFloat(noiseFactor, noiseFactor, noiseFactor);
		color = c;

		end_x = start_x + (radius * Math.sin(radians));
		end_y = start_y + (radius * Math.cos(radians));

		points = [start_x, start_y, end_x, end_y];
	}
}
