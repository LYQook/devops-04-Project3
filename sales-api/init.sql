﻿-- RDS에 생성한 데이터베이스 리소스에 아래 table들을 생성하고, 값을 추가해넣으세요.
CREATE TABLE `product` (
    `product_id` BINARY(16)  NOT NULL ,
    -- http://mdr.tta.or.kr/item/1036/property/sku
    `sku` varchar(200)  NOT NULL ,
    -- Field documentation comment 3
    `name` varchar(200)  NOT NULL ,
    `price` int  NOT NULL ,
    `stock` int  NOT NULL ,
    `factory_id` BINARY(16)  NOT NULL ,
    `ad_id` BINARY(16)  NOT NULL ,
    PRIMARY KEY (
        `product_id`
    ),
    CONSTRAINT `uc_product_sku` UNIQUE (
        `sku`
    ),
    CONSTRAINT `uc_product_name` UNIQUE (
        `name`
    )
);

CREATE TABLE `factory` (
    `factory_id` BINARY(16)  NOT NULL ,
    -- http://mdr.tta.or.kr/item/1036/property/sku
    `identifier` varchar(200)  NOT NULL ,
    -- Field documentation comment 3
    `name` varchar(200)  NOT NULL ,
    `manager_email` varchar(200)  NOT NULL ,
    `API` varchar(200)  NOT NULL ,
    PRIMARY KEY (
        `factory_id`
    ),
    CONSTRAINT `uc_factory_name` UNIQUE (
        `name`
    )
);

CREATE TABLE `advertisement` (
    `ad_id` BINARY(16)  NOT NULL ,
    `status` boolean  NOT NULL ,
    `manager_email` varchar(200)  NOT NULL ,
    PRIMARY KEY (
        `ad_id`
    )
);

ALTER TABLE `product` ADD CONSTRAINT `fk_product_factory_id` FOREIGN KEY(`factory_id`)
REFERENCES `factory` (`factory_id`);

ALTER TABLE `product` ADD CONSTRAINT `fk_product_ad_id` FOREIGN KEY(`ad_id`)
REFERENCES `advertisement` (`ad_id`);




INSERT INTO factory(factory_id, identifier, name, manager_email, api) VALUES(UUID_TO_BIN(UUID()),'FF-500293','부산도너츠 공장', 'dob_factory@codeatates.com', '');


INSERT INTO advertisement(ad_id, status, manager_email) VALUES(UUID_TO_BIN(UUID()),true, 'dob_ad@codeatates.com');


SELECT
    BIN_TO_UUID(factory_id) as factory_id
FROM factory;
-- f59fe6e6-fb79-11ed-81f5-0a1d37be9cd6

SELECT
    BIN_TO_UUID(ad_id) as ad_id
FROM advertisement;
-- bfd9d2b8-fac8-11ed-933d-0a67f04805fe

INSERT INTO product(product_id, sku, name, price, stock, factory_id, ad_id)
VALUES(UUID_TO_BIN(UUID()),'CP-502101','부산도너츠', 19900, 3, UUID_TO_BIN("f59fe6e6-fb79-11ed-81f5-0a1d37be9cd6"),
UUID_TO_BIN('f7b02db0-fb79-11ed-81f5-0a1d37be9cd6'));
