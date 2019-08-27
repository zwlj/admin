package com.wl.admin.controller;

import com.alibaba.fastjson.JSONObject;
import com.wl.admin.service.MailService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Desc
 * @Author Wanglei
 * @CreateTime 2019/8/27 16:40
 **/
@RestController
@Api("发送邮件")
@RequestMapping("/mail")
public class MailController {

    @Autowired
    private MailService mailService;
    @ApiOperation(value = "发文本邮件",notes = "获取留言人的信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "jsonObject", value = "{\"phone\":\"电话\",\"text\":\"留言内容\",\"name\":\"姓名\"}"
                    , required = true, dataType = "String",paramType="body")
    })
    @PostMapping("/text")
    public void sendMail(@RequestBody JSONObject jsonObject){
        StringBuilder stringBuilder=new StringBuilder(50);
        stringBuilder.append("电话："+jsonObject.getString("phone"));
        stringBuilder.append("\r\n留言内容："+jsonObject.getString("text"));
        stringBuilder.append("\r\n姓名："+jsonObject.getString("name"));
        mailService.sendSimpleMail("625363199@qq.com","留言",stringBuilder.toString());
    }
}
