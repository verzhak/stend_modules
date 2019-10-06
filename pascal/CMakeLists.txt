
cmake_minimum_required(VERSION 2.8)

project(pascal)
set(lazarus /usr/lib/lazarus)

if(${UNIX})

	set(arch x86_64-linux)

	add_custom_command(OUTPUT simple_pascal.out
		COMMAND
		/usr/bin/fpc ${CMAKE_CURRENT_SOURCE_DIR}/simple.pas -CD -olibsimple.so -FE${CMAKE_CURRENT_BINARY_DIR}
		-B  -MObjFPC -Scghi -vewnhi -dLCL
		# -O2
		-g -gl
		-Fi${CMAKE_CURRENT_BINARY_DIR}
		-Fu${lazarus}/lcl/units/${arch}
		-Fu${lazarus}/components/lazutils/lib/${arch}
		-Fu${lazarus}/packager/units/${arch}
		-FU${CMAKE_CURRENT_BINARY_DIR})
	add_custom_target(simple_pascal ALL DEPENDS simple_pascal.out)

endif()

