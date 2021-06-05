package database

import (
	"context"
	"cuckoo-pay/api"
	"cuckoo-pay/rpc"
	"net/http"
)

var client api.ApiService

func SetCuckooClient(ctx context.Context, addr string) error {
	api, _, err := rpc.NewHttpClient(ctx, addr, http.Header{})
	if err != nil {
		return err
	}
	client = api
	return nil
}

func GetCuckooClient() api.ApiService {
	return client
}
