package main

import (
	"encoding/csv"
	"fmt"
	_ "github.com/jackc/pgx/stdlib"
	"github.com/jmoiron/sqlx"
	"io"
	"log"
	"os"
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

func main() {
	store := &Store{}
	_ = store.Open()
	defer store.Close()
	print(getTableSlice("tracks.csv", 5))
}

func getTableSlice(fileName string, rowsNumber int) [][]string {
	a := make([][]string, 0)
	b := make([]string, 0)
	file, err := os.Open(fmt.Sprintf("./dalaFiles/%s", fileName))
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