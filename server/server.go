package server

import (
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"music_recommender/store"
	"net/http"
)

type Server struct {
	router *gin.Engine
	store *store.Store
}

func (s *Server) Start() error {
	s.router = gin.Default()
	s.router.Use(cors.New(cors.Config{
		AllowAllOrigins: true,
		AllowHeaders: []string{"Content-Type"},
		AllowMethods: []string{"GET", "POST", "DELETE"},
	}))
	if err := s.openStore(); err != nil {
		return err
	}
	defer s.store.Close()
	s.configRouter()
	return s.router.Run(":8080")
}

func (s *Server) openStore() error {
	s.store = &store.Store{}
	if err := s.store.Open(); err != nil {
		return err
	}
	return nil
}

func (s *Server) configRouter()  {
	s.router.GET("/tracks", s.handleAllTracksSelect())
}

func (s *Server) handleAllTracksSelect() gin.HandlerFunc {
	return func(c *gin.Context) {
		tracks := s.store.SelectAllTracks()
		c.JSON(http.StatusOK, gin.H{
			"tracks": tracks,
		})
	}
}
