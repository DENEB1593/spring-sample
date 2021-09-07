package mapper;

import config.RootConfig;
import domain.BoardVO;
import domain.Criteria;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {RootConfig.class})
@Slf4j
public class BoardMapperTests {
    @Setter(onMethod_ = { @Autowired })
    private BoardMapper boardMapper;

    @Test
    @Ignore
    public void testList() {
        log.info("BoardMapperTests - testList");
        boardMapper.getList().forEach(board -> {
            log.info(board.toString());
        });
    }

    @Test
    @Ignore
    public void testListWithPaging() {
        log.info("BoardMapperTests - testListWithPaging");
        boardMapper.getListWithPaging(new Criteria())
                .forEach(board -> log.info("{}", board));
    }

    @Test
    public void testPaging() {
        log.info("BoardMapperTests - testPaging");
        boardMapper.getListWithPaging(new Criteria(1, 5))
                .forEach(board -> log.info("{}", board.getBno()));

    }

    @Test
    @Ignore
    public void testInsert() {
        log.info("BoardMapperTests - testRegister");
        BoardVO board = BoardVO.builder()
                .title("junit 테스트용 제목").content("junit 테스트용 내용").writer("JUNIT")
                .build();
        log.info("board info: {}", board);
        boardMapper.insert(board);
    }

    @Test
    @Ignore
    public void testInsertSelectKey() {
        log.info("BoardMapperTests - testInsertSelectKey");
        BoardVO board = BoardVO.builder()
                .title("junit 테스트용 제목").content("junit 테스트용 내용 insertselectkey").writer("JUNIT")
                .build();
        log.info("board info: {}", board);
        boardMapper.insertSelectKey(board);
    }

    @Test
    @Ignore
    public void testRead() {
        log.info("BoardMapperTests - testRead");
        long bno = 4L;
        BoardVO board = boardMapper.read(bno);
        log.info("board info: {}", board);
    }

    @Test
    @Ignore
    public void testUpdate() {
        log.info("BoardMapperTests - testUpdate");
        BoardVO board = BoardVO.builder()
                .title("수정 제목").content("수정 내용").writer("JUNIT")
                .bno(4L)
                .build();
        log.info("board update result: {}", boardMapper.update(board));
    }

    @Test
    @Ignore
    public void testDelete() {
        log.info("BoardMapperTests - testDelete");
        long bno = 4L;
        log.info("board delete result: {}", boardMapper.delete(bno));
    }

    @Test
    @Ignore
    public void testTotal() {
        log.info("BoardMapperTests - testTotalCount");
        log.info("total count: {}", boardMapper.getTotalCount(new Criteria(1, 10)));
    }

    @Test
    public void testSearch() {
        Criteria cri = new Criteria();
        cri.setKeyword("");
        cri.setType("TC");
        List<BoardVO> list = boardMapper.getListWithPaging(cri);
        list.forEach(board -> {
            log.info("{}", board);
        });
    }
}