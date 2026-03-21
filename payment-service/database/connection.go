package database

import (
	"database/sql"
	"log"
	"os"

	_ "github.com/lib/pq"
)

var DB *sql.DB

func InitDB() {
	var err error
	databaseHost := os.Getenv("DATABASE_HOST")
	DB, err = sql.Open("postgres", "postgres://admin:admin123@"+databaseHost+":5432/logs_db?sslmode=disable")
	if err != nil {
		log.Fatal("Failed to connect to logs database:", err)
	}

	err = DB.Ping()
	if err != nil {
		log.Fatal("Failed to ping logs database:", err)
	}

	log.Println("Connected to logs PostgreSQL database")
}
