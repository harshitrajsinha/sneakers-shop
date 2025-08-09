package main

import (
	"log"
	"net/http"
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
	c := cors.New(cors.Options{
		AllowedOrigins: []string{"http://localhost:3000"},
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"*"},
	})

	handler := c.Handler(router)

	log.Println("Payment service starting on :8081")
	log.Fatal(http.ListenAndServe(":8081", handler))
}
