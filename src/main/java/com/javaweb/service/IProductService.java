package com.javaweb.service;

import java.util.List;

import com.javaweb.DTO.ProductDTO;

public interface IProductService {
	List<ProductDTO> findAll();
	ProductDTO findById(long id);
	ProductDTO save(ProductDTO dto);
	void delete(long[] ids);
}
