let usernameInput = document.querySelector(".username-input")
let ageInput = document.querySelector(".age-input")
let newUserButton = document.querySelector(".new-user-btn")
let notNewUserButton = document.querySelector(".not-new-user-btn")
let ratingsContainer = document.querySelector(".ratings-container")
let rateButton = document.querySelector(".rate-btn")


let songIds = []
let songRatings = []


let createUserBody = {
    id: 0,
    username : "",
    age : 0
}

let rateBody = {
    userId: 0,
    trackId: 0,
    rate: 0
}

const goUrl = "http://localhost:8080"



newUserButton.onclick = function() {
    if (usernameInput.value != "") {
        usernameInput.style.display = "none"
        notNewUserButton.style.display = "none"
        ageInput.style.display = "block"
        createUserBody.username = usernameInput.value
    }
    if (ageInput.value != "") {
        usernameInput.style.display = "block"
        notNewUserButton.style.display = "block"
        ageInput.style.display = "none"
        createUserBody.age = parseInt(ageInput.value)
        ageInput.value = ""
        let url = goUrl + "/create"
        sendPostRequest("POST", url, createUserBody).then(data => console.log(data)).catch(err => console.log(err))
    }
   
}



notNewUserButton.onclick = function() {
    createUserBody.username = usernameInput.value
    if (createUserBody.username != "") {
        checkIfUserExists()
    } 
    
}

rateButton.onclick = function() {
    sendRating()  //ERROR
    checkIfUserExists()
}


async function sendRating() {
    let url = goUrl + "/rate"
    rateBody.userId = createUserBody.id
    songRatings = []
    let evals = document.querySelectorAll('.evaluation-input')
    evals.forEach(node => {
        songRatings.push(node.value)
    });
    console.log(songRatings, songIds)
    for (let i = 0; i < 5; i++) {
        rateBody.trackId = songIds[i]
        rateBody.rate = songRatings[i]
        console.log(rateBody)
        if (rateBody.rate != 0) {
            sendPostRequest("POST", url, rateBody).then(data => console.log(data)).catch(err => console.log(err))
        }
    }
}

async function checkIfUserExists() {
    ratingsContainer.innerHTML = ""
    let url = goUrl + `/username?username=${createUserBody.username}`
    const response = await fetch(url, {method: "GET", headers: {"Content-Type":"application/json"}})
    const data = await response.json()
    createUserBody.id = data.user.id
    createUserBody.username = data.user.username
    createUserBody.age = data.user.age
    if (createUserBody.id != 0) {
        getTrackRate()
    }
}

async function getTrackRate() {
    songIds = []
    for (let i = 0; i < 5; i++) {
        let url = goUrl + `/id?id=${getRandomInt(69000)}`
        const response = await fetch(url, {method: "GET", headers: {"Content-Type":"application/json"}})
        const data = await response.json()
        let rating = createRating(data.track.name, data.artist.name)
        songIds.push(data.track.id)
        ratingsContainer.prepend(rating)
    }
    rateButton.classList.remove("hidden")
    ratingsContainer.appendChild(rateButton)
}

function sendPostRequest(method, url, body=null) {
    const headers = {
        "Content-Type": "application/json"
    }
    return fetch(url, {
        method: method,
        body: JSON.stringify(body),
        headers: headers
    }).then(response => {
        if (response.ok) {
            return response.json()
        }
        return response.json().then(error => {
            const err = new Error("SMth went wrong")
            err.data = error
            throw error
        })
    })
}

function getRandomInt(max) {
    return Math.floor(Math.random() * max) + 1;
  }
  





