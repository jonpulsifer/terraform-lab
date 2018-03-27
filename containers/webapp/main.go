package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
)

// simple golang webserver that
// serves environment variables on http://:8080/
func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "HEY TERRAFORMLAB\n")
		fmt.Fprintf(w, "----------------\n")
		fmt.Fprintf(w, "k8s MY_NODE_NAME\t%s\n", os.Getenv("MY_NODE_NAME"))
		fmt.Fprintf(w, "k8s MY_POD_NAME:\t%s\n", os.Getenv("MY_POD_NAME"))
		fmt.Fprintf(w, "k8s MY_POD_NAMESPACE:\t%s\n", os.Getenv("MY_POD_NAMESPACE"))
		fmt.Fprintf(w, "k8s MY_POD_IP:\t%s\n", os.Getenv("MY_POD_IP"))
		fmt.Fprintf(w, "k8s MY_POD_SERVICE_ACCOUNT:\t%s\n", os.Getenv("MY_POD_SERVICE_ACCOUNT"))
	})
	go func(msg string) {
		// print some stuff to stdout
		fmt.Println("LETSGO")
		fmt.Println("------")
		for {
			t := time.Now()
			fmt.Println(t.Format("2006-01-02 15:04:05"), msg)
			time.Sleep(5 * time.Second)
		}
	}("ohi there :)")
	log.Fatal(http.ListenAndServe(":8080", nil))
}
