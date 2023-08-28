create table role (
    id int primary key,
    role_name varchar(100)
);

create table user_has_role (
    id int primary key,
    role_start_time datetime,
    role_end_time datetime, -- or varchar(50) depending on your needs
    user_account_id int,
    role_id int,
    foreign key (user_account_id) references user_account(id),
    foreign key (role_id) references role(id)
);


create table user_account (
    id int primary key,
    user_name varchar(100),
    email varchar(254),
    password varchar(200),
    password_sale varchar(50),
    password_hash_algorithm varchar(50)
);

create table user_has_status (
    id int primary key,
    status_start_time datetime,
    status_end_time datetime,
    user_account_id int,
    role_id int,
    foreign key (user_account_id) references user_account(id),
    foreign key (role_id) references role(id)
);

create table status (
    id int primary key,
    status_name varchar(100),
    is_user_working bit
);

--1) Insert data into each of the above tables. With at least two rows in each of
--the table, make sure, that you have created respective foreign keys.

insert into role (id, role_name)
values (1, 'Admin'), (2, 'User');

insert into user_has_role (id, role_start_time, role_end_time, user_account_id, role_id)
values (1, '2023-01-01 00:00:00', '2023-01-31 00:00:00', 1, 1),
       (2, '2023-02-01 00:00:00', '2023-02-28 00:00:00', 2, 2);

insert into user_account (id, user_name, email, password, password_sale, password_hash_algorithm)
values (1, 'John Doe', 'john@example.com', 'password123', 'sale1', 'SHA256'),
       (2, 'Jane Smith', 'jane@example.com', 'password456', 'sale2', 'MD5');

insert into user_has_status (id, status_start_time, status_end_time, user_account_id, role_id)
values (1, '2023-01-01', '2023-01-31', 1, 1),
       (2, '2023-02-01', '2023-02-28', 2, 2);

insert into status (id, status_name, is_user_working)
values (1, 'Active', 1),
       (2, 'Inactive', 0);

select * from role;
select * from user_has_role;
select * from user_account;
select * from user_has_status;
select * from status;


--2) Delete all the data from each of the tables.

delete from role;

delete from user_has_role;

delete from user_account;

delete from user_has_status;

delete from status;
