package com.caps.asp.service;

import com.caps.asp.model.TbImage;
import com.caps.asp.repository.ImageRepository;
import org.springframework.stereotype.Service;

@Service
public class ImageService {

    public final ImageRepository imageRepository;

    public ImageService(ImageRepository imageRepository) {
        this.imageRepository = imageRepository;
    }

    public void saveImage(TbImage image){
        imageRepository.save(image);
    }

    public void deleteAllImageByRoomId(int roomId){
        imageRepository.deleteAllByRoomId(roomId);
    }
}
