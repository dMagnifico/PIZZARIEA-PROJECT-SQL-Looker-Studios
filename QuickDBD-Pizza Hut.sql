-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/eby70o
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE `orders` (
    `row_id` int  NOT NULL ,
    `order_id` varchar(10)  NOT NULL ,
    `created_at` datetime  NOT NULL ,
    `item_id` varchar(10)  NOT NULL ,
    `quantity` int  NOT NULL ,
    `cust_id` int  NOT NULL ,
    `delivery` boolean  NOT NULL ,
    `add_id` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `customers` (
    `cust_id` int  NOT NULL ,
    `cust_firstname` varchar(50)  NOT NULL ,
    `cust_lastname` varchar(50)  NOT NULL ,
    PRIMARY KEY (
        `cust_id`
    )
);

CREATE TABLE `address` (
    `add_id` int  NOT NULL ,
    `delivery_address1` varchar(200)  NOT NULL ,
    `delivery_address2` varchar(200)  NULL ,
    `delivery_city` varchar(50)  NOT NULL ,
    `delivery_zipcode` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `add_id`
    )
);

CREATE TABLE `item` (
    `item_id` varchar(10)  NOT NULL ,
    `sku` varchar(20)  NOT NULL ,
    `item_name` varchar(100)  NOT NULL ,
    `item_cat` varchar(100)  NOT NULL ,
    `item_size` var(10)  NOT NULL ,
    `item_price` decimal(10,2)  NOT NULL ,
    PRIMARY KEY (
        `item_id`
    )
);

CREATE TABLE `ingredient` (
    `ing_id` varchar(10)  NOT NULL ,
    `ing_name` varchar(200)  NOT NULL ,
    `ing_weight` int  NOT NULL ,
    `ing_meas` varchar(20)  NOT NULL ,
    `ing_price` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `ing_id`
    )
);

CREATE TABLE `recipe` (
    `row_id` int  NOT NULL ,
    `recipe_id` varchar(200)  NOT NULL ,
    `ing_id` varchar(20)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

CREATE TABLE `inventory` (
    `inv_id` int  NOT NULL ,
    `item_id` varchar(20)  NOT NULL ,
    `quantity` int  NOT NULL ,
    PRIMARY KEY (
        `inv_id`
    )
);

CREATE TABLE `staff` (
    `staff_id` varchar(20)  NOT NULL ,
    `firstname` varchar(50)  NOT NULL ,
    `lastname` varchar(50)  NOT NULL ,
    `position` varchar(100)  NOT NULL ,
    `hourly_rate` decimal(5,2)  NOT NULL ,
    PRIMARY KEY (
        `staff_id`
    )
);

CREATE TABLE `shift` (
    `shift_id` int  NOT NULL ,
    `day_of_week` varchar(10)  NOT NULL ,
    `start_time` time  NOT NULL ,
    `end_time` time  NOT NULL ,
    PRIMARY KEY (
        `shift_id`
    )
);

CREATE TABLE `rotation` (
    `row_id` int  NOT NULL ,
    `rota_id` varchar(20)  NOT NULL ,
    `date` datetime  NOT NULL ,
    `shift_id` varchar(20)  NOT NULL ,
    `staff_id` varchar(20)  NOT NULL ,
    PRIMARY KEY (
        `row_id`
    )
);

ALTER TABLE `customers` ADD CONSTRAINT `fk_customers_cust_id` FOREIGN KEY(`cust_id`)
REFERENCES `orders` (`cust_id`);

ALTER TABLE `address` ADD CONSTRAINT `fk_address_add_id` FOREIGN KEY(`add_id`)
REFERENCES `orders` (`add_id`);

ALTER TABLE `item` ADD CONSTRAINT `fk_item_item_id` FOREIGN KEY(`item_id`)
REFERENCES `orders` (`item_id`);

ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_recipe_id` FOREIGN KEY(`recipe_id`)
REFERENCES `item` (`sku`);

ALTER TABLE `recipe` ADD CONSTRAINT `fk_recipe_ing_id` FOREIGN KEY(`ing_id`)
REFERENCES `ingredient` (`ing_id`);

ALTER TABLE `inventory` ADD CONSTRAINT `fk_inventory_item_id` FOREIGN KEY(`item_id`)
REFERENCES `ingredient` (`ing_id`);

ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_shift_id` FOREIGN KEY(`shift_id`)
REFERENCES `rotation` (`shift_id`);

ALTER TABLE `shift` ADD CONSTRAINT `fk_shift_day_of_week` FOREIGN KEY(`day_of_week`)
REFERENCES `orders` (`created_at`);

ALTER TABLE `rotation` ADD CONSTRAINT `fk_rotation_staff_id` FOREIGN KEY(`staff_id`)
REFERENCES `staff` (`staff_id`);

