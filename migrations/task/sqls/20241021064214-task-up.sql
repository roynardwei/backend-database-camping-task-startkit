
-- ████████  █████   █     █ 
--   █ █   ██    █  █     ██ 
--   █ █████ ███ ███       █ 
--   █ █   █    ██  █      █ 
--   █ █   █████ █   █     █ 
-- ===================== ====================
-- 1. 用戶資料，資料表為 USER

-- 1. 新增：新增六筆用戶資料，資料如下：
--     1. 用戶名稱為`李燕容`，Email 為`lee2000@hexschooltest.io`，Role為`USER`
--     2. 用戶名稱為`王小明`，Email 為`wXlTq@hexschooltest.io`，Role為`USER`
--     3. 用戶名稱為`肌肉棒子`，Email 為`muscle@hexschooltest.io`，Role為`USER`
--     4. 用戶名稱為`好野人`，Email 為`richman@hexschooltest.io`，Role為`USER`
--     5. 用戶名稱為`Q太郎`，Email 為`starplatinum@hexschooltest.io`，Role為`USER`
--     6. 用戶名稱為 `透明人`，Email 為 opacity0@hexschooltest.io，Role 為 USER
    insert into 
	    "USER" (name, email, role)
    values 
        ('李燕容', 'lee2000@hexschooltest.io', 'USER'),
        ('王小明', 'wXlTq@hexschooltest.io', 'USER'),
        ('肌肉棒子', 'muscle@hexschooltest.io', 'USER'),
        ('好野人', 'richman@hexschooltest.io', 'USER'),
        ('Q太郎', 'starplatinum@hexschooltest.io', 'USER'),
        ('透明人', 'opacity0@hexschooltest.io', 'USER');


-- 1-2 修改：用 Email 找到 李燕容、肌肉棒子、Q太郎，如果他的 Role 為 USER 將他的 Role 改為 COACH
    UPDATE "USER"
    SET "role" = 'COACH'
    WHERE "email" IN (
    'lee2000@hexschooltest.io',
    'muscle@hexschooltest.io',
    'starplatinum@hexschooltest.io'
    );


-- 1-3 刪除：刪除USER 資料表中，用 Email 找到透明人，並刪除該筆資料
    DELETE FROM "USER"
    WHERE email = 'opacity0@hexschooltest.io'
    AND name = '透明人' --確認名稱為透明人

-- 1-4 查詢：取得USER 資料表目前所有用戶數量（提示：使用count函式）
    SELECT COUNT(*) --取得用戶數量
    FROM "USER";
-- 1-5 查詢：取得 USER 資料表所有用戶資料，並列出前 3 筆（提示：使用limit語法）
    SELECT * FROM USER LIMIT 3; --選取資料表中的三筆資料

--  ████████  █████   █    ████  
--    █ █   ██    █  █         █ 
--    █ █████ ███ ███       ███  
--    █ █   █    ██  █     █     
--    █ █   █████ █   █    █████ 
-- ===================== ====================
-- 2. 組合包方案 CREDIT_PACKAGE、客戶購買課程堂數 CREDIT_PURCHASE
-- 2-1. 新增：在`CREDIT_PACKAGE` 資料表新增三筆資料，資料需求如下：
    -- 1. 名稱為 `7 堂組合包方案`，價格為`1,400` 元，堂數為`7`
    -- 2. 名稱為`14 堂組合包方案`，價格為`2,520` 元，堂數為`14`
    -- 3. 名稱為 `21 堂組合包方案`，價格為`4,800` 元，堂數為`21`
    INSERT INTO "CREDIT_PACKAGE" (name, price, credit_amount)
    VALUES  ('7 堂組合包方案', 1400, 7),
            ('14 堂組合包方案', 2520, 14),
            ('21 堂組合包方案', 4800, 21);
