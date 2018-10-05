package com.caps.asp.repository;

import com.caps.asp.model.TbImage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ImageRepository extends JpaRepository<TbImage, Integer> {
}
