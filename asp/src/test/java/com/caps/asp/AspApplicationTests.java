package com.caps.asp;

import com.caps.asp.model.TbPost;
import com.caps.asp.model.uimodel.SearchRequestModel;
import com.caps.asp.service.PostService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class AspApplicationTests {

	@Autowired
	private PostService postService;

	@Test
	public void contextLoads() {
		List<String> usernameList = new ArrayList<>();
		usernameList.add("10");
		usernameList.add("Gò Vấp");

		//List role
		List<String> roleList = new ArrayList<>();
		roleList.add("Camera an ninh");
		roleList.add("Bảo vệ");
		roleList.add("Máy giặt");

		SearchRequestModel search=new SearchRequestModel();
		search.setDistricts(usernameList);
		search.setUtilities(roleList);

		List<TbPost> userList = postService.search(search);
		System.out.println(userList);
	}

}
