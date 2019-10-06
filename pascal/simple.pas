
library simple;

uses stend_interface, strings;

var

	src, dst : matrix;

function init(module_name : p_char; module_name_len : unsigned; param_num : p_unsigned; return_value_num : p_unsigned) : int; cdecl;
begin

	strcopy(module_name, 'simple_pascal');
	param_num^ := 1;
	return_value_num^ := 1;
	
	init := 0;

end;

function reset : int; cdecl;
begin
	
	reset := 0;

end;

function destroy : int; cdecl;
begin
	
	destroy := 0;

end;

function get_name(is_param : boolean; ind : unsigned; name : p_char; name_len : unsigned) : int; cdecl;
begin
	
	if is_param then
		
		strcopy(name, 'Source image')
	
	else
		
		strcopy(name, 'Destination image');
	
	get_name := 0;

end;

function get_type(is_param : boolean; ind : unsigned; tp : p_int) : int; cdecl;
begin
	
	tp^ := MATRIX_TYPE;
	get_type := 0;

end;

function get_value(is_param : boolean; ind : unsigned; value : p_void) : int; cdecl;
begin
	
	if is_param then
		
		p_matrix(value)^ := src
	
	else
		
		p_matrix(value)^ := dst;
	
	get_value := 0;

end;

function set_value(is_param : boolean; ind : unsigned; value : p_void) : int; cdecl;
begin
	
	if is_param then
		
		src := p_matrix(value)^
	
	else
		
		dst := p_matrix(value)^;
	
	set_value := 0;

end;

function run : int; cdecl;
var
	
	ctx : context;

begin
	
	ctx := context_get();
	map_set_state(@ ctx^.map_state);
	dst := map_get_frame();

	run := 0;

end;

	exports

		matrix_create				name	'matrix_create',
		matrix_delete				name	'matrix_delete',
		matrix_copy					name	'matrix_copy',
		matrix_load_image			name	'matrix_load_image',
		matrix_save_image			name	'matrix_save_image',
		matrix_get_value			name	'matrix_get_value',
		matrix_set_value			name	'matrix_set_value',
		matrix_height				name	'matrix_height',
		matrix_width				name	'matrix_width',
		matrix_number_of_channels	name	'matrix_number_of_channels',
		matrix_element_type			name	'matrix_element_type',
		matrix_pointer_to_data		name	'matrix_pointer_to_data',
		matrix_pointer_to_row		name	'matrix_pointer_to_row',  

		map_set_state				name	'map_set_state',
		map_get_state				name	'map_get_state',
		map_get_frame				name	'map_get_frame',

		context_get					name	'context_get', 
		context_create_variable		name	'context_create_variable',
		context_set_value			name	'context_set_value',
		context_get_value			name	'context_get_value',

		combine_quality				name	'combine_quality',
		skeleton					name	'skeleton',

		init						name	'init',
		reset						name	'reset',
		destroy						name	'destroy',
		run							name	'run',
		get_name					name	'get_name',
		get_type					name	'get_type',
		get_value					name	'get_value',
		set_value					name	'set_value';

end.

