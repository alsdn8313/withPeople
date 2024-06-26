package kr.co.service;

import java.util.List;

import kr.co.vo.BoardVO;
import kr.co.vo.SearchCriteria;

public interface BoardService {

	//게시글 작성
	public void write(BoardVO boardVO) throws Exception;
	
	public List<BoardVO> listAll(SearchCriteria scri) throws Exception;
	
	// 게시물 목록 조회(페이징)
	public List<BoardVO> list(SearchCriteria scri) throws Exception;
	
	// 게시물 총 갯수
	public int listCount(SearchCriteria scri) throws Exception;
	
	// 조회리스트 저장
	public void writeItem(BoardVO boardVO) throws Exception;
	
	public void delete(BoardVO boardVO) throws Exception;
	
	public List<BoardVO> excelList(SearchCriteria scri) throws Exception;
	
	public List<BoardVO> excelListPage(SearchCriteria scri) throws Exception;
	
	public int excelListCount(SearchCriteria scri) throws Exception;
	
	public void deleteList(BoardVO boardVO) throws Exception;
	
	public void writeItemError(BoardVO boardVO) throws Exception;
}
