PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;
CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255),
  lname VARCHAR(255)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255),
  body VARCHAR(255),
  author_id INTEGER,

  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  parent_id INTEGER,
  question_id INTEGER NOT NULL,
  body VARCHAR(255),

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_id) REFERENCES replies(id)

);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO 
  question_likes (user_id, question_id)

  VALUES 
    (1,2), 
    (2,1), 
    (1,3), 
    (2,3); 

INSERT INTO
  replies (user_id, parent_id, question_id, body)
VALUES
  (1, null, 2, 'we are in the United States duh'),
  (2, null, 1, 'it''s blue bro'),
  (2, null, 4, 'yeah I think it actually is');

INSERT INTO
  users (fname, lname)
VALUES
  ('Hector', 'Arias'), 
  ('Joshua', 'Prpich'),
  ('David', 'No'),
  ('Christine', 'Kim'),
  ('Agron', 'Bull');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Life question', 'wut color is the sky?', (SELECT id FROM users WHERE fname = 'Hector')),
  ('location question', 'wut country are we in?', (SELECT id FROM users WHERE fname = 'Joshua')),
  ('coding question', 'why are ruby and sql different.. why not use ruby?', (SELECT id FROM users WHERE fname = 'Joshua')),
  ('coding question', 'is java really a script?', (SELECT id FROM users WHERE fname = 'David')),
  ('coding question', 'is Ruby on rails a skate park?', (SELECT id FROM users WHERE fname = 'David')),
  ('coding question', 'is python a snake?', (SELECT id FROM users WHERE fname = 'Joshua'));

INSERT INTO
 question_follows (user_id, question_id)
VALUES
 (1, 1),
 (1, 2),
 (2, 2),
 (2, 3),
 (2, 1),
 (3, 2);
 
