
function main(src)

	ctx, map_state, stend_info = context_get()
	map_set_state(map_state)
	frame = map_get_frame()
	dst = combine(frame, 0.5, src, 0.5)

	return dst

end

