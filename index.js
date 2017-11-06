// import express from 'express';
// import db from 'sqlite';                                       // <=
// import Promise from 'bluebird';
express = require('express');
db = require('sqlite');
Promise= require('bluebird');

const app = express();
const port = process.env.PORT || 3000;

app.get('/posts', async (req, res, next) => {
  try {
    const posts = await db.all(
      'SELECT Post.id, Category.name as [Category], Post.title, Post.isPublished FROM Post INNER JOIN Category on Post.CategoryId = Category.Id LIMIT 10'
    );    
    res.send(posts);
  } catch (err) {
    next(err);
  }
});
app.get('/categories', async(req, res, next) => {
  try {
    const categories = await db.all('SELECT count(*) from CATEGORY');
    res.send(categories);
  } catch (err) {
    next(err);
  }
});
app.get('/persons', async(req, res, next) => {
  try {
    const persons = await db.all('SELECT * from PERSON');
    res.send(persons);
  } catch (err) {
    next(err);
  }
});

Promise.resolve()
  // First, try to open the database
  .then(() => db.open('./database.sqlite', { Promise }))      // <=
  // Update db schema to the latest version using SQL-based migrations
  .then(() => db.migrate({ force: 'last' }))                  // <=
  // Display error message if something went wrong
  .catch((err) => console.error(err.stack))
  // Finally, launch the Node.js app
  .finally(() => app.listen(port));