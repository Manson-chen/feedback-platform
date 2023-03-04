# EasyFeedback
Object Oriented Application Framework Project



## Project Functionalities

1. 准备好窗口，下载关闭vpn，再打开
2. 解压后，先运行server，再运行client
3. 记得先退出登录
4. 展示Topic的功能；包括右边栏
5. user的注册（去邮箱验证，展示未激活登录报错）和登录
6. 展示话题详情选择不要最推荐的
7. 选择评论多一点的进去评论，不然评论数量未更新（问题）
8. user5.1回复评论最好评论话题，和回复最后一个reply（问题）
9. 用户收藏完之后取消，只留下点赞，返回主页看效果
10. 用户页进去话题详情点击空白处
11. pm记得不要点赞和收藏
12. Product topic
13. Topic
    	testGetByTopicName()
    	testGetByTopicId()
    	testCollectedByUid()
    	testGetLatestTopic()
    	testGetHotTopic()
    	
    Comment
    	testListComment()
    Pm
    	testValidUserLogin()
    	testSaveTopic()
    	testUpdateProfile()
    User
    	testValidUserLogin()
    	testGetTopicByComment()



- Topic
  1. Show the recommended(hot) topic

  2. Show the latest topic

  3. Show details of the topic (including topic name, content, photos and comments)

  4. Search topic by topic name

  5. Using paging to display the topic list and comments (two levels)




记得先退出登录

- Client (user): 

  1. Register
  2. Login
  3. Forget password
  4. View details of the topic
  5. Actions with the topic
     1. Add comment to the topic
     2. Collect the topic
     3. Like the topic
  6. Show the use's profile
  7. Chang profile (including the user's ==avatar==)
  8. Change password
  9. View topics that users have liked, collected and commented on



- Business(pm)
  1. Register
  2. Login
  3. Forget password
  4. Chang profile (including the pm's avatar)
  5. Change password
  6. Create topics
  7. Manage topic
  8. View details of the topic
  9. Communicate with users using comments



## Server

### 1 Libraries

```
java 1.8
springboot 2.7.3
mybatis 2.2.2
druid 1.1.16
lombok 1.18.12
slf4j 1.7.20
logback 1.2.3
java-jwt 3.9.0
json 20190722
mysql 8.0.27
httpclient 4.4
httpmime 4.4
pagehelper 1.4.1
```



### 2 A quick guide to run

- run the main function in EasyfeedbackApplication.java

  ```
  package com.elec5619;
  
  import org.springframework.boot.SpringApplication;
  import org.springframework.boot.autoconfigure.SpringBootApplication;
  
  @SpringBootApplication
  public class EasyfeedbackApplication {
  
      public static void main(String[] args) {
          SpringApplication.run(EasyfeedbackApplication.class, args);
      }
  }
  ```

  





## Client

### 1 Libraries

```
{
		"axios": "^0.26.1",
    "core-js": "^3.8.3",
    "element-ui": "^2.15.6",
    "install": "^0.13.0",
    "js-md5": "^0.7.3",
    "lib-flexible": "^0.3.2",
    "vue": "^2.6.14",
    "vue-router": "^3.2.0",
    "vuex": "^3.2.0"
}
```



### 2 A quick guide to run

#### Project setup

```
npm install
```

#### Compiles and hot-reloads for development

```
npm run serve
```

### 
