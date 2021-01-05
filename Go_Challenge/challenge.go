package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	colorGreen := "\033[32m"
	fileServer := http.FileServer(http.Dir("./static"))
	http.Handle("/", fileServer)
	fmt.Println(string(colorGreen), "Hello frog\n")
	fmt.Println(string(colorGreen), "Starting server at port 9090\n")
	if err := http.ListenAndServe(":9090", nil); err != nil {
		log.Fatal(err)
	}
}
