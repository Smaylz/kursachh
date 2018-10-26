create sequence hibernate_sequence start 1 increment 1;

create table message (
id int8 not null,
filename varchar(255),
name varchar(255),
tag varchar(255),
text TEXT not null,
user_id int8,
rang int8,
primary key (id));

create table comment (
id int8 not null,
mes_id int8 not null,
text varchar(2048) not null,
user_id int8,
likec int4,
primary key (id));

create table rang_message (
id int8 not null,
user_id int8,
message_id int8,
note int4,
primary key(id));

create table like_comment (
id int8 not null,
user_id int8,
comment_id int8,
primary key(id));

create table user_role (
user_id int8 not null,
roles varchar(255));

create table usr (
id int8 not null,
social_id varchar(255),
activation_code varchar(255),
active boolean not null,
email varchar(255),
password varchar(255),
username varchar(255) not null,
date_of_registration date ,
primary key (id));

alter table if exists message
add constraint message_user_fk
foreign key (user_id) references usr;

alter table if exists user_role
add constraint user_role_user_fk
foreign key (user_id) references usr;

alter table if exists comment
add constraint comment_user_fk
foreign key (mes_id) references message;

alter table if exists like_comment
add constraint like_message_user_fk
foreign key (comment_id) references comment;

alter table if exists rang_message
add constraint rang_message_user_fk
foreign key (message_id) references message;
