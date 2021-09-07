package controller;

import domain.BoardVO;
import domain.Criteria;
import domain.PageDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import service.BoardService;

@Controller
@Slf4j
@RequiredArgsConstructor
@RequestMapping("/board/*")
public class BoardController {
    private final BoardService boardService;

    @GetMapping("/list")
    public void list(Criteria cri, Model model) {
        log.info("/list");
        model.addAttribute("list", boardService.getList(cri));

        int total = boardService.getTotal(cri);

        log.info("totalCount: {}", total);
        model.addAttribute("pageMaker", new PageDTO(cri, total));
    }

    @GetMapping("/register")
    public void register() {

    }

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes attr) {
        log.info("/register");
        boardService.register(board);
        attr.addFlashAttribute("result", board.getBno());
        return "redirect:/board/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
        log.info("/get or /modify");
        model.addAttribute("board", boardService.get(bno));
    }

    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes attr) {
        log.info("/modify board: {}", board);

        if (boardService.modify(board)) {
           attr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + cri.getListLink();
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes attr) {
        log.info("/remove bno: {}", bno);

        if (boardService.remove(bno)) {
            attr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + cri.getListLink();
    }
}