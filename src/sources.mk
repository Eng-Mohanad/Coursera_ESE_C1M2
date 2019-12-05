#------------------------------------------------------------------------------
# [FILENAME]:		sources.mk
# [DESCRIPTION]:	_ make include file for recursively expanded variables.
# [AUTHOR]:		Mohanad M. Marzouk
# [CREATED ON]:		Dec. 5, 2019
#------------------------------------------------------------------------------

SOURCES = main.c \
	  memory.c

INCLUDES = -I../include/CMSIS \
	   -I../include/common \
	   -I../include/msp432

# End of file
