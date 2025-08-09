package handlers

import (
	"encoding/json"
	"net/http"
	"sneaker-backend/database"
	"sneaker-backend/models"
	"strconv"

	"github.com/gorilla/mux"
)

func GetProducts(w http.ResponseWriter, r *http.Request) {
	query := `SELECT id, name, price, image_url FROM products ORDER BY id LIMIT 20`

	rows, err := database.DB.Query(query)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var products []models.Product
	for rows.Next() {
		var product models.Product
		err := rows.Scan(&product.ID, &product.Name, &product.Price, &product.ImageURL)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		products = append(products, product)
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(products)
}

func GetProductDetails(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	id, err := strconv.Atoi(vars["id"])
	if err != nil {
		http.Error(w, "Invalid product ID", http.StatusBadRequest)
		return
	}

	query := `SELECT id, name, brand, style, color, size, material, price, description 
			  FROM products WHERE id = $1`

	var product models.ProductDetails
	err = database.DB.QueryRow(query, id).Scan(
		&product.ID, &product.Name, &product.Brand, &product.Style,
		&product.Color, &product.Size, &product.Material,
		&product.Price, &product.Description,
	)

	if err != nil {
		http.Error(w, "Product not found", http.StatusNotFound)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(product)
}
