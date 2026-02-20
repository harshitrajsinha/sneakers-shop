<template>
  <div class="container">
    <div class="header">
      <h1>Premium Sneaker Collection</h1>
      <p>Discover the latest trends in footwear</p>
    </div>

    <div v-if="loading" class="loading">Loading products...</div>

    <div v-else class="products-grid">
      <ProductCard
        v-for="product in products"
        :key="product.id"
        :product="product"
        @show-details="showProductDetails"
        @buy-product="buyProduct"
      />
    </div>

    <!-- Details Modal -->
    <div
      id="detailsModal"
      class="modal"
      :style="{ display: showModal ? 'block' : 'none' }"
    >
      <div class="modal-content">
        <span class="close" @click="closeModal">&times;</span>
        <h2>Product Details</h2>
        <div v-if="selectedProductDetails">
          <div class="detail-item">
            <strong>Brand:</strong> {{ selectedProductDetails.brand }}
          </div>
          <div class="detail-item">
            <strong>Style:</strong> {{ selectedProductDetails.style }}
          </div>
          <div class="detail-item">
            <strong>Color:</strong> {{ selectedProductDetails.color }}
          </div>
          <div class="detail-item">
            <strong>Size:</strong> {{ selectedProductDetails.size }}
          </div>
          <div class="detail-item">
            <strong>Material:</strong> {{ selectedProductDetails.material }}
          </div>
          <div class="detail-item">
            <strong>Price:</strong> ₹{{ selectedProductDetails.price }}
          </div>
          <div class="detail-item">
            <strong>Description:</strong>
            {{ selectedProductDetails.description }}
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import ProductCard from "./components/ProductCard.vue";

export default {
  name: "App",
  mounted() {
    console.log(process.env.VUE_APP_SERVER_IP);
  },
  components: {
    ProductCard,
  },
  data() {
    return {
      products: [],
      loading: true,
      showModal: false,
      selectedProductDetails: null,
    };
  },
  async mounted() {
    await this.loadProducts();
  },
  methods: {
    async loadProducts() {
      try {
        const response = await axios.get(`http://${import.meta.env.VUE_APP_SERVER_IP}:8080/api/products`);
        // const response = await axios.get(`http://localhost:8080/api/products`);
        console.log("here again", import.meta.env.VITE_SERVER_IP)
        this.products = response.data;
        this.loading = false;
      } catch (error) {
        console.error("Error loading products:", error);
        this.loading = false;
      }
    },
    async showProductDetails(productId) {
      try {
        const response = await axios.get(
          `http://${process.env.VUE_APP_SERVER_IP}:8080/api/products/${productId}`
          // `http://localhost:8080/api/products/${productId}`
        );
        this.selectedProductDetails = response.data;
        this.showModal = true;
      } catch (error) {
        console.error("Error loading product details:", error);
      }
    },
    async buyProduct(product) {
      try {
        const paymentData = {
          product_id: product.id,
          amount: product.price,
          user_id: 1, // Mock user ID
        };

        const response = await axios.post(
          "http://${process.env.VUE_APP_SERVER_IP}:8081/api/payment/process",
          // "http://localhost:8081/api/payment/process",
          paymentData
        );

        if (response.data.status === "success") {
          alert(`Payment successful for ${product.name}!`);
        } else {
          alert("Payment failed. Please try again.");
        }
      } catch (error) {
        console.error("Payment error:", error);
        alert("Payment failed. Please try again.");
      }
    },
    closeModal() {
      this.showModal = false;
      this.selectedProductDetails = null;
    },
  },
};
</script>
