package main

import (
	"music_recommender/server"
	"music_recommender/store"
)

func main()  {
	store.MainStore()
	server := server.Server{}
	server.Start()
}