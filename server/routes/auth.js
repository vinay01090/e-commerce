const express=require("express"); 
const User=require("../models/user"); 
const bcryptjs=require('bcryptjs'); 
const jwt=require('jsonwebtoken');
const auth=require('../middlewares/auth'); 

const authRouter=express.Router(); 

authRouter.post('/api/signup',async(req,res)=>{

    try{
        const {name,email,password}=req.body; 
        const exisitngUser=await User.findOne({email}); 

        if(exisitngUser){
            return res.status(400).json({ message:"user with same email already exist!"}); 
        }

        const hashedPassword=await bcryptjs.hash(password,8); 
        
        let user=new User({
            name,
            email,
            password:hashedPassword
        }); 

        user=await user.save(); 
        res.json(user); 
    }
    catch(e){
        res.status(500).json({error:e.message}); 
    }

}); 


authRouter.post('/api/signin',async(req,res)=>{

    try{
        const {email,password}=req.body; 
        const user= await User.findOne({email}); 

        if(!user){
            return res.status(400).json({message:'User not found'}); 
        }

        const isValidPassword= await bcryptjs.compareSync(password,user.password);
        
        if(!isValidPassword){
            return res.status(400).json({message:'Invalid Password'});
        }

        const token=jwt.sign({id:user._id},'passwordkey'); 

        res.json({token,...user._doc}); 


    }catch(e){
        res.status(500).json({error:e.message}); 
    }
    
});


authRouter.post('/validateToken',async(req,res)=>{

    try{
        const token=req.header('Token');
        if(!token){
            return res.json(false); 
        }
        const isValid=jwt.verify(token,'passwordkey'); 
        if(!isValid){
            return res.json(false); 
        }
        const user=await User.findById(isValid.id); 
        if(!user){
            return res.json(false); 
        }
        return res.json(true); 
    }
    catch(e){
        return res.status(500).json({error:e.message}); 
    }

}); 

authRouter.get('/',auth,async(req,res)=>{
    
    const user=await User.findById(req.user); 
    res.json({...user._doc,token:req.token}); 

}); 

module.exports=authRouter; 