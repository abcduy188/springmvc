package com.javaweb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.javaweb.entity.ProductEntity;

public interface ProductRepository extends JpaRepository<ProductEntity, Long> {
	@Query("SELECT s FROM ProductEntity s WHERE s.tensp LIKE %?1%")
	public List<ProductEntity> search(String keyword);
}
