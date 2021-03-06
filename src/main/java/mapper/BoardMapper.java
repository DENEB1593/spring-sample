package mapper;

import domain.BoardVO;
import domain.Criteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {
    //@Select("select * from tbl_board")
    public List<BoardVO> getList();

    public List<BoardVO> getListWithPaging(Criteria cri);

    public int insert(BoardVO board);

    public int insertSelectKey(BoardVO board);

    public BoardVO read(Long bno);

    public int delete(Long bno);

    public int update(BoardVO board);

    public int getTotalCount(Criteria cri);

    public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
}
