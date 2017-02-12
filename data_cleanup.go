package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"os"
)

func main() {
	flag.Parse()
	args := flag.Args()
	if len(args) != 2 {
		fmt.Println("usage: ./data_cleanup input.txt output.csv")
		os.Exit(1)
	}
	inFile, err := os.Open(args[0])
	defer inFile.Close()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	rd := bufio.NewReader(inFile)

	outFile, err := os.Create(args[1])
	defer outFile.Close()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	wr := bufio.NewWriter(outFile)

	var r, lastR rune

	for err == nil {
		r, _, err = rd.ReadRune()
		if err != nil {
			break
		}
		switch r {
		case '"':
			switch lastR {
			case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
				wr.WriteString(" inch")
			}
		case '~':
		case '^':
			wr.WriteByte('\t')
		default:
			wr.WriteRune(r)
		}

		lastR = r
	}

	if err != io.EOF {
		fmt.Println(err)
		os.Exit(1)
	}

	wr.Flush()
}
