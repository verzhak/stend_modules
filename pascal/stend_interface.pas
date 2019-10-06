
unit stend_interface;

interface

	uses types;

	type
		
		p_void = pointer;
		pp_void = ^ p_void;
		int = dword;
		p_int = ^int;
		unsigned = dword;
		p_unsigned = ^unsigned;
		p_double = ^double;
		p_char = pchar;
		matrix = pointer;
		p_matrix = ^matrix;
		
		s_map_state = record

			x : double;
			y : double;
			h : double;
			course : double;
			roll : double;
			pitch : double;
			aspect_x : double;
			aspect_y : double;
			coord_system : unsigned;

		end;

		map_state = ^s_map_state;

		s_context = record
			
			frame_ind : unsigned;
			frame_num : unsigned;
			src_video_fname : array [0..4095] of char;
			dst_video_fname :  array [0..4095] of char;
			map_fname :  array [0..4095] of char;
			height_map_fname : array [0..4095] of char;
			map_state : s_map_state;
		
		end;
		
		context = ^s_context;
		
		t_matrix_create = function(height : unsigned; width : unsigned; ch_num : unsigned; element_type : int) : matrix; cdecl;
		t_matrix_delete = function(mtx : matrix) : int; cdecl;
		t_matrix_copy = function(mtx : matrix; is_copy_data : int) : matrix; cdecl;
		t_matrix_load_image = function(fname : pchar) : matrix; cdecl;
		t_matrix_save_image = function(mtx : matrix; fname : pchar) : int; cdecl;
		t_matrix_get_value = function(mtx : matrix; row : unsigned; column : unsigned; channel : unsigned; value : p_void) : int; cdecl;
		t_matrix_set_value = function(mtx : matrix; row : unsigned; column : unsigned; channel : unsigned; value : p_void) : int; cdecl;
		t_matrix_height = function(mtx : matrix; value : p_unsigned) : int; cdecl;
		t_matrix_width = function(mtx : matrix; value : p_unsigned) : int; cdecl;
		t_matrix_number_of_channels = function(mtx : matrix; value : p_unsigned) : int; cdecl;
		t_matrix_element_type = function(mtx : matrix; value : p_int) : int; cdecl;
		t_matrix_pointer_to_data = function(mtx : matrix; value : pp_void) : int; cdecl;
		t_matrix_pointer_to_row = function(mtx : matrix; row : unsigned; value : pp_void) : int; cdecl;
		
		t_map_set_state = function(state : map_state) : int; cdecl;
		t_map_get_state = function(state : map_state) : int; cdecl;
		t_map_get_frame = function() : matrix; cdecl;
		
		t_context_get = function() : context; cdecl;
		t_context_create_variable = function(name : p_char; tp : int) : int; cdecl;
		t_context_set_value = function(name : p_char; value : p_void; value_size : unsigned) : int; cdecl;
		t_context_get_value = function(name : p_char; value : p_void; value_size : unsigned) : int; cdecl;
		
		t_combine_quality = function(contour : matrix) : double; cdecl;
		t_skeleton = function(mtx : matrix) : matrix; cdecl;

	const
	
		{ Типы элементов матриц }
	
		UNSIGNED_INT_8_BIT_ELEMENT = 0;
		UNSIGNED_INT_16_BIT_ELEMENT = 2;
		DOUBLE_ELEMENT = 1;

		{ ############################################################################ }
		{ Типы входных и выходных параметров алгоритма }
	
		INT_TYPE = 0;
		DOUBLE_TYPE = 1;
		STRING_TYPE = 2;
		BOOLEAN_TYPE = 3;
		MATRIX_TYPE = 4;
		VOID_POINTER_TYPE = 5;

		{ ############################################################################ }
		{ Типы систем координат }

		CT_GL = 0;
		CT_GEO = 2;
		CT_GAUSS_KRUEGER = 3;

	var

		{$IFDEF FPC}

			matrix_create : t_matrix_create export;
			matrix_delete : t_matrix_delete export;
			matrix_copy : t_matrix_copy export;
			matrix_load_image : t_matrix_load_image export;
			matrix_save_image : t_matrix_save_image export;
			matrix_get_value : t_matrix_get_value export;
			matrix_set_value : t_matrix_set_value export;
			matrix_height : t_matrix_height export;
			matrix_width : t_matrix_width export;
			matrix_number_of_channels : t_matrix_number_of_channels export;
			matrix_element_type : t_matrix_element_type export;
			matrix_pointer_to_data : t_matrix_pointer_to_data export;
			matrix_pointer_to_row : t_matrix_pointer_to_row export;
		
			map_set_state : t_map_set_state export;
			map_get_state : t_map_get_state export;
			map_get_frame : t_map_get_frame export;
		
			context_get : t_context_get export;
			context_create_variable : t_context_create_variable export;
			context_set_value : t_context_set_value export;
			context_get_value : t_context_get_value export;
		
			combine_quality : t_combine_quality export;
			skeleton : t_skeleton export;

		{$ELSE}

			matrix_create : t_matrix_create;
			matrix_delete : t_matrix_delete;
			matrix_copy : t_matrix_copy;
			matrix_load_image : t_matrix_load_image;
			matrix_save_image : t_matrix_save_image;
			matrix_get_value : t_matrix_get_value;
			matrix_set_value : t_matrix_set_value;
			matrix_height : t_matrix_height;
			matrix_width : t_matrix_width;
			matrix_number_of_channels : t_matrix_number_of_channels;
			matrix_element_type : t_matrix_element_type;
			matrix_pointer_to_data : t_matrix_pointer_to_data;
			matrix_pointer_to_row : t_matrix_pointer_to_row;
		
			map_set_state : t_map_set_state;
			map_get_state : t_map_get_state;
			map_get_frame : t_map_get_frame;
		
			context_get : t_context_get;
			context_create_variable : t_context_create_variable;
			context_set_value : t_context_set_value;
			context_get_value : t_context_get_value;
		
			combine_quality : t_combine_quality;
			skeleton : t_skeleton;
		
		{$ENDIF}

implementation

end.

