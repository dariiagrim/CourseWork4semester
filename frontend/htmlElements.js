function createRating(name, artist) {
    let rating = document.createElement('div')
    rating.classList.add('rating')
    rating.innerHTML = `<div class="rating-info"><p class="rating-name">${name}</p><p class="rating-artist">${artist}</p></div>`
    rating.innerHTML += `<div class="rating-evaluation"><p class="evaluation-paragraph">Rate song from 1 to 5, 0 if you haven't heard it.</p><input type="text" class="evaluation-input"></div>`
    return rating
}

function createRateButton() {
    let rateButton = document.createElement('button')
    rateButton.classList.add('rate-btn')
    rateButton.innerHTML = 'Rate'
    return rateButton
}