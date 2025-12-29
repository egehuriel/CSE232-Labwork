CC = gcc
CFLAGS = -Wall -Wextra -std=c11
BIN = myprg

all: $(BIN)

$(BIN): myprg.c
	$(CC) $(CFLAGS) -o $(BIN) myprg.c

preprocess: myprg.c
	$(CC) -E myprg.c -o expanded.c
	
show: preprocess
	head -n 20 expanded.c
	
clean:
	@echo
	@rm -f $(BIN) expanded.c
	@echo "CLEANING"
	@echo
	
.PHONY: all clean process show
