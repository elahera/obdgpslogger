SET(OBD_SIMGEN_GUI_FLTK "On" CACHE BOOL "Enable FLTK GUI obdsim generator")
	
IF(NOT OBD_DISABLE_GUI)
	IF(NOT FLTK_FLUID_EXECUTABLE)
		MESSAGE(STATUS "Couldn't find fluid: required for building obdsim fltk gui")
	ENDIF(NOT FLTK_FLUID_EXECUTABLE)
	
	IF(NOT FLTK_FOUND)
		MESSAGE(STATUS "Couldn't find fltk: required for building obdsim fltk gui")
	ENDIF(NOT FLTK_FOUND)
	
	IF(FLTK_FOUND AND FLTK_FLUID_EXECUTABLE)
		INCLUDE_DIRECTORIES(
			./generators/gui_fltk/
			${FLTK_INCLUDE_DIR}
		)
	
		IF(OBD_SIMGEN_GUI_FLTK)
	
			ADD_DEFINITIONS(-DOBDSIMGEN_GUI_FLTK)
	
			FILE(GLOB FLTK_SIM_GUI_FL_GLOB generators/gui_fltk/*.fl )
			# GLOB includes a bunch of path prefix which confuses FLTK_WRAP_UI
			FOREACH(FLTK_SIM_GUI_FL_SRC ${FLTK_SIM_GUI_FL_GLOB})
				GET_FILENAME_COMPONENT(ONE_FL_SRC ${FLTK_SIM_GUI_FL_SRC} NAME)
				SET(FLTK_SIM_GUI_FL_SRCS ${FLTK_SIM_GUI_FL_SRCS} generators/gui_fltk/${ONE_FL_SRC})
			ENDFOREACH(FLTK_SIM_GUI_FL_SRC)
	
			FLTK_WRAP_UI(ckobdsim_gui_fltk ${FLTK_SIM_GUI_FL_SRCS})
	
			ADD_LIBRARY(ckobdsim_gui_fltk STATIC ${ckobdsim_gui_fltk_FLTK_UI_SRCS})
	
			SET(GENERATOR_LIBS ${GENERATOR_LIBS} ckobdsim_gui_fltk ${FLTK_LIBRARIES} stdc++)
	
		ENDIF(OBD_SIMGEN_GUI_FLTK)
	ENDIF(FLTK_FOUND AND FLTK_FLUID_EXECUTABLE)
ENDIF(NOT OBD_DISABLE_GUI)