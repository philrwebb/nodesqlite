--------------------------------------------------------------------------------
-- Up
--------------------------------------------------------------------------------

CREATE TABLE Category (
  id   INTEGER PRIMARY KEY,
  name TEXT    NOT NULL
);

CREATE TABLE Post (
  id          INTEGER PRIMARY KEY,
  categoryId  INTEGER NOT NULL,
  title       TEXT    NOT NULL,
  isPublished NUMERIC NOT NULL DEFAULT 0,
  CONSTRAINT Post_fk_categoryId FOREIGN KEY (categoryId)
    REFERENCES Category (id) ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT Post_ck_isPublished CHECK (isPublished IN (0, 1))
);

CREATE TABLE Person (
  id          INTEGER PRIMARY KEY,
  surname     nvarchar(100) NULL,
  firstNames  nvarchar(100) NULL,
  dateOfBirth datetime NULL
);

CREATE INDEX Post_ix_categoryId ON Post (categoryId);

INSERT INTO Category (id, name) VALUES (1, 'Test');
INSERT INTO Category (id, name) VALUES (2, 'Fiction');
INSERT INTO Post (id, categoryId, title, isPublished) VALUES (1,1,'Test Title', 1);
INSERT INTO Post (id, categoryId, title, isPublished) VALUES (2,2,'New Title', 1);
INSERT INTO Person(id, surname, firstNames, dateOfBirth) VALUES(1,'WEBB','Philip Richard','1951-09-112');
INSERT INTO Person(id, surname, firstNames, dateOfBirth) VALUES(2,'WEBB','Pamela Sue','1951-01-02');
INSERT INTO Person(id, surname, firstNames, dateOfBirth) VALUES(3,'JONES','Andrew','1953-03-05');


--------------------------------------------------------------------------------
-- Down
--------------------------------------------------------------------------------

DROP INDEX Post_ix_categoryId;
DROP TABLE Post;
DROP TABLE Category;
DROP TABLE Person;