```

SELECT PASSWORD("do one thing and do it well!");
SELECT MD5("do one thing and do it well!");
SELECT ENCODE("do one thing and do it well!","matosiki");
SELECT DECODE(ENCODE("73516260","matosiki"),"matosiki");
SELECT AES_ENCRYPT("whats fuck","haha");
SELECT AES_DECRYPT(AES_ENCRYPT("whats fuck","haha"),"haha");

-- 我自己创建的插入加密触发器

DROP TRIGGER /*!50032 IF EXISTS */ `insert_encode_matosiki`$$

CREATE
    /*!50017 DEFINER = 'root'@'localhost' */
    TRIGGER `insert_encode_matosiki` BEFORE INSERT ON `matos_code` 
    FOR EACH ROW BEGIN
	SET new.u_pwd = AES_ENCRYPT(new.u_pwd,"matosiki");  -- 其中这个加密参数自己改。我最崇拜的技术大牛。
    END;
$$

DELIMITER ;


```

