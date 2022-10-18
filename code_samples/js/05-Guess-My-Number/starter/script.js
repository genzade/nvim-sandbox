'use strict';

// console.log(document.querySelector('.message').textContent);

// document.querySelector('.message').textContent = 'Correct Number!';

// document.querySelector('.number').textContent = 13;
// document.querySelector('.score').textContent = 10;

// document.querySelector('.guess').value = 23;
// console.log(document.querySelector('.guess').value);

// define the secret number

const generateSecretNumber = () => {
  return Math.trunc(Math.random() * 20) + 1;
};

const displayMessage = message => {
  document.querySelector('.message').textContent = message;
};

const setScore = score => {
  document.querySelector('.score').textContent = score;
};

const setSecretNumberContent = content => {
  document.querySelector('.number').textContent = content;
};

const setBackgroundColor = color => {
  document.querySelector('body').style.backgroundColor = color;
};

const setSecretNumberWidth = width => {
  document.querySelector('.number').style.width = width;
};

let secretNumber = generateSecretNumber();
let score = 20;
let highScore = 0;

console.log(secretNumber);

document.querySelector('.again').addEventListener('click', function () {
  secretNumber = generateSecretNumber();
  score = 20;
  setScore(score);
  setSecretNumberContent('?');
  setSecretNumberWidth(''); // use default from css
  setBackgroundColor(''); // use default from css
  document.querySelector('.guess').value = '';
  displayMessage('Start guessing...');
});
console.log(secretNumber);

document.querySelector('.check').addEventListener('click', function () {
  const guess = Number(document.querySelector('.guess').value);

  // when there is no input
  if (!guess) {
    displayMessage('No Number!');
    // when player wins
  } else if (guess === secretNumber) {
    setSecretNumberContent(secretNumber);

    displayMessage('Correct Number!');

    setBackgroundColor('#60b347');
    setSecretNumberWidth('30rem');

    if (score > highScore) {
      highScore = score;
      document.querySelector('.highscore').textContent = highScore;
    }
    // when guess is wrong
  } else if (guess !== secretNumber) {
    if (score > 1) {
      displayMessage(guess > secretNumber ? 'Too high!' : 'Too low!');

      score--;
      setScore(score);
    } else {
      displayMessage('You lost!');
      setScore(0);
    }
  }
});
