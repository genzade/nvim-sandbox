'use strict';

// function calcAge(birthYear) {
//   const age = 2037 - birthYear;

//   function printAge() {
//     let output = `${firstName}, you are ${age}, born in ${birthYear}`;
//     console.log(output);

//     if (birthYear >= 1981 && birthYear <= 1996) {
//       var millenial = true;
//       // Creating New variable with same name as outer scope's variable
//       const firstName = 'Steven';
//       const str = `Oh, and you're a millenial, ${firstName}`;
//       console.log(str);

//       function add(a, b) {
//         return a + b;
//       }

//       // Reassigning out scope's variabl
//       output = 'NEW OUTPUT!';
//     }
//     // console.log(str);
//     console.log(millenial);
//     // console.log(add(2, 3));
//     console.log(output);
//   }

//   printAge();

//   return age;
// }

// const firstName = 'Jonas';
// calcAge(1991);

// Hoisting in practice

// hoisting with variables
// console.log(me);
// console.log(job);
// console.log(year);

// var me = 'Jonas';
// let job = 'teacher';
// const year = 1991;

// // Functions examples

// console.log(addDecl(2, 3));
// // console.log(addExpr(2, 3));
// // console.log(addArrow(2, 3));

// // Function declaration
// function addDecl(a, b) {
//   return a + b;
// }
// // function declaration is the only that can be used before it is initialized

// // Function expression
// var addExpr = function (a, b) {
//   return a + b;
// };

// // Function arrow
// const addArrow = (a, b) => {
//   return a + b;
// };

// // Example

// if (!numProduct) {
//   deleteShoppingCart();
// }

// console.log(numProduct);

// var numProduct = 10;

// function deleteShoppingCart() {
//   console.log('All products deleted!');
// }

// var x = 1;
// let y = 2;
// const z = 3;

// console.log(x === window.x);
// console.log(y === window.y);
// console.log(z === window.z);

// // The `this` keyword
// console.log(this);

// const calcAge = function (birthYear) {
//   console.log(2037 - birthYear);
//   console.log(this);
// };

// calcAge(1991);

// const calcAgeArrow = birthYear => {
//   console.log(2037 - birthYear);
//   console.log(this);
// };

// calcAgeArrow(1991);

// const jonas = {
//   year: 1991,
//   calcAge: function () {
//     console.log(this);
//     console.log(2037 - this.year);
//   },
// };

// jonas.calcAge();

// const matilda = {
//   year: 2017,
// };

// matilda.calcAge = jonas.calcAge;
// matilda.calcAge();

// const f = jonas.calcAge;
// console.log(f());

// // var firstName = 'Matilda'; // this creates a property on the global object
// const jonas = {
//   firstName: 'Jonas',
//   year: 1991,
//   calcAge: function () {
//     // console.log(this);
//     console.log(2037 - this.year);

//     // // solution 1
//     // const self = this;
//     // const isMillenial = function () {
//     //   // console.log(this); // `this` is undefined here
//     //   // console.log(this.year >= 1981 && this.year <= 1996);
//     //   console.log(self); // `this` is undefined here
//     //   console.log(self.year >= 1981 && self.year <= 1996);
//     // };

//     // solution 2
//     const isMillenial = () => {
//       console.log(this); // `this` inherits from it's parent scope in arrow funcs
//       console.log(this.year >= 1981 && this.year <= 1996);
//     };

//     isMillenial();
//   },
//   // greet: () => {
//   //   console.log(this);
//   //   console.log(`Hey ${this.firstName}`);
//   // }, // `this` does not work in arrow func
//   greet: function () {
//     console.log(`Hey ${this.firstName}`);
//   },
// };

// jonas.greet();
// jonas.calcAge();

// // arguments keyword
// const addExpr = function (a, b) {
//   console.log(arguments);
//   return a + b;
// };
// addExpr(2, 5, 8, 12);

// // Function arrow
// var addArrow = (a, b) => {
//   console.log(arguments); // arguments keyword is undefined in arrow func
//   return a + b;
// };
// addArrow(2, 5, 8, 12);

// Primitive vs Object types

// primitive types

let age = 30;
let oldAge = age;

age = 31;
console.log(age);
console.log(oldAge);

const me = {
  name: 'Jonas',
  age: 30,
};

const friend = me;
friend.age = 27;

console.log('Friend: ', friend);
console.log('Me: ', me);

let lastName = 'Williams';
let oldlastName = lastName;

lastName = 'Davis';

console.log(lastName, oldlastName);
// each primitive value will be saved in its own piece of memory in the stack

// object (reference) types
const jessica = {
  firstName: 'Jessica',
  lastName: 'Williams',
  age: 27,
};
const marriedJessica = jessica;
marriedJessica.lastName = 'Davis';
console.log('Before marriage: ', jessica);
console.log('After marriage: ', marriedJessica);

// this is not a new object in the heap,
// both marriedJessica and jessica are point
// to the same memory address in the heap

// an object is a reference value and will be stored in the heap and the stack
// just keeps a reference to the memory position where the object is stored in the heap

// Copying objects

const jessica2 = {
  firstName: 'Jessica',
  lastName: 'Williams',
  age: 27,
  family: ['Alice', 'Bob'],
};

// shallow copy
const jessicaCopy = Object.assign({}, jessica2);
jessicaCopy.lastName = 'Davis';

jessicaCopy.family.push('Mary');
jessicaCopy.family.push('John');
// this changes both jessica2 and jessicaCopy `family` properties because
// they both poin to the same part in memory in the heap

console.log('Before marriage: ', jessica2);
console.log('After marriage: ', jessicaCopy);
