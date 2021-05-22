package models

import "time"

type Track struct {
	Id int `json:"id" db:"id"`
	Name string `json:"name" db:"name"`
	Popularity float64 `json:"popularity" db:"popularity"`
	ArtistId int64 `json:"artist_id" db:"artist_id"`
	ReleaseDate time.Time `json:"release_date" db:"release_date"`
	Danceability float64 `json:"danceability" db:"danceability"`
	Energy float64 `json:"energy" db:"energy"`
}

type User struct {
	Id int `json:"id" db:"id"`
	Username string `json:"username" db:"username"`
	Age int `json:"age" db:"age"`
}

type Artist struct {
	Id int `json:"id" db:"id"`
	Followers float64 `json:"followers" db:"followers"`
	Genres string `json:"genres" db:"genres"`
	Name string `json:"name" db:"name"`
	Popularity float64 `json:"popularity" db:"popularity"`
}


type Rating struct {
	Id int `json:"id" db:"id"`
	UserId int `json:"user_id" db:"user_id"`
	TrackId int `json:"track_id" db:"track_id"`
	Rating int `json:"rating" db:"rating"`
}