create table users(
    id serial primary key,
    username varchar not null,
    age int not null
);

insert into users (username, age) values ('jwhayman0', 32);
insert into users (username, age) values ('kpagen1', 86);
insert into users (username, age) values ('adeverille2', 88);
insert into users (username, age) values ('kpaniman3', 14);
insert into users (username, age) values ('esivior4', 26);
insert into users (username, age) values ('mroswarne5', 56);
insert into users (username, age) values ('mgiffkins6', 100);
insert into users (username, age) values ('pspritt7', 60);
insert into users (username, age) values ('osecret8', 43);
insert into users (username, age) values ('vcardwell9', 69);
insert into users (username, age) values ('crylesa', 67);
insert into users (username, age) values ('lvonbrookb', 26);
insert into users (username, age) values ('tstukec', 64);
insert into users (username, age) values ('tabramd', 84);
insert into users (username, age) values ('sclifte', 93);
insert into users (username, age) values ('hrichinf', 99);
insert into users (username, age) values ('mfroudeg', 50);
insert into users (username, age) values ('dbeverh', 14);
insert into users (username, age) values ('bgwytheri', 74);
insert into users (username, age) values ('kferrettinij', 86);
insert into users (username, age) values ('agorgenk', 53);
insert into users (username, age) values ('mreelyl', 74);
insert into users (username, age) values ('lughettim', 75);
insert into users (username, age) values ('rfearonn', 58);
insert into users (username, age) values ('ygaugeo', 74);
insert into users (username, age) values ('fsherwillp', 42);
insert into users (username, age) values ('atreadgearq', 87);
insert into users (username, age) values ('ghumphrysr', 40);
insert into users (username, age) values ('lmoars', 91);
insert into users (username, age) values ('jjermyt', 90);
insert into users (username, age) values ('atelferu', 16);
insert into users (username, age) values ('hstrothersv', 29);
insert into users (username, age) values ('tscarrisbrickw', 26);
insert into users (username, age) values ('beaddyx', 21);
insert into users (username, age) values ('rweddupy', 70);
insert into users (username, age) values ('bhackingz', 33);
insert into users (username, age) values ('dchedzoy10', 92);
insert into users (username, age) values ('msouttar11', 73);
insert into users (username, age) values ('nshailer12', 52);
insert into users (username, age) values ('gtoovey13', 77);
insert into users (username, age) values ('uevett14', 44);
insert into users (username, age) values ('wgaskill15', 19);
insert into users (username, age) values ('jtitchmarsh16', 10);
insert into users (username, age) values ('fvicent17', 56);
insert into users (username, age) values ('jjerisch18', 73);
insert into users (username, age) values ('egawthrop19', 44);
insert into users (username, age) values ('opurple1a', 23);
insert into users (username, age) values ('dhaysman1b', 99);
insert into users (username, age) values ('mbutt1c', 12);
insert into users (username, age) values ('chonniebal1d', 28);

create table ratings(
    id serial primary key,
    user_id int references users(id) not null,
    track_id int references tracks(id) not null,
    rating int not null
);

insert into ratings(user_id, track_id, rating) values (1, 1, 3);
insert into ratings(user_id, track_id, rating) values (1, 3, 5);
insert into ratings(user_id, track_id, rating) values (1, 2, 5);
insert into ratings(user_id, track_id, rating) values (1, 10, 1);
insert into ratings(user_id, track_id, rating) values (2, 1, 4);
insert into ratings(user_id, track_id, rating) values (2, 2, 5);
insert into ratings(user_id, track_id, rating) values (3, 1, 4);
insert into ratings(user_id, track_id, rating) values (3, 3, 5);
insert into ratings(user_id, track_id, rating) values (3, 4, 5);
insert into ratings(user_id, track_id, rating) values (3, 5, 4);
insert into ratings(user_id, track_id, rating) values (3, 10, 1);
insert into ratings(user_id, track_id, rating) values (4, 4, 2);
insert into ratings(user_id, track_id, rating) values (5, 4, 2);
insert into ratings(user_id, track_id, rating) values (6, 10, 1);
insert into ratings(user_id, track_id, rating) values (7, 8, 5);
insert into ratings(user_id, track_id, rating) values (8, 8, 1);
insert into ratings(user_id, track_id, rating) values (9, 1, 3);
insert into ratings(user_id, track_id, rating) values (9, 2, 4);
insert into ratings(user_id, track_id, rating) values (9, 3, 1);
insert into ratings(user_id, track_id, rating) values (10, 3, 1);
insert into ratings(user_id, track_id, rating) values (10, 5, 5);
insert into ratings(user_id, track_id, rating) values (10, 8, 4);
insert into ratings(user_id, track_id, rating) values (10, 1, 3);
insert into ratings(user_id, track_id, rating) values (11, 4, 5);
insert into ratings(user_id, track_id, rating) values (11, 5, 5);
insert into ratings(user_id, track_id, rating) values (11, 6, 5);
insert into ratings(user_id, track_id, rating) values (11, 1, 1);
insert into ratings(user_id, track_id, rating) values (12, 20, 3);
insert into ratings(user_id, track_id, rating) values (12, 15, 5);
insert into ratings(user_id, track_id, rating) values (12, 9, 5);
insert into ratings(user_id, track_id, rating) values (12, 10, 4);
insert into ratings(user_id, track_id, rating) values (12, 1, 3);