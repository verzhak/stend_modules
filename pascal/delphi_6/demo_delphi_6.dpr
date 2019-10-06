library demo_delphi_6;

uses
	
	Windows,
	stend_interface in 'stend_interface.pas';

{$R *.res}

{$LIBPREFIX '../build/lib'}

var
	
	src, dst : image;

function init(module_name : p_char; module_name_len : unsigned; param_num : p_unsigned; return_value_num : p_unsigned) : int; cdecl;
begin
	
	strcopy(module_name, 'demo_delphi_6');
	param_num^ := 1;
	return_value_num^ := 1;
	
	init := 0;

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
	
	tp^ := 5;
	get_type := 0;

end;

function get_value(is_param : boolean; ind : unsigned; value : p_void) : int; cdecl;
begin
	
	if is_param then
		
		p_image(value)^ := src
	
	else
		
		p_image(value)^ := dst;
	
	get_value := 0;

end;

function set_value(is_param : boolean; ind : unsigned; value : p_void) : int; cdecl;
begin
	
	if is_param then
		
		src := p_image(value)^
	
	else
		
		dst := p_image(value)^;
	
	set_value := 0;

end;

function run : int; cdecl;
var
	
	ctx : context;

begin
	
	ctx := context_get();
	
	vector_map_set_coord(ctx^.x, ctx^.y, ctx^.h, ctx^.course, ctx^.roll, ctx^.pitch);
	vector_map_set_aspect(ctx^.aspect_x, ctx^.aspect_y);
	
	dst := vector_map_get_frame();
	
	run := 0;

end;

exports

image_create				name	'image_create',
image_delete				name	'image_delete',
image_copy					name	'image_copy',
matrix_to_image				name	'matrix_to_image',
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
vector_map_set_coord		name	'vector_map_set_coord',
vector_map_get_coord		name	'vector_map_get_coord',
vector_map_set_aspect		name	'vector_map_set_aspect',
vector_map_get_aspect		name	'vector_map_get_aspect',
vector_map_get_frame		name	'vector_map_get_frame',
context_get					name	'context_get', 
context_get_value			name	'context_get_value',

init						name	'init',
destroy						name	'destroy',
run							name	'run',
get_name					name	'get_name',
get_type					name	'get_type',
get_value					name	'get_value',
set_value					name	'set_value';

procedure dll_proc(id : integer);
begin

	;

end;

begin

	DLLProc := @dll_proc;

end.

