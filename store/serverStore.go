package store

import (
	"fmt"
	"log"
	"music_recommender/models"
	"strconv"
)

func (s *Store) SelectAllTracks() []*models.Track  {
	tracks := make([]*models.Track, 0)
	_ = s.db.Select(&tracks, "select * from tracks limit 10")
	return tracks
}

func (s *Store) CreateUser(user *models.User) (int, error) {
	_, err := s.db.Exec("insert into users(username, age) values($1, $2)", user.Username, user.Age)
	if err != nil {
		fmt.Println(err)
		return 0, err
	}
	var count int
	err = s.db.Get(&count, "SELECT id FROM users order by id desc limit 1;")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(count)
	return count, nil
}

func (s *Store) SelectTrackById(id string) *models.Track  {
	idInt, _ := strconv.Atoi(id)
	track := &models.Track{}
	_ = s.db.Get(track, "select * from tracks where id = $1", idInt)
	return track
}

func (s *Store) SelectArtistById(id int64) *models.Artist  {
	artist := &models.Artist{}
	_ = s.db.Get(artist, "select * from artists where id = $1", id)
	return artist
}

func (s *Store) SelectUserByUsername(username string) *models.User  {
	user := &models.User{}
	_ = s.db.Get(user, "select * from users where username = $1", username)
	return user
}

func (s *Store) CreateRating(rating *models.Rating) error {
	_, err := s.db.Exec("insert into ratings(user_id, track_id, rating) values($1, $2, $3)", rating.UserId, rating.TrackId, rating.Rating)
	if err != nil {
		fmt.Println(err)
		return err
	}
	return nil
}

func (s *Store) SelectRatedByUserTracks(userId int) []int {
	tracks := make([]int, 0)
	_ = s.db.Select(&tracks, "select track_id from ratings where user_id = $1", userId)
	return tracks
}