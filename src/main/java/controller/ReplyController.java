package controller;

import domain.Criteria;
import domain.ReplyPageDTO;
import domain.ReplyVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import service.ReplyService;

@RequestMapping("/replies/")
@Slf4j
@RestController
@RequiredArgsConstructor
public class ReplyController {
    private final ReplyService replyService;

    @PostMapping(value = "/new", consumes="application/json", produces= {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody ReplyVO vo) {

        log.info("ReplyVO: " + vo);
        int insertCount = replyService.register(vo);

        log.info("Reply INSERT COUNT: " + insertCount);

        return insertCount==1 ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value="/pages/{bno}/{page}", produces= {
            MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE
    })
    public ResponseEntity<ReplyPageDTO> getList(
            @PathVariable("page") int page,
            @PathVariable("bno") Long bno
    ) {
        log.info("getList...............");
        Criteria cri = new Criteria(page, 10);
        log.info("{}", cri);
        return new ResponseEntity<>(replyService.getListPage(cri, bno), HttpStatus.OK);
    }

    @GetMapping(value="/{rno}", produces= {
            MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE
    })
    public ResponseEntity<ReplyVO> get(@PathVariable("rno") Long rno )
    {

        log.info("get : {}", rno);
        return new ResponseEntity<>(replyService.get(rno), HttpStatus.OK);
    }


    @DeleteMapping(value="/{rno}", produces = {
            MediaType.TEXT_PLAIN_VALUE
    })
    public ResponseEntity<String> remove(@PathVariable("rno") Long rno){
        log.info("remove : {}", rno);
        return replyService.remove(rno) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @RequestMapping(method= {RequestMethod.PUT, RequestMethod.PATCH},
                    value="/{rno}",
                    consumes="application/json",
                    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(
            @RequestBody ReplyVO vo, @PathVariable("rno") Long rno) {
        vo.setRno(rno);
        log.info("rno : {}", rno);
        log.info("modify : {}", vo);

        return replyService.modify(vo) == 1
                ? new ResponseEntity<> ("success", HttpStatus.OK)
                : new ResponseEntity<> (HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
