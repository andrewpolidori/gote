package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"unicode/utf8"

	"github.com/pkg/term"
)

// We open a terminal in rawMode (saving us some of the effort of the tutorial)
func makeTerminal() (*term.Term, error) {
	return term.Open(os.Stdin.Name(), term.Speed(19200), term.RawMode)
}

//die
func die(message string) {
	log.Fatalln("Error: %s", message)
}

func main() {
	terminal, err := makeTerminal()
	defer terminal.Restore()
	if err != nil {
		panic(err)
	}
	scanner := bufio.NewScanner(terminal)
	scanner.Split(bufio.ScanRunes)

	for scanner.Scan() {
		if string(scanner.Bytes()) == "q" {
			fmt.Println("Quit received, quitting.")
			break
		}
		r, size := utf8.DecodeRune(scanner.Bytes())
		if r == utf8.RuneError {
			if size == 0 {
				panic("DecodeRune was empty")
			} else if size == 1 {
				panic("Encoding is invalid")
			}
		}

		fmt.Printf("rune: %U int: %d character: '(%c)' hex: %x size: %d\r\n", r, r, r, r, size)

	}
}
