<template>
  <div class="product-card">
    <img :src="product.image_url" :alt="product.name" class="product-image" />
    <div class="product-name">{{ product.name }}</div>
    <div class="product-price">₹{{ product.price }}</div>
    <div class="button-group">
      <button
        class="btn btn-details"
        @click="$emit('show-details', product.id)"
      >
        Details
      </button>
      <button class="btn btn-buy" @click="$emit('buy-product', product)">
        Buy
      </button>
    </div>
  </div>
</template>

<script>
export default {
  name: "ProductCard",
  props: {
    product: {
      type: Object,
      required: true,
    },
  },
  emits: ["show-details", "buy-product"],
};
</script>
