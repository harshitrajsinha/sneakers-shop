package handlers

import (
	"encoding/json"
	"fmt"
	"math/rand"
	"net/http"
	"payment-service/database"
	"payment-service/models"
	"time"
)

func ProcessPayment(w http.ResponseWriter, r *http.Request) {
	var paymentReq models.PaymentRequest

	err := json.NewDecoder(r.Body).Decode(&paymentReq)
	if err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	// Simulate payment processing
	transactionID := fmt.Sprintf("TXN_%d_%d", time.Now().Unix(), rand.Intn(10000))

	// Simulate success/failure (90% success rate)
	success := rand.Float32() < 0.9

	status := "success"
	message := "Payment processed successfully"

	if !success {
		status = "failed"
		message = "Payment processing failed"
	}

	// Log the payment attempt
	logPayment(paymentReq, status, transactionID)

	response := models.PaymentResponse{
		Status:        status,
		TransactionID: transactionID,
		Message:       message,
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func logPayment(req models.PaymentRequest, status, transactionID string) {
	query := `INSERT INTO payment_logs (product_id, user_id, amount, status, transaction_id, timestamp) 
			  VALUES ($1, $2, $3, $4, $5, $6)`

	_, err := database.DB.Exec(query, req.ProductID, req.UserID, req.Amount, status, transactionID, time.Now())
	if err != nil {
		fmt.Printf("Error logging payment: %v\n", err)
	}
}
