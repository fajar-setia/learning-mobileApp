import jwt from "jsonwebtoken";

export default function verifyAdmin(res, req, next){
    try{
        const authHeader = req.headers.authorization;
    const token = authHeader && authHeader.split(" ")[1];

    if(!token){
        return res.status(401).json({message: "Akses Ditolak, Token tidak ditemukan..."});
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    if(decoded.role != "Admin"){
        return res.status(403).json({message: "Akses Ditolak, Anda bukan admin..."});
    }

    req.user = decoded;

    next();
    }catch(err){
        console.log("Error Verify Admin", err);
        res.status(401).json({message: "Token tidak valid"});
    }

}