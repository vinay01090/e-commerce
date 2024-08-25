const jwt=require('jsonwebtoken'); 

const auth=async(req,res,next)=>{
    try{
    const token=req.header('Token');
    if(!token){
        return res.status(401).json({message:"No validation token ,unauthorized"});
    }

    const isValid=jwt.verify(token,'passwordkey'); 
    if(!isValid){
        return res.status(401).json({message:"Token verification Failed!,unauthorized acess"}); 
    }

    req.user=isValid.id; 
    req.token=token; 

    next(); 
    
}catch(e){
    res.status(500).json({error:e.message}); 
}
};

module.exports=auth; 