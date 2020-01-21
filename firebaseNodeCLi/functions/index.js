const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
exports.helloWorld = functions.https.onRequest((request, response) => {
 let name = request.query.name;
 response.send({
   message:name+ " Assalam o alaikum"
 });
});
