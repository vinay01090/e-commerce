const mongoose = require('mongoose');
const { productSchema } = require('./product');
const { Double } = require('mongodb');

const orderSchema = mongoose.Schema({
    products: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            },
        },
    ],
    totalPrice: {
        required: true,
        type:Number,
    },
    address: {
        type: String,
        required: true,
    },
    userId: {
        type: String,
        required: true,
    },
    orderedAt: {
        required: true,
        type: Number,
    },
    status: {
        type: Number,
    }
});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order; 