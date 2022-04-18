package com.model2.mvc.service.product.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDao;

@Repository("productDaoImpl")
public class ProductDaoImpl implements ProductDao{


	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public ProductDaoImpl() {
		System.out.println(this.getClass());
	}

	public Product getProduct(int prod_no) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getProduct" ,prod_no);
	}

  	public List<Product> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
	 return sqlSession.selectList("ProductMapper.getProductList", search);
	}

 	public void insertProduct(Product product) throws Exception {
 		sqlSession.insert("ProductMapper.addProduct" , product) ;
		
	}

 	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("ProductMapper.updateProduct", product);

	}

 	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
 		int i = sqlSession.selectOne("ProductMapper.getTotalCount", search);
 		System.out.println("DAO에서 친히 부릅니다. 너의 토탈 카운트  값은 ? " + i);
		return sqlSession.selectOne("ProductMapper.getTotalCount", search);
	}

 	public int findTrandtranNo(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("ProductMapper.getTrandCode" ,prodNo);
	}
	
	
	

}

