create table artists(
    id serial primary key,
    followers decimal not null,
    genres varchar not null,
    name varchar not null,
    popularity decimal not null
);

create table tracks(
   id serial primary key,
   name varchar not null,
   popularity decimal not null,
   artist_id bigint not null references artists(id),
   release_date date not null,
   danceability decimal not null,
   energy decimal not null
);