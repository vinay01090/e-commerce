const jwt=require('jsonwebtoken'); 
const User=require('../models/user'); 

const admin=async(req,res,next)=>{
    try{
        const token=req.header('Token'); 
        if(!token){
            return res.status(401).json({message:"No Validation,Unauthorized"}); 
        }

        const isValid=jwt.verify(token,'passwordkey'); 

        if(!isValid){
            return res.status(401).json({message:"Token Validation Failed! ,Unauthorized"}); 
        }

        const user=await User.findById(isValid.id); 

        if(user.type=='user'){
            return res.status(401).json({message:"Only Admin can access"}); 
        }

        req.user=isValid.id; 
        req.token=token; 

        next();
    }
    catch(e){
        res.status(500).json({error:e.message}); 
    }

}

module.exports=admin; 


