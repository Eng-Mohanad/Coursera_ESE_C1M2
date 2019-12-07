#------------------------------------------------------------------------------
# [FILENAME]:		Makefile
# [BRIEF]:		_ Makefile for Coursera ESE Course.1 Week.2 Assessment.
# 			_ File used to build a system with support of 2 target
# 			_ platforms and their specific compilers (HOST &
# 			_ MSP432).
# [AUTHOR]:		Mohanad M. Marzouk
# [CREATED ON]:		Dec. 5, 2019
#
# [USE]:		make [TARGET] [OVERRIDES]
# [BUILD TARGETS]:
# 	<FILE>.o _ builds <FILE>.o object file.
# 	<FILE>.asm _ builds <FILE>.asm assembler output file.
# 	<FILE>.i _ builds <FILE>.i preprocessor output file.
# 	build _ builds and links all source files.
# 	all _ same as build.
# 	clean _ removes all generated files.
# [OVERRIDES]:
# 	MSP432 _ cross compilation for MSP432 platform.
# 	HOST _ native compilation to be tested on HOST platform.
# -----------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM = HOST

# Compiler Flags & Defines

#------------------------------------------------------------------------------
# Compiler Flags Description:
# 	-Wall: Enable all warning messages.
# 	-Werror: Treat all warnings as errors.
# 	-g: generate debugging information in executable.
# Linker Flags Description:
# 	-O0: disable linker optimizations.
# 	-std=c99: use c99 standard.
#------------------------------------------------------------------------------

COMCFLAGS = -Wall -Werror -g -O0 -std=c99
TARGET = c1m2

# Platform Conditional Execution
ifeq ($(PLATFORM), MSP)
	LINKER_FILE = -T msp432p401r.lds
	LINKER_PATH = -L ../
	CPU = cortex-m4
	ARCH = armv7e-m
	SPECS = nosys.specs
	ARCHFLAGS = -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16
	
	# architecture specific flags and includes
	SOURCES = main.c \
		  memory.c \
		  interrupts_msp432p401r_gcc.c \
		  startup_msp432p401r_gcc.c \
		  system_msp432p401r_gcc.c

	CC = arm-none-eabi-gcc
	CPPFLAGS = -DMSP432 $(INCLUDES)
	CFLAGS = $(COMCFLAGS) $(ARCHFLAGS) -mcpu=$(CPU) -march=$(ARCH) --specs=$(SPECS)
	LDFLAGS = -Wl,-Map=$(TARGET).map $(LINKER_PATH) $(LINKER_FILE)
	SIZE = arm-none-eabi-size -Ad

else
	CC = gcc
	CFLAGS = $(COMCFLAGS)
	CPPFLAGS = -DHOST $(INCLUDES)
	LDFLAGS = -Wl,-Map=$(TARGET).map
	SIZE = size -Ad

endif

# build target variables
OBJS = $(SOURCES:.c=.o)
DEPS = $(SOURCES:.c=.d)
ASM = $(SOURCES:.c=.s)
PREP = $(SOURCES:.c=.i)

# pattern matching

# object file output
%.o : %.c
	$(CC) -c $< $(CPPFLAGS) $(CFLAGS) -o $@

# dependency file output
%.d : %.c
	$(CC) -E -M $< $(CPPFLAGS) -o $@

# assembly file output
%.asm : %.c
	$(CC) -S $< $(CPPFLAGS) $(CFLAGS) -o $@

# preprocessor file output
%.i : %.c
	$(CC) -E $< $(CPPFLAGS) -o $@

# Make targets

.PHONY: all
all: $(OBJS)

.PHONY: build
build: $(DEPS)
build: $(TARGET).out

$(TARGET).out: $(OBJS)
	$(CC) $(OBJS) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@
	$(SIZE) $@

.PHONY: clean
clean:
	rm -f $(OBJS) $(DEPS) $(ASM) $(PREP) $(TARGET).out $(TARGET).map

# End of file
