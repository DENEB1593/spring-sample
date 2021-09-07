-- 답글 테이블 생성
create table tbl_reply (
                           rno number(10, 0),
                           bno number(10, 0) not null,
                           reply varchar2(1000) not null,
                           replyer varchar2(50) not null,
                           replyDate date default sysdate,
                           updateDate date default sysdate
);

create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key(rno);

alter table tbl_reply add constraint fk_reply_board
    foreign key (bno) references tbl_board(bno);

-- 답글 수 칼럼 추가
alter table tbl_board add(replycnt number default 0);

-- 기존에 답글 존재 시 해당 답글을 조회수에 반영
update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

