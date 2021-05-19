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