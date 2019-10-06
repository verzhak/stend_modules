
function main(src)

	contour = Canny(src, 20, 100, 3)
	ctx, map_state, stend_info = context_get()

	map_set_state(map_state)
	frame = map_get_frame()
	dst = combine(frame, 0.5, src, 0.5)
	
	io.write("combine quality = ", combine_quality(contour), "\n")

	return dst

end

