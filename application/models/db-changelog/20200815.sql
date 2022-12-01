alter table product_carts
    add token varchar(255) default null null;

alter table transactions
    change price amount int not null;

alter table transactions
    modify shop_id int(11) unsigned null;
alter table transactions
    change invoice_id order_id int unsigned not null;

alter table transactions
    add payment_track_id int default null null;
alter table transactions
    change transaction_states_id transaction_state_id int(4) default 0 not null;