package server

import (
	"fmt"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"music_recommender/models"
	"music_recommender/store"
	"net/http"
	"strconv"
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
	s.router.POST("/create", s.handleCreateUser())
	s.router.POST("/rate", s.handleRateTrack())
	s.router.GET("/id", s.handleTrackByIdSelect())
	s.router.GET("/username", s.handleUserExistence())
	s.router.GET("/rated", s.handleRatedByUserTracks())
}

func (s *Server) handleAllTracksSelect() gin.HandlerFunc {
	return func(c *gin.Context) {
		tracks := s.store.SelectAllTracks()
		c.JSON(http.StatusOK, gin.H{
			"tracks": tracks,
		})
	}
}

func (s *Server) handleCreateUser() gin.HandlerFunc {
	return func(c *gin.Context) {
		var user models.User
		if err := c.ShouldBindJSON(&user); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"message": err.Error(),
			})
			return
		}

		count, err := s.store.CreateUser(&user)
		if err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"message": err.Error(),
			})
			return
		}

 		c.JSON(http.StatusCreated, gin.H {
			"id": count,
		})
	}
}

func (s *Server) handleTrackByIdSelect() gin.HandlerFunc {
	return func(c *gin.Context) {
		id := c.Query("id")
		track := s.store.SelectTrackById(id)
		artist := s.store.SelectArtistById(track.ArtistId)
		c.JSON(http.StatusOK, gin.H{
			"track": track,
			"artist": artist,
		})
	}
}

func (s *Server) handleUserExistence() gin.HandlerFunc {
	return func(c *gin.Context) {
		username := c.Query("username")
		user := s.store.SelectUserByUsername(username)
		c.JSON(http.StatusOK, gin.H{
			"user": user,
		})
	}
}

func (s *Server) handleRateTrack() gin.HandlerFunc {
	return func(c *gin.Context) {
		var rating models.Rating
		if err := c.ShouldBindJSON(&rating); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"message": err.Error(),
			})
			return
		}
		fmt.Println(rating.UserId)
		if err := s.store.CreateRating(&rating); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{
				"message": err.Error(),
			})
			return
		}

		c.JSON(http.StatusCreated, gin.H{
			"message": "ok",
		})
	}
}

func (s *Server) handleRatedByUserTracks() gin.HandlerFunc {
	return func(c *gin.Context) {
		userId := c.Query("user_id")
		id, _ := strconv.Atoi(userId)
		tracks := s.store.SelectRatedByUserTracks(id)
		c.JSON(http.StatusOK, gin.H{
			"tracks": tracks,
		})
	}
}