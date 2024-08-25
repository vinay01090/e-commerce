const express=require('express'); 
const mongoose=require('mongoose'); 
const app=express(); 
const PORT=3000; 
const DB="mongodb+srv://vinay:2020vkshk@cluster0.yxqoump.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"; 

const authRouter=require('./routes/auth'); 
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

app.use(express.json()); 
app.use(authRouter); 
app.use(adminRouter); 
app.use(productRouter); 
app.use(userRouter); 


mongoose.connect(DB).then(()=>{
    console.log('connection successful'); 
}).catch((e)=>{
    console.log(e); 
}); 

app.listen(PORT,"0.0.0.0",()=>{
    console.log(`Connected at port ${PORT}`); 
}); 