create table users(
    id serial primary key,
    username varchar not null,
    age int not null
);

insert into users (id, username, age) values (1, 'kbenes0', 26);
insert into users (id, username, age) values (2, 'mspours1', 73);
insert into users (id, username, age) values (3, 'wstanmer2', 54);
insert into users (id, username, age) values (4, 'dsmelley3', 7);
insert into users (id, username, age) values (5, 'dstruis4', 18);
insert into users (id, username, age) values (6, 'arive5', 60);
insert into users (id, username, age) values (7, 'syousef6', 88);
insert into users (id, username, age) values (8, 'gravilus7', 98);
insert into users (id, username, age) values (9, 'bvautre8', 95);
insert into users (id, username, age) values (10, 'mmavin9', 52);
insert into users (id, username, age) values (11, 'bpettigreea', 73);
insert into users (id, username, age) values (12, 'ydixieb', 50);
insert into users (id, username, age) values (13, 'vstrobandc', 18);
insert into users (id, username, age) values (14, 'saslumd', 76);
insert into users (id, username, age) values (15, 'rbewleye', 54);
insert into users (id, username, age) values (16, 'dlucianf', 90);
insert into users (id, username, age) values (17, 'jriedelg', 38);
insert into users (id, username, age) values (18, 'tgirkinh', 16);
insert into users (id, username, age) values (19, 'ceckhardi', 87);
insert into users (id, username, age) values (20, 'aportwainej', 15);
insert into users (id, username, age) values (21, 'pmanusk', 75);
insert into users (id, username, age) values (22, 'bschusterll', 67);
insert into users (id, username, age) values (23, 'brafterm', 16);
insert into users (id, username, age) values (24, 'fmcmanamenn', 65);
insert into users (id, username, age) values (25, 'pfleuryo', 34);
insert into users (id, username, age) values (26, 'cbarrowcliffp', 16);
insert into users (id, username, age) values (27, 'kbaldettiq', 12);
insert into users (id, username, age) values (28, 'rfayr', 4);
insert into users (id, username, age) values (29, 'mferress', 9);
insert into users (id, username, age) values (30, 'mdabbest', 90);
insert into users (id, username, age) values (31, 'niltchevu', 58);
insert into users (id, username, age) values (32, 'dferriesv', 70);
insert into users (id, username, age) values (33, 'jhayseldenw', 87);
insert into users (id, username, age) values (34, 'lcrohanx', 51);
insert into users (id, username, age) values (35, 'cruusay', 21);
insert into users (id, username, age) values (36, 'emcquinz', 95);
insert into users (id, username, age) values (37, 'vhouseman10', 84);
insert into users (id, username, age) values (38, 'vhowroyd11', 59);
insert into users (id, username, age) values (39, 'dfinn12', 12);
insert into users (id, username, age) values (40, 'elongbottom13', 87);
insert into users (id, username, age) values (41, 'ccicculini14', 59);
insert into users (id, username, age) values (42, 'rranns15', 38);
insert into users (id, username, age) values (43, 'nopenshaw16', 11);
insert into users (id, username, age) values (44, 'rhammonds17', 81);
insert into users (id, username, age) values (45, 'cthrush18', 9);
insert into users (id, username, age) values (46, 'cstickley19', 76);
insert into users (id, username, age) values (47, 'dfranzke1a', 66);
insert into users (id, username, age) values (48, 'chandrek1b', 91);
insert into users (id, username, age) values (49, 'fnormington1c', 6);
insert into users (id, username, age) values (50, 'lternott1d', 69);

create table ratings(
    id serial primary key,
    user_id int references users(id) not null,
    track_id int references tracks(id) not null,
    rating int not null
);

insert into ratings(id, user_id, track_id, rating) values (1, 1, 1, 3);
insert into ratings(id, user_id, track_id, rating) values (7, 1, 3, 5);
insert into ratings(id, user_id, track_id, rating) values (2, 1, 2, 5);
insert into ratings(id, user_id, track_id, rating) values (3, 2, 1, 4);
insert into ratings(id, user_id, track_id, rating) values (4, 2, 2, 5);
insert into ratings(id, user_id, track_id, rating) values (5, 3, 1, 4);
insert into ratings(id, user_id, track_id, rating) values (6, 3, 3, 5);