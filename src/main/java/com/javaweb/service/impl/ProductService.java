package com.javaweb.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.javaweb.DTO.ProductDTO;
import com.javaweb.converter.ProductConverter;
import com.javaweb.entity.CategoryEntity;
import com.javaweb.entity.ProductEntity;
import com.javaweb.repository.CategoryRepository;
import com.javaweb.repository.ProductRepository;
import com.javaweb.service.IProductService;

@Service
public class ProductService implements IProductService {

	@Autowired
	private ProductRepository productRepositpory;
	@Autowired
	private ProductConverter productConverter;
	@Autowired
	private CategoryRepository categoryRepository;

	@Override
	public List<ProductDTO> findAll() {
		List<ProductDTO> models = new ArrayList<>();
		List<ProductEntity> entities = productRepositpory.findAll();
		for (ProductEntity item : entities) {
			ProductDTO productDTO = productConverter.toDto(item);
			models.add(productDTO);
		}
		return models;
	}

	@Override
	public ProductDTO findById(long id) {
		ProductEntity entity = productRepositpory.findOne(id);
		return productConverter.toDto(entity);
	}

	@Override
	@Transactional
	public ProductDTO save(ProductDTO dto) {
		CategoryEntity category = categoryRepository.findOneByCode(dto.getCategoryCode());// findcategory by code
		ProductEntity productEntity = new ProductEntity();
		if (dto.getId() != null) {
			ProductEntity oldNew = productRepositpory.findOne(dto.getId());
			oldNew.setCategory(category);
			productEntity = productConverter.toEntity(oldNew, dto);
		} else {
			productEntity = productConverter.toEntity(dto);
			productEntity.setCategory(category);
		}
		return productConverter.toDto(productRepositpory.save(productEntity));
	}

}
