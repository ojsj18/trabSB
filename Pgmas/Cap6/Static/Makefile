CC = gcc
AR = ar
CFLAGS = -Wall


FONTES_C = a.c b.c c.c d.c
OBJS_C  = $(FONTES_C:%.c=%.o)

mainStatic: libMyStaticLib.a  main.c
	$(CC) main.c -lMyStaticLib -L. -o $@

libMyStaticLib.a: $(OBJS_C)
	 $(AR) -src $@ $(OBJS_C)

main:  $(OBJS_C) main.c
	$(CC) $(OBJS_C) main.c -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@




all: mainStatic main

clean:
	rm -f  main libMyStaticLib.a $(OBJS_C)
