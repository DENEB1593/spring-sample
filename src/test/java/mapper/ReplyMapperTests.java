package mapper;

import config.RootConfig;
import domain.Criteria;
import domain.ReplyVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.stream.IntStream;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Slf4j
public class ReplyMapperTests {
    @Setter(onMethod_ = @Autowired)
    private ReplyMapper replyMapper;

    @Test
    @Ignore
    public void testGetMapper() {
        log.info("{}", replyMapper);
    }

    //테스트 전에 해당 번호 게시물이 존재하는지 꼭 확인
    private Long[] bnoArr = {33L, 34L, 35L, 36L, 37L};

    @Test
    @Ignore
    public void testInsert() {
        IntStream.rangeClosed(1, 10).forEach(i -> {
            ReplyVO vo = new ReplyVO();

            vo.setBno(bnoArr[i % 5]);
            vo.setReply("댓글 테스트 " + i);
            vo.setReplyer("replyer" + i);

            replyMapper.insert(vo);
        });
    }

    @Test
    @Ignore
    public void testRead() {
        Long rno = 37L;
        ReplyVO reply = replyMapper.read(rno);
        log.info("{}", reply);
    }

    @Test
    @Ignore
    public void testDelete() {

    }

    @Test
    @Ignore
    public void testUpdate() {
        Long targetRno = 11L;
        ReplyVO vo = replyMapper.read(targetRno);

        vo.setReply("Update Reply ");
        int count = replyMapper.update(vo);

        log.info("UPDATE COUNT: " + count);
    }

    @Test
    @Ignore
    public void testList() {
        Criteria cri = new Criteria();
        List<ReplyVO> replies = replyMapper.getListWithPaging(cri, 37L);
        replies.forEach(reply -> {
            log.info("{}", reply);
        });
    }

    @Test
    public void testList2() {
        Criteria cri = new Criteria(2, 10);
        List<ReplyVO> replies = replyMapper.getListWithPaging(cri, 37L );

        replies.forEach(reply -> log.info("{}",reply));
    }
}
