CC = gcc
AR = ar
CFLAGS = -Wall -fPIC
LD = ld
LDFLAGS = -shared

FONTES_C = a.c b.c c.c d.c
OBJS_C  = $(FONTES_C:%.c=%.o)

mainShared: libMySharedLib.so  main.c
	$(CC) main.c -lMySharedLib -L. -o $@

libMySharedLib.so: $(OBJS_C)
	 $(LD) $(LDFLAGS) -o $@ $(OBJS_C)

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@




all: mainShared main

clean:
	rm -f libMySharedLib.so mainShared  $(OBJS_C)
