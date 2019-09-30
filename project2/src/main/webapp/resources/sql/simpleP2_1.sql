show user;
-- 헤더
CREATE TABLE p2header(
    userIP VARCHAR2(40) NOT NULL,
    headerTitle1 VARCHAR2(200),
    headerTitle2 VARCHAR2(400),
    headerContent VARCHAR2(400)
);
-- 레코드
CREATE TABLE p2record(
    userIP VARCHAR2(40) NOT NULL,
    startTime DATE DEFAULT sysdate,
    endTime DATE DEFAULT sysdate,
    CONSTRAINT p2record_time CHECK(startTime<=endTime),
);
-- 캘랜더
CREATE TABLE p2calendar(
    userIP VARCHAR2(40) NOT NULL,
    seq number not null,
    calendarDate DATE DEFAULT sysdate,
    calendarTitle VARCHAR2(200),
    calendarContent VARCHAR2(400),
    CONSTRAINT p2calendar PRIMARY KEY(seq)
);
CREATE SEQUENCE seq_p2calendar
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;
-- 보드
CREATE TABLE p2board(
    userIP VARCHAR2(40) NOT NULL,
    seq number not null,
    boardDate DATE DEFAULT sysdate,
    boardTitle VARCHAR2(200),
    boardContent CLOB,
    CONSTRAINT p2board PRIMARY KEY(seq)
);
CREATE SEQUENCE seq_p2board
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCACHE
NOCYCLE;
