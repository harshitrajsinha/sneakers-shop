package main

import (
	"log"
	"net/http"
	"sneaker-backend/database"
	"sneaker-backend/handlers"

	"github.com/gorilla/mux"
	"github.com/rs/cors"

	"github.com/prometheus/client_golang/prometheus/collectors"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

func main() {
	// Initialize database
	database.InitDB()

	// Setup routes
	router := mux.NewRouter()
	reg := prometheus.NewRegistry()

	// API routes
	api := router.PathPrefix("/api").Subrouter()
	api.HandleFunc("/products", handlers.GetProducts).Methods("GET")
	api.HandleFunc("/products/{id}", handlers.GetProductDetails).Methods("GET")

	// Setup CORS
	c := cors.New(cors.Options{
		AllowedOrigins: []string{"http://localhost:3000"},
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"*"},
	})

	reg.MustRegister(
		collectors.NewGoCollector(),
		collectors.NewProcessCollector(collectors.ProcessCollectorOpts{}),
	)

	router.Handle("/metrics", promhttp.HandlerFor(reg, promhttp.HandlerOpts{Registry: reg}))

	handler := c.Handler(router)

	log.Println("Backend server starting on :8080")
	log.Fatal(http.ListenAndServe(":8080", handler))
}
