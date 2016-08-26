package com.springmvc.web;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.springmvc.service.UserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.springmvc.entity.User;

@Controller
@RequestMapping("/user")
public class UserController{

	@Autowired
	private UserService userService;
	
	
	/*
	 * 登录验证
	 */
	@ResponseBody
    @RequestMapping(value="/loginCheck",method=RequestMethod.GET)
	public JSONObject loginCheck(HttpServletRequest request,@RequestParam String userName,@RequestParam String password) {
		
		JSONObject jsonObj = new JSONObject();
		
		User user = userService.findByUserName(userName);
		if (user == null) {
			jsonObj.put("msg", "用户名不存在");
		} else if (!user.getPassword().equals(password)) {
			jsonObj.put("msg", "登录密码错误");
		} else {
			jsonObj.put("msg", "登录成功");
            user.setLastIp(request.getRemoteAddr());
            user.setLastVisit(new Date());
            userService.updateUserInfo(user);
            userService.saveLoginLog(user);
            request.getSession().setAttribute("user", userName);
            request.getSession().setAttribute("loginState", "login");
		}
		
		return jsonObj;
	}
	
	
	/*
	 * 登录注销
	 */
    @RequestMapping("/doLogout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        session.invalidate();
        return "login";
    }
    
    
    /*
     * 用户注册
     */
    @ResponseBody
	@RequestMapping(value="/register")
	public JSONObject register(HttpServletRequest request,User user){
		JSONObject jsonObj = new JSONObject();
		if(userService.findByUserName(user.getUserName())!=null){
			jsonObj.put("msg", "error");
		}
		else{
			jsonObj.put("msg", "success"); 
			userService.saveUserInfo(user);
		}
		return jsonObj;
	}
    
    
    /*
     * 修改密码
     */
    @RequestMapping(value="/changePsw")
    public void changePassword(@RequestParam String userName,@RequestParam String password){
    	User user = userService.findByUserName(userName);
    	user.setPassword(password);
    	userService.updateUserInfo(user);
    }
    
}
	