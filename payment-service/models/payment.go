package models

import "time"

type PaymentRequest struct {
	ProductID int     `json:"product_id"`
	UserID    int     `json:"user_id"`
	Amount    float64 `json:"amount"`
}

type PaymentResponse struct {
	Status        string `json:"status"`
	TransactionID string `json:"transaction_id"`
	Message       string `json:"message"`
}

type PaymentLog struct {
	ID            int       `json:"id"`
	ProductID     int       `json:"product_id"`
	UserID        int       `json:"user_id"`
	Amount        float64   `json:"amount"`
	Status        string    `json:"status"`
	TransactionID string    `json:"transaction_id"`
	Timestamp     time.Time `json:"timestamp"`
}
