const mongoose = require('mongoose');

const userSchema = new mongoose.Schema ({
    username:{
        type:String,
        required:true,
        unique:true,
        trim:true,
    },
    email:{
        type:String,
        required:true,
        unique:true,
        lowercase:true,
        trim:true,
    },
    fullName:{
        type:String,
        default:"",
        required:true,
        trim:true,
    },
    phone:{
        type:String,
        default:"",
        required:true,
        trim:true,
    },
    password:{
        type:String,
        required:true,
        trim:true,
        minlength:8,
    },
    address:{
        street:{type:String, default:""},
        city:{type:String, default:""},
        province:{type:String, default:""},
        postalCode:{type:String, default:""},
    },
    role:{
        type:String,
        enum:["user","admin"],
        default:"user",
    },
    createAt:{
        type:Date,
        default:Date.now,
    },
    
},
{
    versionKey:false,
}
);

module.exports = mongoose.model('User', userSchema);