package models

type Product struct {
	ID       int     `json:"id"`
	Name     string  `json:"name"`
	Price    float64 `json:"price"`
	ImageURL string  `json:"image_url"`
}

type ProductDetails struct {
	ID          int     `json:"id"`
	Name        string  `json:"name"`
	Brand       string  `json:"brand"`
	Style       string  `json:"style"`
	Color       string  `json:"color"`
	Size        string  `json:"size"`
	Material    string  `json:"material"`
	Price       float64 `json:"price"`
	Description string  `json:"description"`
}
