package service;

import domain.BoardVO;
import domain.Criteria;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mapper.BoardMapper;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {

    private final BoardMapper boardMapper;
    private final int SUCCESS = 1;

    @Override
    public List<BoardVO> getList(Criteria cri) {
        log.info("BoardService - getList");
        List<BoardVO> boardList = boardMapper.getListWithPaging(cri);
        return boardList  == null ?
                Collections.emptyList() : boardList;
    }

    @Override
    public BoardVO get(Long bno) {
        log.info("BoardService - getRead");
        return boardMapper.read(bno);
    }

    @Override
    public boolean register(BoardVO board) {
        log.info("BoardService - register");
        return boardMapper.insertSelectKey(board) == SUCCESS;
    }

    @Override
    public boolean modify(BoardVO board) {
        log.info("BoardService - modify");
        return boardMapper.update(board) == SUCCESS;
    }

    @Override
    public boolean remove(Long bno) {
        log.info("BoardService - delete");
        return boardMapper.delete(bno) == SUCCESS;
    }

    @Override
    public int getTotal(Criteria cri) {
        log.info("BoardService - getTotal");
        return boardMapper.getTotalCount(cri);
    }
}