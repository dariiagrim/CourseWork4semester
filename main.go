package main

import (
	"encoding/csv"
	"fmt"
	_ "github.com/jackc/pgx/stdlib"
	"github.com/jmoiron/sqlx"
	"io"
	"log"
	"os"
	"strconv"
	"time"
)


type Store struct {
	db *sqlx.DB
}

func (s *Store) Open() error {
	db, err := sqlx.Connect("pgx", "postgres://dariia:DDG256@localhost:5432/music_recommender?sslmode=disable")
	if err != nil {
		log.Fatalln(err)
	}
	s.db = db
	return nil
}

func (s *Store) Close()  {
	_ = s.db.Close()
}

func (s *Store) addTracks(tracksSlice [][]interface{}, trackArtistId map[string]int) error {
	for _, valueSlice := range tracksSlice {
		artistId := trackArtistId[fmt.Sprintf("%v", valueSlice[3])]
		fmt.Println(artistId)
		if artistId == 0 {
			continue
		}
		_, err := s.db.Exec("insert into tracks(name, popularity, artist_id, release_date, danceability, energy) values($1, $2, $3, $4, $5, $6)", valueSlice[1], valueSlice[2], artistId, valueSlice[4], valueSlice[5], valueSlice[6])
		if err != nil {
			fmt.Println(err)
			return err
		}
	}
	return nil
}

func (s *Store) addArtists(artistsSlice [][]interface{}, trackArtistId map[string]int) error {
	for index, valueSlice := range artistsSlice {
		trackArtistId[fmt.Sprintf("%v", valueSlice[0])] = index + 1
		_, err := s.db.Exec("insert into artists(followers, genres, name, popularity) values($1, $2, $3, $4)", valueSlice[1], valueSlice[2], valueSlice[3], valueSlice[4])
		if err != nil {
			fmt.Println(err)
			return err
		}
	}
	return nil
}

func main() {
	store := &Store{}
	_ = store.Open()
	defer store.Close()
	tracksSlice, artists := getTracksSlice()
	artistsSlice := getArtistsSlice(artists)
	fmt.Println(len(artistsSlice))
	trackArtistId := make(map[string]int)
	store.addArtists(artistsSlice, trackArtistId)
	store.addTracks(tracksSlice, trackArtistId)


}

func getTracksSlice() ([][]interface{}, map[string][]string) {
	tempTracks := getTableSlice("tracks.csv", 20)
	artistsTracksMap := make(map[string][]string)
	result := make([][]interface{}, 0)
	for i := 1; i < len(tempTracks); i++ {
		temp := make([]interface{}, 0)
		temp = append(temp, tempTracks[i][0])
		temp = append(temp, tempTracks[i][1])
		pop, err := strconv.ParseFloat(tempTracks[i][2], 64)
		if err != nil {
			pop = 0.0
		}
		if pop <= 50 {
			continue
		}
		temp = append(temp, pop)
		artistId := ""
		for _, char := range tempTracks[i][6] {
			if char == ',' {
				break
			}
			if char != '[' && char != ']' && char != '\'' {
				artistId += string(char)
			}
		}
		artistsTracksMap[artistId] = append(artistsTracksMap[artistId], tempTracks[i][0])
		temp = append(temp, artistId)
		parsedTime, err := time.Parse("2006-01-02", tempTracks[i][7])
		if err != nil {
			parsedTime = time.Now()
		}
		temp = append(temp, parsedTime)
		dance, err := strconv.ParseFloat(tempTracks[i][8], 64)
		if err != nil {
			dance = 0.0
		}
		temp = append(temp, dance)
		energy, err := strconv.ParseFloat(tempTracks[i][9], 64)
		if err != nil {
			energy = 0.0
		}
		temp = append(temp, energy)
		result = append(result, temp)

	}

	return result, artistsTracksMap
}

func getArtistsSlice(artistsTrackMap map[string][]string) [][]interface{} {
	tempArtists := getTableSlice("artists.csv", 5)
	result := make([][]interface{}, 0)
	for i := 1; i < len(tempArtists); i++ {
		temp := make([]interface{}, 0)
		if len(artistsTrackMap[tempArtists[i][0]]) == 0 {
			continue
		}
		temp = append(temp, tempArtists[i][0])
		followers, err := strconv.ParseFloat(tempArtists[i][1], 64)
		if err != nil {
			followers = 0.0
		}
		temp = append(temp, followers)
		temp = append(temp, tempArtists[i][2])
		temp = append(temp, tempArtists[i][3])
		pop, err := strconv.ParseFloat(tempArtists[i][4], 64)
		if err != nil {
			pop = 0.0
		}
		temp = append(temp, pop)
		result = append(result, temp)
	}
	return result
}


func getTableSlice(fileName string, rowsNumber int) [][]string {
	a := make([][]string, 0)
	b := make([]string, 0)
	file, err := os.Open(fmt.Sprintf("./dataFiles/%s", fileName))
	if err != nil {
		log.Fatalln("Couldn't open the csv file", err)
	}
	r := csv.NewReader(file)
	for {
		b = []string{}
		record, err := r.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			log.Fatal(err)
		}
		for i := 0; i < rowsNumber; i++ {
			b = append(b, record[i])
		}
		a = append(a, b)
	}
	return a
}