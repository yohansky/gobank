package api

import (
	db "gobank/db/sqlc"

	"github.com/gin-gonic/gin"
	"github.com/gin-gonic/gin/binding"
	"github.com/go-playground/validator/v10"
)

type Server struct {
	store db.Store
	router *gin.Engine
}

func NewServer(store db.Store) *Server {
	server := &Server{store: store}
	router := gin.Default()

	if v, ok := binding.Validator.Engine().(*validator.Validate); ok {
		v.RegisterValidation("currency", validatorCurrency)
	}

	// Add routes to router
	router.POST("/users",server.createUser )

	router.POST("/accounts",server.createAccount )
	router.GET("/account/:id",server.getAccount )
	router.GET("/account",server.listAccount )

	router.POST("/transfers",server.createTransfer )

	server.router = router
	return server
}

// running port
func (server *Server) Start(address string) error {
	return server.router.Run(address)
}

func errorResponse(err error) gin.H {
	return gin.H{"error": err.Error()}
}