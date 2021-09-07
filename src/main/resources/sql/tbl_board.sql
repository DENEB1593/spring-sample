-- tbL_board seq 생성
create sequence seq_board;

-- tbL_board 테이블 생성
create table tbl_board (
    bno number(10, 0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varcha2(50) not null,
    regdate date default sysdate,
    updatedate date default sysdate
);

-- 기본키 설정
alter table tbl_board add constraint pk_board primary key (bno);

-- 샘플 레코드 추가
insert into tbl_board (bno, title, content, writer)
values (seq_board.nextval, '테스트 제목', '테스트 내용', '테스트 작성자');