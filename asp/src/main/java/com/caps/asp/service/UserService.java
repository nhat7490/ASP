package com.caps.asp.service;

import com.caps.asp.constant.Constant;
import com.caps.asp.exception.UserException;
import com.caps.asp.model.TbUser;
import com.caps.asp.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.caps.asp.constant.Constant.MEMBER;

@Service
public class UserService {
    public final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public TbUser findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    public TbUser findById(int id) {
        return userRepository.findByUserId(id);
    }

    public void updateUserById(TbUser user) {
        TbUser tbUser = userRepository.findByUserId(user.getUserId());
        if (tbUser != null) {
            tbUser.setUsername(user.getUsername());
            tbUser.setPassword(user.getPassword());
            tbUser.setEmail(user.getEmail());
            tbUser.setFullname(user.getFullname());
            tbUser.setDob(user.getDob());
            tbUser.setGender(user.getGender());
            tbUser.setImageProfile(user.getImageProfile());
            tbUser.setPhone(user.getPhone());
        }
        userRepository.save(tbUser);
    }

    public Integer createUser(TbUser user) throws UserException.UsernameExistedException {
        TbUser tbUser = userRepository.findByUsername(user.getUsername());
        if (tbUser == null) {
            user.setRoleId(MEMBER);
            userRepository.saveAndFlush(user);
        }else{
            throw new UserException.UsernameExistedException();
        }
        return user.getUserId();
    }

    //For test in heroku
    public List<TbUser> getAllUsers() {
        return userRepository.findAll();
    }

    public TbUser findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }
}
