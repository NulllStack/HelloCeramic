package myTools;

class IteratorUtil {
	public static function reversed(iter:IntIterator) {
		var max = @:privateAccess iter.max;
		var min = @:privateAccess iter.min;
		return new ReversedIntIterator(max, min);
	}
}

private class ReversedIntIterator {
	var min:Int;
	var max:Int;

	public inline function new(max, min) {
		this.max = max;
		this.min = min;
	}

	public function hasNext() {
		return max > min;
	}

	public function next() {
		return --max;
	}
}
