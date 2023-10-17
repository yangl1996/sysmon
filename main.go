package main

import (
	"fmt"
	"net/http"
	"os/exec"
	"time"
)

func status(w http.ResponseWriter, req *http.Request) {
	cmd := exec.Command("/bin/sh", "./graph.sh")
	cmd.Stdout = w
	err := cmd.Run()
	if err != nil {
		fmt.Println(err)
	}
}

func main() {
	http.HandleFunc("/status", status)
	ticker := time.NewTicker(1 * time.Second)
	go func() {
		for range ticker.C {
			cmd1 := exec.Command("/bin/sh", "./update_resource.sh")
			err := cmd1.Run()
			if err != nil {
				fmt.Println(err)
			}
			cmd2 := exec.Command("/bin/sh", "./update_progress.sh")
			err = cmd2.Run()
			if err != nil {
				fmt.Println(err)
			}
		}
	}()

	http.ListenAndServe(":9999", nil)
}
