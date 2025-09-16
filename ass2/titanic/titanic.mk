CFLAGS =

ifneq (, $(shell which dcc))
CC	?= dcc
else
CC	?= clang
CFLAGS += -Wall
endif

EXERCISES	  += titanic

SRC = titanic.c titanic_main.c titanic_provided.c
INCLUDES = titanic.h

# if you add extra .c files, add them here
SRC +=

# if you add extra .h files, add them here
INCLUDES +=


titanic:	$(SRC) $(INCLUDES)
	$(CC) $(CFLAGS) $(SRC) -o $@
