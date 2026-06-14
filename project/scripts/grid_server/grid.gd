extends Node

## sqrt(3)
const C_SQRT_3 = sqrt(3)
## 3 / 2
const C_3_2 = 3.0 / 2.0

enum HexOrientation {
	FLAT_TOP,
	POINTY_TOP
}

## Size of the grid, refers to the outer radius
var grid_size: float = 10
## Orientation of the hex grid, 45 degree offsets
var grid_orientation: HexOrientation = HexOrientation.FLAT_TOP

# ------- TILE DIMENSIONS -------

## Returns the width of a single tile
func width() -> float:
	match grid_orientation:
		HexOrientation.FLAT_TOP:
			return 2 * grid_size
		HexOrientation.POINTY_TOP:
			return C_SQRT_3 * grid_size
	return 0 # To appease error checker

## Returns the height of a single tile
func height() -> float:
	match grid_orientation:
		HexOrientation.FLAT_TOP:
			return C_SQRT_3 * grid_size
		HexOrientation.POINTY_TOP:
			return 2 * grid_size
	return 0 # To appease error checker

## Returns the horizontal distance between tile centers
func horizontal_spacing() -> float:
	match grid_orientation:
		HexOrientation.FLAT_TOP:
			return C_3_2 * grid_size
		HexOrientation.POINTY_TOP:
			return C_SQRT_3 * grid_size
	return 0 # To appease error checker

## Returns the vertical distance between tile centers
func vertical_spacing() -> float:
	match grid_orientation:
		HexOrientation.FLAT_TOP:
			return C_SQRT_3 * grid_size
		HexOrientation.POINTY_TOP:
			return C_3_2 * grid_size
	return 0 # To appease error checker

#func to_grid(pos: Vector3) -> Vector3:
	#var grid = pos / grid_size
	#return grid
#
#func to_grid_snapped(pos: Vector3) -> Vector3:
	#var grid = to_grid(pos)
	#return grid.snapped(Vector3.ONE)
#
#func to_coord(grid: Vector3) -> Vector3:
	#var coord = grid * grid_size
	#return coord
#
#func to_coord_snapped(grid: Vector3) -> Vector3:
	#var coord = to_coord(grid)
	#return coord.snapped(Vector3.ONE)

## Returns the position of the [param i]th corner (CW, starting at top) of a tile with a given [param center] (Coord)
func corner(center: Vector2, i: float) -> Vector2:
	var angle_deg = 60 * i - (30 if grid_orientation == HexOrientation.POINTY_TOP else 0)
	var angle_rad = deg_to_rad(angle_deg)
	return Vector2(
		center.x + grid_size*cos(angle_rad),
		center.y + grid_size*sin(angle_rad)
	)
