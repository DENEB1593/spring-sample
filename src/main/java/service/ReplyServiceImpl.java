package service;

import domain.Criteria;
import domain.ReplyPageDTO;
import domain.ReplyVO;
import lombok.Setter;
import lombok.extern.slf4j.Slf4j;
import mapper.BoardMapper;
import mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class ReplyServiceImpl implements ReplyService {

    @Setter(onMethod_ = @Autowired)
    private ReplyMapper replyMapper;

    @Setter(onMethod_ = @Autowired)
    private BoardMapper boardMapper;

    @Transactional
    @Override
    public int register(ReplyVO vo) {
        log.info("register......" + vo);
        boardMapper.updateReplyCnt(vo.getBno(), 1);
        return replyMapper.insert(vo);
    }

    @Override
    public ReplyVO get(Long rno) {
        log.info("get......" + rno);
        return replyMapper.read(rno);
    }

    @Override
    public int modify(ReplyVO vo) {
        log.info("modify......" + vo);
        return replyMapper.update(vo);
    }

    @Transactional
    @Override
    public int remove(Long rno) {
        log.info("remove......" + rno);
        ReplyVO reply = replyMapper.read(rno);
        boardMapper.updateReplyCnt(reply.getBno(), -1);
        return replyMapper.delete(rno);
    }

    @Override
    public List<ReplyVO> getList(Criteria cri, Long bno) {
        log.info("get Reply List of a Board " + bno);
        return replyMapper.getListWithPaging(cri, bno);
    }

    @Override
    public ReplyPageDTO getListPage(Criteria cri, Long bno) {
        return new ReplyPageDTO(
                replyMapper.getCountByBno(bno),
                replyMapper.getListWithPaging(cri, bno));
    }

}
