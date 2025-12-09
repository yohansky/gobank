package gapi

import (
	"fmt"
	db "gobank/db/sqlc"
	"gobank/pb"
	"gobank/token"
	"gobank/util"
)

// server serves gRPC request for banking service
type Server struct {
	pb.UnimplementedGoBankServer
	config     util.Config
	store      db.Store
	tokenMaker token.Maker
}

func NewServer(config util.Config, store db.Store) (*Server, error) {
	tokenMaker, err := token.NewJWTMaker(config.TokenSymmectricKey)
	if err != nil {
		return nil, fmt.Errorf(`cannot create token maker: %w`, err)
	}
	server := &Server{
		config:     config,
		store:      store,
		tokenMaker: tokenMaker,
	}

	return server, nil
}
