package kr.co.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.co.dao.BoardDAO;
import kr.co.vo.BoardVO;
import kr.co.vo.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;
	
	//게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		dao.write(boardVO);
		
	}
	
	@Override
	public List<BoardVO> listAll(SearchCriteria scri) throws Exception {
	
		return dao.listAll(scri);
	}
	
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
	
		return dao.list(scri);
	}

	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.listCount(scri);
	}

	@Override
	public void writeItem(BoardVO boardVO) throws Exception {
		dao.writeItem(boardVO);
		
	}
	
	@Override
	public void delete(BoardVO boardVO) throws Exception {
		
		dao.delete(boardVO);
	}
	
	@Override
	public List<BoardVO> excelList(SearchCriteria scri) throws Exception {
	
		return dao.excelList(scri);
	}
	
	@Override
	public List<BoardVO> excelListPage(SearchCriteria scri) throws Exception {
	
		return dao.excelListPage(scri);
	}

	@Override
	public int excelListCount(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return dao.excelListCount(scri);
	}
	
	@Override
	public void deleteList(BoardVO boardVO) throws Exception {
		
		dao.deleteList(boardVO);
	}
	
	@Override
	public void writeItemError(BoardVO boardVO) throws Exception {
		dao.writeItemError(boardVO);
		
	}
	
}
