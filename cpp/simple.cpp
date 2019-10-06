
#define SHARED_OBJECT

#include <cstdio>
#include <cstring>
#include <cstdint>
#include <cstdlib>

#include "interface.h"

using namespace std;

matrix src, src_thr, dst;
int hor_row = 100;

bool is_correct_index(const bool is_param, const unsigned ind)
{
	return ((is_param && ind < 3) || (! is_param && ind < 1));
}

// ############################################################################ 

int EXPORT_FUNCTION init(char * module_name, const unsigned module_name_len, unsigned * param_num, unsigned * return_value_num)
{
	src = NULL;
	src_thr = NULL;
	dst = NULL;

	strncpy(module_name, "simple", module_name_len);
	module_name[module_name_len - 1] = '\0';

	* param_num = 3;
	* return_value_num = 1;

	return 0;
}

int EXPORT_FUNCTION destroy()
{
	return 0;
}

int EXPORT_FUNCTION reset()
{
	return 0;
}

// ############################################################################ 

int EXPORT_FUNCTION get_name(const bool is_param, const unsigned ind, char * name, const unsigned name_len)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	switch(ind)
	{
		case 0:
		{
			strncpy(name, is_param ? "Source image" : "Destination image", name_len);

			break;
		}
		case 1:
		{
			strncpy(name, "Source image - threshold", name_len);

			break;
		}
		case 2:
		{
			strncpy(name, "Rows number", name_len);

			break;
		}
	}

	return 0;
}

int EXPORT_FUNCTION get_type(const bool is_param, const unsigned ind, int * type)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	switch(ind)
	{
		case 0:
		{
			* type = MATRIX_TYPE;

			break;
		}
		case 1:
		{
			* type = MATRIX_TYPE;

			break;
		}
		case 2:
		{
			* type = INT_TYPE;

			break;
		}
	}

	return 0;
}

int EXPORT_FUNCTION get_value(const bool is_param, const unsigned ind, void * value)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	switch(ind)
	{
		case 0:
		{
			* (matrix *) value = is_param ? src : dst;

			break;
		}
		case 1:
		{
			* (matrix *) value = src_thr;

			break;
		}
		case 2:
		{
			* (int *) value = hor_row;

			break;
		}
	}

	return 0;
}

int EXPORT_FUNCTION set_value(const bool is_param, const unsigned ind, const void * value)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	switch(ind)
	{
		case 0:
		{
			if(is_param)
				src = * (matrix *) value;
			else
				dst = * (matrix *) value;

			break;
		}
		case 1:
		{
			src_thr = * (matrix *) value;

			break;
		}
		case 2:
		{
			hor_row = * (int *) value;

			break;
		}
	}

	return 0;
}

// ############################################################################ 

int EXPORT_FUNCTION run()
{
#if 0

	uint8_t value;
	unsigned v, u, t, height, width, ch_num;
	
	matrix_height(src, & height);
	matrix_width(src, & width);
	matrix_number_of_channels(src, & ch_num);
	
	dst = matrix_copy(src, 1);

	for(v = hor_row; v < height; v++)
		for(u = 0; u < width; u++)
			for(t = 0; t < ch_num; t++)
			{
				matrix_get_value(src_thr, v, u, t, & value);
				matrix_set_value(dst, v, u, t, & value);
			}

#else

	context ctx = context_get();

	printf("x = %lf y = %lf h = %lf course = %lf roll = %lf pitch = %lf aspect_x = %lf aspect_y = %lf coord_system = %d frame_ind = %u frame_num = %u src_video_fname = [%s] dst_video_fname = [%s] map_fname = [%s] height_map_fname = [%s]\n",
			ctx->map_state.x, ctx->map_state.y, ctx->map_state.h, ctx->map_state.course, ctx->map_state.roll, ctx->map_state.pitch, ctx->map_state.aspect_x, ctx->map_state.aspect_y, ctx->map_state.coord_system,
			ctx->frame_ind, ctx->frame_num, ctx->src_video_fname, ctx->dst_video_fname, ctx->map_fname, ctx->height_map_fname);

	ctx->map_state.h = 1200;
	ctx->map_state.course = 0;
	ctx->map_state.roll = 0;
	ctx->map_state.pitch = -90;

	map_set_state(& ctx->map_state);
 	// 62, 46
 	// 69.1, 47.3

	dst = map_get_frame();

	printf("0x%X\n", dst);

#endif

	return 0;
}

