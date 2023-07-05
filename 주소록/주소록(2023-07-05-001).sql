-- addr user(2023-07-05)

SELECT * FROM tbl_addr_hobby;

-- addr_hobby Relation Table과 hobby Entity Table 을 Left JOIN 하여
-- 주소 ID, 취미코드, 취미이름, 취미설명 항목을 Projection 하도록 하기.
-- project할때는 칼럼이름을 잘 봐야한다.
SELECT ah_seq, ah_aid, ah_hbcode, hb_name, hb_descrip
FROM tbl_addr_hobby
LEFT JOIN tbl_hobby ON ah_hbcode = hb_code;

-- 특정한 주소 ID 가 지정되었을때 해당 주소ID의 값만 SELCTION하기.
-- WHERE절로 시작한다.
SELECT ah_seq, ah_aid, ah_hbcode, hb_name, hb_descrip
FROM tbl_addr_hobby
LEFT JOIN tbl_hobby ON ah_hbcode = hb_code
WHERE ah_aid = 'A0001';
