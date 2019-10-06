
#define SHARED_OBJECT

#include <cstdio>
#include <cstring>
#include <cstdint>
#include <cstdlib>

#include <opencv2/opencv.hpp>

#include "interface.h"

using namespace std;
using namespace cv;

matrix src, dst;

bool is_correct_index(const bool is_param, const unsigned ind)
{
	return ind < 1;
}

// ############################################################################ 

int EXPORT_FUNCTION init(char * module_name, const unsigned module_name_len, unsigned * param_num, unsigned * return_value_num)
{
	src = NULL;
	dst = NULL;

	strncpy(module_name, "opencv", module_name_len);
	module_name[module_name_len - 1] = '\0';

	* param_num = 1;
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

	strncpy(name, is_param ? "Source image" : "Destination image", name_len);

	return 0;
}

int EXPORT_FUNCTION get_type(const bool is_param, const unsigned ind, int * type)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	* type = MATRIX_TYPE;

	return 0;
}

int EXPORT_FUNCTION get_value(const bool is_param, const unsigned ind, void * value)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	* (matrix *) value = is_param ? src : dst;

	return 0;
}

int EXPORT_FUNCTION set_value(const bool is_param, const unsigned ind, const void * value)
{
	if(! is_correct_index(is_param, ind))
		return -1;

	if(is_param)
		src = * (matrix *) value;
	else
		dst = * (matrix *) value;

	return 0;
}

// ############################################################################ 

int EXPORT_FUNCTION run()
{
	dst = matrix_copy(src, 0);
	threshold(* (Mat *) src, * (Mat *) dst, 150, 255, THRESH_BINARY);

	return 0;
}

