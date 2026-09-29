const express = require("express")
const app = express()
const port = 3000;
app.listen(port, ()=>
{
    console.log("Listening on port 3000")
})

app.get("/", (req,res) =>{
    res.send("Welcome to Camper Bot's homepage!")
})

app.get("/hobbies" ,(req,res) =>{
    res.send("I cycle, go boating, and play guitar.")
})

app.get("/skills", (req,res)=>{
    res.send("JavaScript, Node.js, and Express.js!")
})

app.get("/api/profile", (req,res)=>
{
    const name = "Camper Bot";
    const hobbies = ['cycling','boating','guitar']
    const skills = ['JavaScript','Node.js','Express.js']
    res.json({name,hobbies,skills})
})