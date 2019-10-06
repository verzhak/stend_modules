
unit stend_delphi;

interface

	uses stend_interface, windows, graphics;

	{ TODO single channel }
	{ TODO pf32bit }
	function matrix_to_TBitmap(mtx : matrix) : TBitmap;
	function TBitmap_to_matrix(bmp : TBitmap) : matrix;

implementation

	function matrix_to_TBitmap(mtx : matrix) : TBitmap;
	var
		
		height, width, v : unsigned;
		ptr : p_void;
		bmp : TBitmap;

	begin
		
		matrix_height(mtx, @ height);
		matrix_width(mtx, @ width);
		
		bmp := TBitmap.Create;
		bmp.Height := height;
		bmp.Width := width;
		bmp.PixelFormat := pf24bit;

		width := width * 3;
		
		for v := 0 to height - 1 do
		begin
			
			matrix_pointer_to_row(mtx, v, @ ptr);
			CopyMemory(bmp.ScanLine[v], ptr, width);
		
		end;

		matrix_to_TBitmap := bmp;
	
	end;

	{ ############################################################################ }

	function TBitmap_to_matrix(bmp : TBitmap) : matrix;
	var
		
		height, width, v : unsigned;
		mtx : matrix;
		ptr : p_void;

	begin

		height := bmp.Height;
		width := bmp.Width;

		mtx := matrix_create(height, width, 3, UNSIGNED_INT_8_BIT_ELEMENT);
		width := width * 3;

		for v := 0 to height - 1 do
		begin
			
			matrix_pointer_to_row(mtx, v, @ ptr);
			CopyMemory(ptr, bmp.ScanLine[v], width);

		end;
		
		TBitmap_to_matrix := mtx;

	end;

end.

