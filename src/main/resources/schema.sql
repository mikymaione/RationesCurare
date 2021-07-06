create table IF NOT EXISTS user_entity (
    id IDENTITY NOT NULL PRIMARY KEY,
    cognome varchar,
    nome varchar,
    email varchar
);