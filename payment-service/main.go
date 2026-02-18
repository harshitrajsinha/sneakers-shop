package main

import (
	"log"
	"net/http"
	"os"
	"payment-service/database"
	"payment-service/handlers"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
)

func main() {
	// Initialize database
	database.InitDB()

	// Setup routes
	router := mux.NewRouter()

	// API routes
	api := router.PathPrefix("/api").Subrouter()
	api.HandleFunc("/payment/process", handlers.ProcessPayment).Methods("POST")

	// Setup CORS
	serverIP := os.Getenv("SERVER_IP")
	c := cors.New(cors.Options{
		AllowedOrigins: []string{"http://%s:3000", serverIP},
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"*"},
	})

	handler := c.Handler(router)

	log.Println("Payment service starting on :8081")
	log.Fatal(http.ListenAndServe(":8081", handler))
}
