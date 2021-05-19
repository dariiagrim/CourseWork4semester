package store

import (
	"music_recommender/models"
)

func (s *Store) SelectAllTracks() []*models.Track  {
	tracks := make([]*models.Track, 0)
	_ = s.db.Select(&tracks, "select * from tracks")
	return tracks
}