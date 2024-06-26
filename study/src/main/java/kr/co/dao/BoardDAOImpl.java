package kr.co.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import kr.co.vo.BoardVO;
import kr.co.vo.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;
	
	//게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insert", boardVO);
		
	}

	@Override
	public List<BoardVO> listAll(SearchCriteria scri) throws Exception {
		
		return sqlSession.selectList("boardMapper.list", scri);
	}
	
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		
		return sqlSession.selectList("boardMapper.listPage", scri);
	}

	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.listCount", scri);
	}
	
	@Override
	public void writeItem(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insertItem", boardVO);
		
	}
	
	@Override
	public void delete(BoardVO boardVO) throws Exception {
		
		sqlSession.delete("boardMapper.delete", boardVO);
	}

	@Override
	public List<BoardVO> excelList(SearchCriteria scri) throws Exception {
		
		return sqlSession.selectList("boardMapper.excelList", scri);
	}
	
	@Override
	public List<BoardVO> excelListPage(SearchCriteria scri) throws Exception {
		
		return sqlSession.selectList("boardMapper.excelListPage", scri);
	}

	@Override
	public int excelListCount(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.excelListCount", scri);
	}
	
	@Override
	public void deleteList(BoardVO boardVO) throws Exception {
		
		sqlSession.delete("boardMapper.deleteList", boardVO);
	}
	
	@Override
	public void writeItemError(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insertItemError", boardVO);
		
	}
}
