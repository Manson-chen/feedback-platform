CREATE TABLE `tbl_user` (
  `uid` bigint NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) UNIQUE NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(30) UNIQUE NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `phone_number` varchar(30) DEFAULT NULL,
  `hobby` varchar(50) DEFAULT NULL,
  `avatar` varchar(50) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` int unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tbl_user(
	uid BIGINT(20) NOT NULL AUTO_INCREMENT,
	user_name VARCHAR(20) UNIQUE NOT NULL,
	password VARCHAR(100) NOT NULL,
	email VARCHAR(30) UNIQUE NOT NULL,
	address VARCHAR(50),
	phone_number VARCHAR(30) UNIQUE,
	hobby VARCHAR(50),
	avatar VARCHAR(50), -- default file path: ?
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	status INT NOT NULL CHECK(status in (0, 1)), -- 激活状态：0未激活，1已激活
	PRIMARY KEY (uid)
);

CREATE TABLE tbl_pm(
	pm_id BIGINT(20) NOT NULL AUTO_INCREMENT,
	pm_name VARCHAR(20) UNIQUE NOT NULL,
	password VARCHAR(30) NOT NULL,
	email VARCHAR(30) UNIQUE NOT null,
	address VARCHAR(50),
	phone_number VARCHAR(30) UNIQUE,
	hobby VARCHAR(50),
	avatar VARCHAR(50), -- default file path: ?
	company VARCHAR(50),
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP  NOT NULL,
	update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (pm_id)
);

CREATE TABLE tbl_topic(
	topic_id BIGINT(20) NOT NULL AUTO_INCREMENT,
	pm_id BIGINT(20) NOT NULL,
	topic_name VARCHAR(50),
	content text NOT NULL,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (topic_id, pm_id),
	FOREIGN KEY (pm_id) REFERENCES tbl_pm(pm_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_topicPhoto(
	id BIGINT(20) PRIMARY KEY AUTO_INCREMENT,
	topic_id BIGINT(20) NOT NULL,
	photo VARCHAR(50), -- file path
	FOREIGN KEY (topic_id) REFERENCES tbl_topic(topic_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_likes(
	id BIGINT(20) NOT NULL AUTO_INCREMENT,
	topic_id BIGINT(20) NOT NULL,
	uid BIGINT(20) NOT NULL,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (topic_id, uid),
	KEY(id),
	FOREIGN KEY (uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (topic_id) REFERENCES tbl_topic(topic_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_collects(
	id BIGINT(20) NOT NULL AUTO_INCREMENT,
	topic_id BIGINT(20) NOT NULL,
	uid BIGINT(20) NOT NULL,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (topic_id, uid),
	KEY(id),
	FOREIGN KEY (uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (topic_id) REFERENCES tbl_topic(topic_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE tbl_comment(
	id BIGINT(20) NOT NULL AUTO_INCREMENT,
	topic_id BIGINT(20) NOT NULL,
	role VARCHAR(4) NOT NULL CHECK(role = 'pm' or role = 'user' ),
	uid BIGINT(20) NOT NULL,
	content text NOT NULL,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (id, topic_id, uid, role),
-- 	FOREIGN KEY (uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (topic_id) REFERENCES tbl_topic(topic_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tbl_reply(
	id BIGINT(20) NOT NULL AUTO_INCREMENT,
	comment_id BIGINT(20) NOT NULL, -- 来表示该回复挂在的根评论id
	from_role VARCHAR(4) NOT NULL CHECK(from_role = 'pm' or from_role = 'user' ),
	from_uid BIGINT(20) NOT NULL,
	to_role VARCHAR(4) NOT NULL CHECK(to_role = 'pm' or to_role = 'user' ),
	to_uid BIGINT(20) NOT NULL,
	reply_type VARCHAR(7) NOT NULL CHECK(reply_type = 'reply' or reply_type = 'comment' ), -- 表示回复的类型，因为回复可以是针对评论的回复 (comment) 也可以是针对回复的回复 (reply)
	reply_id BIGINT(20) NOT NULL,	-- 表示回复目标的id,如果 reply_type 是 comment 的话,那么 reply_id = commit id,如果 reply_type 是 reply 的话,这表示这条回复的父回复.
	content text NOT NULL,
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
	PRIMARY KEY (id, comment_id, from_uid, from_role),
	FOREIGN KEY (comment_id) REFERENCES tbl_comment(id) ON DELETE CASCADE ON UPDATE CASCADE
-- 	FOREIGN KEY (from_uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE,
-- 	FOREIGN KEY (to_uid) REFERENCES tbl_user(uid) ON DELETE CASCADE ON UPDATE CASCADE
);

-- show variables like '%time_zone%'; 
-- select now();
-- set time_zone = '+8:00';
-- set global time_zone = '+8:00';
-- FLUSH PRIVILEGES

alter table tbl_user add unique key(email);
alter table tbl_pm add unique key(email);

SELECT * from tbl_user;
-- SELECT * from tbl_userPhoto;
SELECT * from tbl_pm;
-- SELECT * from tbl_pmPhoto;
SELECT * from tbl_topic;
SELECT * from tbl_topicPhoto;
SELECT * from tbl_likes;
SELECT * from tbl_collects;
SELECT * from tbl_comment;
SELECT * from tbl_reply;

DROP TABLE tbl_reply;
DROP TABLE tbl_comment;
DROP TABLE tbl_collects;
DROP TABLE tbl_likes;
DROP TABLE tbl_topicPhoto;
DROP TABLE tbl_topic;
-- DROP TABLE tbl_pmPhoto;
DROP TABLE tbl_pm;
-- DROP TABLE tbl_userPhoto;
DROP TABLE tbl_user;


INSERT INTO tbl_user VALUES( null, 'user2', 'abc123', '948936249@qq.com', 'china', null, null, null, '2022-01-19 22:22:22', '2022-01-19 22:22:22');

INSERT INTO tbl_pm VALUES(null, 'pm2', 'abc123', '948936249@qq.com', 'China', '13812345678', 'Basketball, movie', null, 'Tencent', '2022-01-19 22:22:22', '2022-01-19 22:22:22');

-- 少了update_time
INSERT INTO tbl_topic VALUES(null, 1, 'The best way to study', 'read mroe, listen more and speak more!', '2022-01-19 10:15:00');
INSERT INTO tbl_topic VALUES(null, 1, 'The best way to study2', 'read mroe, listen more and speak more!', '2022-01-20 11:11:11');
INSERT INTO tbl_topic VALUES(null, 1, 'Test1', 'test1,test1,test1', '2022-09-28 17:08:11');

INSERT INTO tbl_comment VALUES(null, 2, 'user', 1, 'very good!', '2022-01-19 11:11:11');
INSERT INTO tbl_comment VALUES(null, 2, 'user', 1, 'very good222!', '2022-01-19 22:22:22');
INSERT INTO tbl_comment VALUES(null, 3, 'pm', 1, 'test comment1', '2022-09-28 17:10:11');

INSERT INTO tbl_reply VALUES(null, 1, 'pm', 1, 'user', 1, 'comment', 1, 'reply test1', '2022-01-19 22:22:22');
INSERT INTO tbl_reply VALUES(null, 1, 'user', 1, 'pm', 1, 'reply', 1, 'reply test1', '2022-01-19 22:22:22');

INSERT INTO tbl_collects VALUES(null, 2, 1, '2022-09-19 22:22:22');
INSERT INTO tbl_likes VALUES(null, 2, 1, '2022-09-19 22:22:22');


-- 获取用户收藏、点赞、评论数量
select count(*) from tbl_collects where uid = 1;

-- 获取用户收藏、点赞、评论的话题
select * from tbl_topic where topic_id in (select topic_id from tbl_collects where uid = 1);
select * from tbl_topic where topic_id in (select topic_id from tbl_likes where uid = 1);
select * from tbl_topic where topic_id in (
	select distinct(topic_id) from tbl_comment where (
		id in (select comment_id from tbl_reply where from_uid = 1 and from_role = 'user')) 
		or (uid = 1 and role = 'user')
		)
		
-- 获取pm创建话题的相关数据
select * from tbl_topic where pm_id = 1;
select count(*) from tbl_collects where topic_id = 1;
select count(*) from tbl_likes where topic_id = 1;
select sum(comment + reply) 
from (select count(*) as comment from tbl_comment where topic_id = 2) com,
		 (select count(*) as reply from tbl_reply where comment_id in 
				(select comment_id from tbl_comment where topic_id = 2)) rep

-- 根据topicName 来搜索话题
SELECT * FROM tbl_topic WHERE topic_name LIKE '%study%'
-- 查询用户是否收藏该话题
SELECT * from tbl_collects WHERE topic_id = 2 and uid = 1;
-- 查询该话题的评论数，包括一级评论表和二级表
SELECT topic_id, COUNT(*) FROM tbl_comment WHERE topic_id = 2;
SELECT COUNT(*) FROM tbl_reply WHERE comment_id IN
	(SELECT id FROM tbl_comment WHERE topic_id = 2);
-- 查询用户是否点赞该话题
SELECT IFNULL(id, FALSE) from tbl_likes WHERE topic_id = 1 and uid = 1;
-- 根据时间排序最新话题
SELECT * FROM tbl_topic ORDER BY create_time DESC;

-- SELECT *
-- FROM tbl_topic JOIN tbl_comment USING (topic_id)
-- 			JOIN tbl_reply t2 ON (t1.id = t2.comment_id)

-- 话题总评论数：一级评论+二级评论
SELECT topic_id, IFNULL(SUM(comment + IFNULL(reply, 0)),0) AS total_comments
FROM
	(SELECT topic.topic_id, comment , reply -- , SUM(rep.reply + com.comment) AS total_comments
	FROM
		(tbl_topic topic
	LEFT JOIN
		(SELECT topic_id, COUNT(*) AS comment
			FROM tbl_comment
			GROUP BY topic_id) com USING(topic_id))
	LEFT JOIN
		(SELECT topic_id, COUNT(*) AS reply  -- 话题二级评论的数量
			FROM tbl_comment com JOIN tbl_reply rep on com.id = rep.comment_id
			GROUP BY topic_id) rep
	ON rep.topic_id = com.topic_id) total
GROUP BY topic_id;
	
-- 总点赞数
SELECT tbl_topic.topic_id, IFNULL(likes,0) AS likeNum
FROM 
	tbl_topic 
LEFT JOIN
	(SELECT topic_id, COUNT(*) AS likes
	FROM tbl_likes
	GROUP BY topic_id) tb_like USING(topic_id)
WHERE topic_id = 3;

-- 总收藏数
SELECT COUNT(*) AS collects
FROM tbl_collects
GROUP BY topic_id
HAVING topic_id = 2;

-- 封装话题信息：(topic_id, topicName, content, date, pm_id, pmName, photo) / (collectNum, collectState, commentNum, likeNum, likeState )
SELECT  topic_id, topicName, content, tbl_topic.date, pmName, photo
FROM 
	tbl_topic LEFT JOIN tbl_pm USING(pm_id)
						LEFT JOIN tbl_pmPhoto USING(pm_id)
WHERE topicName LIKE '%study%';

