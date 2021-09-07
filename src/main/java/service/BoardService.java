package service;

import domain.BoardVO;
import domain.Criteria;

import java.util.List;

public interface BoardService {
//    public List<BoardVO> getList();

    public List<BoardVO> getList(Criteria cri);

    public BoardVO get(Long bno);

    public boolean register(BoardVO board);

    public boolean modify(BoardVO board);

    public boolean remove(Long bno);

    public int getTotal(Criteria cri);
}