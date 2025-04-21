/*
D I S C L A M E R 

MySQL doesn't allow AFTER INSERT triggers to modify the same table that fired the trigger(?)
*/


SET GLOBAL max_allowed_packet=1073741824;
SET GLOBAL wait_timeout = 600;
SET GLOBAL net_read_timeout = 600;
SET GLOBAL connect_timeout = 600;

show triggers;

DELIMITER $$

CREATE TRIGGER update_order_ids
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    -- Assign a user (select the most recent or fallback to any user)
    SET NEW.`userid` = (
        SELECT COALESCE(
            (SELECT `ID` FROM `users` ORDER BY RAND() LIMIT 1)
        )
    );

    -- Assign a pharmacist with the least assigned orders (or any if none are assigned)
    SET NEW.`pharmasistid` = (
        SELECT COALESCE(
            (SELECT `pharmid` FROM `pharmacists` 
             LEFT JOIN `orders` ON `pharmacists`.`pharmid` = `orders`.`pharmasistid`
             GROUP BY `pharmacists`.`pharmid`
             ORDER BY COUNT(`orders`.`orderid`) ASC LIMIT 1),
            (SELECT `pharmid` FROM `pharmacists` ORDER BY RAND() LIMIT 1)
        )
    );

    -- Assign a salesman with the fewest assigned orders (or any if none exist)
    SET NEW.`salesmenid` = (
        SELECT COALESCE(
            (SELECT `salesid` FROM `salesmen` 
             LEFT JOIN `orders` ON `salesmen`.`salesid` = `orders`.`salesmenid`
             GROUP BY `salesmen`.`salesid`
             ORDER BY COUNT(`orders`.`orderid`) ASC LIMIT 1),
            (SELECT `salesid` FROM `salesmen` ORDER BY RAND() LIMIT 1)
        )
    );
END$$

DELIMITER ;

-- drop trigger update_order_ids;

DELIMITER $$

CREATE TRIGGER before_insert_order_items
BEFORE INSERT ON `order_items`
FOR EACH ROW
BEGIN
    -- Calculate subtotal before inserting
    SET NEW.subtotal = NEW.quantity * NEW.price;
END $$

DELIMITER ;

-- drop trigger before_insert_order_items;


