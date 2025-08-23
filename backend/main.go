package main

import (
	"encoding/json"
	"log"
	"net/http"
	"sneaker-backend/database"
	"sneaker-backend/handlers"
	"time"

	"github.com/gorilla/mux"
	"github.com/rs/cors"
)

func main() {
	// Initialize database
	database.InitDB()

	// Setup routes
	router := mux.NewRouter()
	// reg := prometheus.NewRegistry()

	// API routes

	router.HandleFunc("/", func(w http.ResponseWriter, r *http.Request){
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]string{
			"message": "Welcome",
		})
		log.Println("GET: /", time.Now().Format("2006-01-02 15:04:05"))
	}).Methods("GET")
	
	api := router.PathPrefix("/api").Subrouter()

	api.HandleFunc("/products", handlers.GetProducts).Methods("GET")
	api.HandleFunc("/products/{id}", handlers.GetProductDetails).Methods("GET")

	// Setup CORS
	c := cors.New(cors.Options{
		AllowedOrigins: []string{"http://localhost:3000"},
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowedHeaders: []string{"*"},
	})

	// reg.MustRegister(
	// 	collectors.NewGoCollector(),
	// 	collectors.NewProcessCollector(collectors.ProcessCollectorOpts{}),
	// )

	// router.Handle("/metrics", promhttp.HandlerFor(reg, promhttp.HandlerOpts{Registry: reg}))

	handler := c.Handler(router)

	log.Println("Backend server starting on :8080")
	log.Fatal(http.ListenAndServe(":8080", handler))
}