-- 2-2. 新增：在 `CREDIT_PURCHASE` 資料表，新增三筆資料：（請使用 name 欄位做子查詢）
    -- 1. `王小明` 購買 `14 堂組合包方案`
    -- 2. `王小明` 購買 `21 堂組合包方案`
    -- 3. `好野人` 購買 `14 堂組合包方案`
    INSERT INTO "CREDIT_PURCHASE" (user_id, credit_package_id, purchased_credits,  price_paid)
    VALUES 
        (
        (SELECT id FROM "USER" WHERE email = 'wXlTq@hexschooltest.io' ),
        (SELECT id FROM "CREDIT_PURCHASE" WHERE name ='14 堂組合包方案'),
        (SELECT credit_amount FROM "CREDIT_PURCHASE" WHERE name ='14 堂組合包方案'),
        (SELECT price FROM "CREDIT_PURCHASE" WHERE name ='14 堂組合包方案'),
        ),
        (
        (SELECT id FROM "USER" WHERE name = '王小明'),
        (SELECT id FROM "CREDIT_PACKAGE" WHERE name = '21 堂組合包方案'),
        (SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE name = '21 堂組合包方案'),
        (SELECT price FROM "CREDIT_PACKAGE" WHERE name = '21 堂組合包方案')
        ),
        (
        (SELECT id FROM "USER" WHERE name = '好野人'),
        (SELECT id FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案'),
        (SELECT credit_amount FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案'),
        (SELECT price FROM "CREDIT_PACKAGE" WHERE name = '14 堂組合包方案')
        );  
-- ████████  █████   █    ████   
--   █ █   ██    █  █         ██ 
--   █ █████ ███ ███       ███   
--   █ █   █    ██  █         ██ 
--   █ █   █████ █   █    ████   
-- ===================== ====================
-- 3. 教練資料 ，資料表為 COACH ,SKILL,COACH_LINK_SKILL
-- 3-1 新增：在`COACH`資料表新增三筆教練資料，資料需求如下：
    -- 1. 將用戶`李燕容`新增為教練，並且年資設定為2年（提示：使用`李燕容`的email ，取得 `李燕容` 的 `id` ）
    -- 2. 將用戶`肌肉棒子`新增為教練，並且年資設定為2年
    -- 3. 將用戶`Q太郎`新增為教練，並且年資設定為2年
    INSERT INTO "COACH" (user_id, experience_years)
    VALUES
    (
        (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io'), 2 -- 新增教練 "name"，"years"
    ),  
    (
        (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io'), 2
    ),  
    (
        (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io'), 2
    ); 


-- 3-2. 新增：承1，為三名教練新增專長資料至 `COACH_LINK_SKILL` ，資料需求如下：
    -- 1. 所有教練都有 `重訓` 專長
    -- 2. 教練`肌肉棒子` 需要有 `瑜伽` 專長
    -- 3. 教練`Q太郎` 需要有 `有氧運動` 與 `復健訓練` 專長
    --3-2-1 
    INSERT INTO "COACH_LINK_SKILL" (coach_id, skill_id) VALUES
    (
        (SELECT id from "COACH" WHERE user_id =)

    );    
    --3-2-2,3-2-3,
    INSERT INTO "COACH_LINK_SKILL" (coach_id, skill_id) VALUES 
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'muscle@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '瑜伽')),
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '有氧運動')
    ),
    (
        (SELECT id FROM "COACH" WHERE user_id = (SELECT id FROM "USER" WHERE email = 'starplatinum@hexschooltest.io')),
        (SELECT id FROM "SKILL" WHERE name = '復健訓練')
    );



-- 3-3 修改：更新教練的經驗年數，資料需求如下：
    -- 1. 教練`肌肉棒子` 的經驗年數為3年
    -- 2. 教練`Q太郎` 的經驗年數為5年
    --主要使用 update 更新COACH表 where 找出user_id再從USER表使用email找id.
    3-3-1
    update "COACH"
    set experience_years = 3
    where user_id =(
	SELECT id 
	from "USER" 
	where "email" = 'muscle@hexschooltest.io'
    );

    3-3-2
    update "COACH"
    set experience_years = 5
    where user_id =(
    SELECT id
    from "USER"
    WHERE "email" = 'starplatinum@hexschooltest.io'
    );
    


-- 3-4 刪除：新增一個專長 空中瑜伽 至 SKILL 資料表，之後刪除此專長。
    --新增空中瑜伽到SKILL表
    --使用insert into 到skill表的(name) values值是('空中瑜珈')
    insert into "SKILL" (name)
    values ('空中瑜珈');
    --刪除空中瑜伽到SKILL表
    delete from "SKILL" 
    where name = '空中瑜伽';

--  ████████  █████   █    █   █ 
--    █ █   ██    █  █     █   █ 
--    █ █████ ███ ███      █████ 
--    █ █   █    ██  █         █ 
--    █ █   █████ █   █        █ 
-- ===================== ==================== 
-- 4. 課程管理 COURSE 、組合包方案 CREDIT_PACKAGE

-- 4-1. 新增：在`COURSE` 新增一門課程，資料需求如下：
    -- 1. 教練設定為用戶`李燕容` 
    -- 2. 在課程專長 `skill_id` 上設定為「 `重訓` 」
    -- 3. 在課程名稱上，設定為「`重訓基礎課`」
    -- 4. 授課開始時間`start_at`設定為2024-11-25 14:00:00
    -- 5. 授課結束時間`end_at`設定為2024-11-25 16:00:00
    -- 6. 最大授課人數`max_participants` 設定為10
    -- 7. 授課連結設定`meeting_url`為 https://test-meeting.test.io

    INSERT INTO "COURSE" (user_id, skill_id, name, start_at, end_at, max_participants, meeting_url) 
    VALUES (
            (SELECT id FROM "USER" WHERE email = 'lee2000@hexschooltest.io'),
            (SELECT id FROM "SKILL" WHERE name = '重訓'),
            '重訓基礎課',
            '2024-11-25 14:00:00',
            '2024-11-25 16:00:00',
            10,
            'https://test-meeting.test.io'
            );

