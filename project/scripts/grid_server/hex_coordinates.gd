@warning_ignore_start("shadowed_variable")

class Axial:
	var q: float
	var r: float
	
	func _init(q: float, r: float) -> void:
		self.q = q
		self.r = r
	
	func from_cubic(cubic: Cubic) -> Axial:
		var q = cubic.q
		var r = cubic.r
		return Axial.new(q, r)
		

class Cubic:
	var q: float
	var r: float
	var s: float
	
	func _init(q: float, r: float, s: float) -> void:
		self.q = q
		self.r = r
		self.s = s
	
	func from_axial(axial: Axial) -> Cubic:
		var q = axial.q
		var r = axial.r
		var s = -q-r
		return Cubic.new(q, r, s)
