/*
 Navicat Premium Data Transfer

 Source Server         : aliyun
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : 116.62.123.3:3306
 Source Schema         : vote_system

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 01/04/2021 20:20:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `path` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `icon_cls` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `component` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `parent_id` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_menu
-- ----------------------------
INSERT INTO `admin_menu` VALUES (1, '/admin', 'AdminIndex', '投票管理', 'el-icon-tickets', 'AdminIndex', 0);
INSERT INTO `admin_menu` VALUES (2, '/admin/vote/list', 'ListActivity', '活动列表', NULL, 'vote/ListActivity', 1);
INSERT INTO `admin_menu` VALUES (3, '/admin', 'User', '用户管理', 'el-icon-user', 'AdminIndex', 0);
INSERT INTO `admin_menu` VALUES (4, '/admin', 'Content', '内容管理', 'el-icon-document', 'AdminIndex', 0);
INSERT INTO `admin_menu` VALUES (5, '/admin', 'Account', '账号设置', 'el-icon-setting', 'AdminIndex', 0);
INSERT INTO `admin_menu` VALUES (6, '/admin/user/profile', 'Profile', '用户信息', NULL, 'user/UserProfile', 3);
INSERT INTO `admin_menu` VALUES (7, '/admin/user/role', 'Role', '角色配置', NULL, 'user/Role', 3);
INSERT INTO `admin_menu` VALUES (8, '/admin/content/activity', 'ActivityManagement', '活动管理', NULL, 'content/ActivityManagement', 4);
INSERT INTO `admin_menu` VALUES (9, '/admin/content/notice', 'NoticeManagement', '公告管理', NULL, 'content/NoticeManagement', 4);
INSERT INTO `admin_menu` VALUES (10, '/admin/content/add/notice', 'CaseManagement', '添加公告', NULL, 'content/CaseManagement', 4);
INSERT INTO `admin_menu` VALUES (17, '/admin/vote/add/index', 'CreateActivity', '创建活动', NULL, 'vote/AddActivity', 1);
INSERT INTO `admin_menu` VALUES (18, '/admin/account/info', 'AccountInfo', '账户信息', NULL, 'account/UserInfo', 5);
INSERT INTO `admin_menu` VALUES (21, '/admin/vote/add/item', 'CreateItem', '选项设置', '', 'vote/VoteItem', 17);
INSERT INTO `admin_menu` VALUES (22, '/admin/vote/add/setting', 'VoteSetting', '活动设置', NULL, 'vote/VoteEdit', 17);
INSERT INTO `admin_menu` VALUES (23, '/admin/vote/add/index', 'addIndex', '活动创建', '', 'vote/Create', 17);
INSERT INTO `admin_menu` VALUES (24, '/admin/vote/list/result', 'VoteResult', '投票统计', NULL, 'vote/VoteResult', 17);

-- ----------------------------
-- Table structure for admin_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_permission`;
CREATE TABLE `admin_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `desc_` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `url` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_permission
-- ----------------------------
INSERT INTO `admin_permission` VALUES (1, 'users_management', '用户管理', '/api/admin/user');
INSERT INTO `admin_permission` VALUES (2, 'roles_management', '角色管理', '/api/admin/role');
INSERT INTO `admin_permission` VALUES (3, 'content_management', '内容管理', '/api/admin/content');

-- ----------------------------
-- Table structure for admin_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_role`;
CREATE TABLE `admin_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `name_zh` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role
-- ----------------------------
INSERT INTO `admin_role` VALUES (1, 'systemAdmin', '系统管理员', 1);
INSERT INTO `admin_role` VALUES (2, 'contentManager', '内容管理员', 1);
INSERT INTO `admin_role` VALUES (3, 'generalUser', '普通用户', 1);
INSERT INTO `admin_role` VALUES (10, 'visitor', '访客', 1);

-- ----------------------------
-- Table structure for admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NULL DEFAULT NULL,
  `mid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 280 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_menu
-- ----------------------------
INSERT INTO `admin_role_menu` VALUES (19, 4, 1);
INSERT INTO `admin_role_menu` VALUES (20, 4, 2);
INSERT INTO `admin_role_menu` VALUES (23, 9, 1);
INSERT INTO `admin_role_menu` VALUES (24, 9, 2);
INSERT INTO `admin_role_menu` VALUES (209, 3, 1);
INSERT INTO `admin_role_menu` VALUES (210, 3, 2);
INSERT INTO `admin_role_menu` VALUES (211, 3, 17);
INSERT INTO `admin_role_menu` VALUES (212, 3, 5);
INSERT INTO `admin_role_menu` VALUES (213, 3, 18);
INSERT INTO `admin_role_menu` VALUES (223, 2, 1);
INSERT INTO `admin_role_menu` VALUES (224, 2, 2);
INSERT INTO `admin_role_menu` VALUES (225, 2, 17);
INSERT INTO `admin_role_menu` VALUES (226, 2, 4);
INSERT INTO `admin_role_menu` VALUES (227, 2, 8);
INSERT INTO `admin_role_menu` VALUES (228, 2, 9);
INSERT INTO `admin_role_menu` VALUES (229, 2, 10);
INSERT INTO `admin_role_menu` VALUES (230, 2, 5);
INSERT INTO `admin_role_menu` VALUES (231, 2, 18);
INSERT INTO `admin_role_menu` VALUES (264, 1, 1);
INSERT INTO `admin_role_menu` VALUES (265, 1, 2);
INSERT INTO `admin_role_menu` VALUES (266, 1, 17);
INSERT INTO `admin_role_menu` VALUES (267, 1, 21);
INSERT INTO `admin_role_menu` VALUES (268, 1, 22);
INSERT INTO `admin_role_menu` VALUES (269, 1, 23);
INSERT INTO `admin_role_menu` VALUES (270, 1, 24);
INSERT INTO `admin_role_menu` VALUES (271, 1, 3);
INSERT INTO `admin_role_menu` VALUES (272, 1, 6);
INSERT INTO `admin_role_menu` VALUES (273, 1, 7);
INSERT INTO `admin_role_menu` VALUES (274, 1, 4);
INSERT INTO `admin_role_menu` VALUES (275, 1, 8);
INSERT INTO `admin_role_menu` VALUES (276, 1, 9);
INSERT INTO `admin_role_menu` VALUES (277, 1, 10);
INSERT INTO `admin_role_menu` VALUES (278, 1, 5);
INSERT INTO `admin_role_menu` VALUES (279, 1, 18);

-- ----------------------------
-- Table structure for admin_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `admin_role_permission`;
CREATE TABLE `admin_role_permission`  (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `rid` int(20) NULL DEFAULT NULL,
  `pid` int(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_role_permission_role_1`(`rid`) USING BTREE,
  INDEX `fk_role_permission_permission_1`(`pid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_role_permission
-- ----------------------------
INSERT INTO `admin_role_permission` VALUES (83, 5, 3);
INSERT INTO `admin_role_permission` VALUES (144, 2, 3);
INSERT INTO `admin_role_permission` VALUES (151, 1, 1);
INSERT INTO `admin_role_permission` VALUES (152, 1, 2);
INSERT INTO `admin_role_permission` VALUES (153, 1, 3);

-- ----------------------------
-- Table structure for admin_user_role
-- ----------------------------
DROP TABLE IF EXISTS `admin_user_role`;
CREATE TABLE `admin_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_operator_role_operator_1`(`uid`) USING BTREE,
  INDEX `fk_operator_role_role_1`(`rid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 110 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user_role
-- ----------------------------
INSERT INTO `admin_user_role` VALUES (40, 24, 2);
INSERT INTO `admin_user_role` VALUES (70, 4, 1);
INSERT INTO `admin_user_role` VALUES (71, 5, 3);
INSERT INTO `admin_user_role` VALUES (72, 7, 3);
INSERT INTO `admin_user_role` VALUES (73, 0, 3);
INSERT INTO `admin_user_role` VALUES (74, 0, 3);
INSERT INTO `admin_user_role` VALUES (75, 11, 3);
INSERT INTO `admin_user_role` VALUES (76, 10, 3);
INSERT INTO `admin_user_role` VALUES (77, 2, 2);
INSERT INTO `admin_user_role` VALUES (79, 8, 3);
INSERT INTO `admin_user_role` VALUES (80, 12, 3);
INSERT INTO `admin_user_role` VALUES (81, 13, 3);
INSERT INTO `admin_user_role` VALUES (82, 6, 3);
INSERT INTO `admin_user_role` VALUES (83, 3, 2);
INSERT INTO `admin_user_role` VALUES (84, 14, 3);
INSERT INTO `admin_user_role` VALUES (85, 9, 3);
INSERT INTO `admin_user_role` VALUES (87, 16, 3);
INSERT INTO `admin_user_role` VALUES (88, 15, 3);
INSERT INTO `admin_user_role` VALUES (95, 17, 3);
INSERT INTO `admin_user_role` VALUES (96, 18, 3);
INSERT INTO `admin_user_role` VALUES (109, 1, 1);

-- ----------------------------
-- Table structure for tb_activity
-- ----------------------------
DROP TABLE IF EXISTS `tb_activity`;
CREATE TABLE `tb_activity`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `author` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `state` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态：0表示删除，1表示正常，2表示案例',
  `type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `sign_in` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '0不需要登录，1表示需要登录',
  `verify_code` tinyint(1) NULL DEFAULT NULL COMMENT '0不需要验证码，1表示需要验证码',
  `start_time` datetime(0) NOT NULL COMMENT '开始时间',
  `end_time` datetime(0) NOT NULL COMMENT '结束时间',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_activity
-- ----------------------------
INSERT INTO `tb_activity` VALUES ('751445460039761920', 'admin', '第一个活动的标题', '第一个活动的内容', '1', NULL, '1', 0, '2020-09-04 14:15:32', '2020-09-04 14:15:32', '2020-09-04 14:15:59', '2020-09-04 14:15:59');
INSERT INTO `tb_activity` VALUES ('751447835634827264', 'admin', '第二个活动标题', '<p>啊发给发</p>', '1', NULL, '1', 0, '2020-09-25 00:00:00', '2020-09-09 00:00:00', '2020-09-04 14:25:25', '2020-09-04 14:25:25');
INSERT INTO `tb_activity` VALUES ('751449728763297792', 'admin', '第二个活动标题', '<p>啊发给发</p>', '1', NULL, '1', 0, '2020-09-10 00:00:00', '2020-09-09 00:00:00', '2020-09-04 14:32:57', '2020-09-04 14:32:57');
INSERT INTO `tb_activity` VALUES ('751570407416397824', 'admin', 'teaagfaf', '<p>asgsgdsdags</p>', '1', NULL, '1', 0, '2020-09-04 00:00:00', '2020-09-25 00:00:00', '2020-09-04 22:32:29', '2020-09-04 22:32:29');
INSERT INTO `tb_activity` VALUES ('751570500940988416', 'admin', 'teaagfaf', '<p>asgsgdsdags</p>', '1', NULL, '1', 0, '2020-09-04 00:00:00', '2020-09-25 00:00:00', '2020-09-04 22:32:51', '2020-09-04 22:32:51');
INSERT INTO `tb_activity` VALUES ('751570907125776384', 'admin', '单选，每天都可以投', '<p>asgsgdsdags</p>', '1', NULL, '1', 0, '2020-09-04 00:00:00', '2020-09-25 00:00:00', '2020-09-04 22:34:28', '2020-09-04 22:34:28');
INSERT INTO `tb_activity` VALUES ('751582630939459584', 'admin', '单选，每天都能投', '<ul><li> 这里是活动的描述</li></ul>', '1', '{\"voteType\":\"single\",\"cycleType\":\"true\",\"totalVotes\":\"3\",\"oneVotes\":\"2\"}', '1', 0, '2020-09-04 00:00:00', '2020-09-25 00:00:00', '2020-09-04 23:21:03', '2020-09-20 11:07:59');
INSERT INTO `tb_activity` VALUES ('751588837343363072', 'admin', 'afgagsagdsag', '<p>sdgshgsah</p>', '1', NULL, '1', 0, '2020-09-04 23:45:38', '2020-09-26 00:00:00', '2020-09-04 23:45:43', '2020-09-04 23:45:43');
INSERT INTO `tb_activity` VALUES ('751734909130768384', 'admin', 'gagsagsdga', '<p>dgsagsadgsh</p>', '1', NULL, '1', 0, '2020-09-05 00:00:00', '2020-09-30 00:00:00', '2020-09-05 09:26:09', '2020-09-05 09:30:50');
INSERT INTO `tb_activity` VALUES ('751739678947803136', 'admin', 'dgsdfgsdgasdg', '<p>gsgdsdgsg</p>', '1', NULL, '1', 0, '2020-09-05 09:45:01', '2020-09-26 00:00:00', '2020-09-05 09:45:06', '2020-09-05 09:45:06');
INSERT INTO `tb_activity` VALUES ('751741601033748480', 'admin', '归属感萨汗国', '<p>谁敢说噶山豆根</p>', '1', '{\"voteType\":\"multiple\",\"cycleType\":\"true\",\"least\":\"1\",\"most\":\"2\"}', '1', 1, '2020-09-05 09:52:34', '2020-09-12 00:00:00', '2020-09-05 09:52:44', '2020-09-05 10:43:15');
INSERT INTO `tb_activity` VALUES ('751767284007043072', 'admin', '啊事故发生公司的', '<p>哥帅哥帅哥帅哥</p>', '1', '{\"voteType\":\"multiple\",\"cycleType\":\"false\",\"least\":\"2\",\"most\":\"5\"}', '1', 0, '2020-09-05 11:34:42', '2020-09-26 00:00:00', '2020-09-05 11:34:48', '2020-09-05 11:35:12');
INSERT INTO `tb_activity` VALUES ('751767951169814528', 'admin', '而阿根廷是否合格', '<p>俺是个帅哥帅哥</p>', '1', '{\"voteType\":\"multiple\",\"cycleType\":\"false\",\"least\":\"1\",\"most\":\"2\"}', '1', 0, '2020-09-04 00:00:00', '2020-09-30 00:00:00', '2020-09-05 11:37:27', '2020-09-05 11:37:35');
INSERT INTO `tb_activity` VALUES ('751798043702984704', 'admin', '未开始的活动', '<p></p>', '0', NULL, '1', 0, '2020-09-06 00:00:00', '2020-09-08 00:00:00', '2020-09-05 13:37:01', '2020-09-05 13:37:01');
INSERT INTO `tb_activity` VALUES ('751798200133746688', 'admin', '进行中的活动', '<p></p>', '0', NULL, '1', 0, '2020-09-05 13:37:32', '2020-09-12 00:00:00', '2020-09-05 13:37:39', '2020-09-05 13:37:39');
INSERT INTO `tb_activity` VALUES ('752165574024364032', 'admin', '多选,，只能投一次，需要验证码', '<p>hshsdghsadg</p>', '2', '{\"voteType\":\"multiple\",\"cycleType\":\"false\",\"least\":\"2\",\"most\":\"4\"}', '1', 1, '2020-09-06 13:57:22', '2020-09-24 00:00:00', '2020-09-06 13:57:27', '2020-09-10 10:21:56');
INSERT INTO `tb_activity` VALUES ('752256769606025216', 'admin', ',/jhklhl', '<p></p>', '1', '{\"voteType\":\"single\",\"cycleType\":\"false\",\"oneVotes\":\"1\",\"totalVotes\":\"3\"}', '1', 0, '2020-09-06 19:59:45', '2020-09-08 00:00:00', '2020-09-06 19:59:50', '2020-09-11 10:52:53');
INSERT INTO `tb_activity` VALUES ('752256781182304256', 'admin', '单选，不需要验证码', '<p>sgsgsg</p>', '1', '{\"voteType\":\"single\",\"cycleType\":\"false\",\"totalVotes\":\"3\",\"oneVotes\":\"2\"}', '1', 0, '2020-09-10 10:04:15', '2020-09-24 00:00:00', '2020-09-06 19:59:53', '2020-09-10 10:04:46');
INSERT INTO `tb_activity` VALUES ('752573232778838016', 'admin', '噶首都华盛顿峰会aagag', '<p>返回给撒噶时光施工队施工施工</p>', NULL, '{\"voteType\":\"single\",\"cycleType\":\"true\",\"totalVotes\":\"3\",\"oneVotes\":\"2\"}', '1', 0, '2020-09-08 00:00:00', '2020-09-24 00:00:00', '2020-09-07 16:57:21', '2020-09-20 13:34:35');
INSERT INTO `tb_activity` VALUES ('753009229530398720', 'zhangsan', '的西方绘画书法回复', '<p>豆腐花大会的恢复的话阿达的</p>', '1', '{\"voteType\":\"single\",\"cycleType\":\"true\",\"totalVotes\":\"2\",\"oneVotes\":\"1\"}', '1', 0, '2020-09-18 00:00:00', '2020-09-29 00:00:00', '2020-09-08 21:49:51', '2020-09-11 10:52:45');
INSERT INTO `tb_activity` VALUES ('753014050056568832', 'zhangsan', '公司的风格样式', '<p>是个还是个帅哥</p>', '0', '{\"voteType\":\"single\",\"cycleType\":\"true\",\"totalVotes\":\"3\",\"oneVotes\":\"2\"}', '1', 0, '2020-09-08 22:08:53', '2020-09-15 00:00:00', '2020-09-08 22:09:00', '2020-09-10 22:23:07');
INSERT INTO `tb_activity` VALUES ('753930040688771072', 'admin', '单选，需要验证码，只能投一次', '<ul><li>这里是活动内容的描述</li></ul><p><br></p>', '2', '{\"voteType\":\"single\",\"cycleType\":\"false\",\"totalVotes\":\"3\",\"oneVotes\":\"2\"}', '1', 1, '2020-08-31 00:00:00', '2020-11-30 00:00:00', '2020-09-11 10:48:49', '2020-09-11 10:52:18');
INSERT INTO `tb_activity` VALUES ('754740691480870912', 'admin', '多选，每天都可以投', '<ul><li>这里是活动内容的描述</li></ul>', '1', '{}', '1', 0, '2020-09-01 00:00:00', '2020-10-31 00:00:00', '2020-09-13 16:30:03', '2020-09-13 16:30:03');
INSERT INTO `tb_activity` VALUES ('754742434017050624', 'admin', '多选，每天都可以投', '<ul><li>这里是活动详情的描述</li></ul>', '2', '{\"voteType\":\"multiple\",\"cycleType\":\"true\",\"least\":\"2\",\"most\":\"3\"}', '1', 0, '2020-09-01 00:00:00', '2020-10-31 00:00:00', '2020-09-13 16:36:59', '2020-09-13 16:39:19');
INSERT INTO `tb_activity` VALUES ('755019094327033856', 'admin', 'GADGAF', '<p>SDGSGS</p>', '1', '{}', '1', 0, '2020-09-14 10:56:14', '2020-10-29 00:00:00', '2020-09-14 10:56:20', '2020-09-14 10:56:20');
INSERT INTO `tb_activity` VALUES ('757198227018612736', 'admin', '单选，每天都可以投', '<ul><li>这里是活动描述</li></ul>', '1', '{\"voteType\":\"single\",\"cycleType\":\"true\",\"totalVotes\":\"3\",\"oneVotes\":\"2\"}', '1', 0, '2020-09-02 00:00:00', '2020-09-30 00:00:00', '2020-09-20 11:15:25', '2020-09-28 16:09:20');
INSERT INTO `tb_activity` VALUES ('757233336409128960', 'admin', 'test', '<p>sgdsg</p>', '2', '{\"voteType\":\"multiple\",\"least\":\"2\",\"most\":\"3\"}', '1', 0, '2020-09-20 13:34:53', '2020-09-30 00:00:00', '2020-09-20 13:34:56', '2021-03-08 13:30:34');
INSERT INTO `tb_activity` VALUES ('778256915976159232', 'test', 'afasf', '<p>afsaf</p>', '1', '{}', '1', 0, '2020-11-13 00:00:00', '2020-11-25 00:00:00', '2020-11-17 13:55:08', '2020-12-14 14:51:21');
INSERT INTO `tb_activity` VALUES ('818476364364513280', 'admin', '测试投票标题11', '<p>-法撒法案说法撒</p>', NULL, '{\"voteType\":\"single\",\"cycleType\":\"false\",\"totalVotes\":\"1\",\"oneVotes\":\"1\"}', '1', 0, '2020-08-27 13:32:45', '2021-03-26 00:00:00', '2021-03-08 13:32:52', '2021-03-22 23:21:35');

-- ----------------------------
-- Table structure for tb_candidate
-- ----------------------------
DROP TABLE IF EXISTS `tb_candidate`;
CREATE TABLE `tb_candidate`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `aid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应活动的id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `num` int(11) NULL DEFAULT NULL,
  `item_desc` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `cover_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面链接',
  `video_url` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频链接',
  `vote_count` int(11) NULL DEFAULT NULL,
  `state` tinyint(1) NOT NULL COMMENT '状态：0表示删除，1表示正常',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_candidate
-- ----------------------------
INSERT INTO `tb_candidate` VALUES ('4087770440', '1', '标题一', NULL, ' deaf', NULL, NULL, NULL, 1, '2020-08-30 11:51:49', '2020-08-30 11:51:52');
INSERT INTO `tb_candidate` VALUES ('435456456', '1', '撒大噶', NULL, '安抚阿飞噶', NULL, NULL, NULL, 0, '2020-08-30 11:53:25', '2020-08-30 11:53:28');
INSERT INTO `tb_candidate` VALUES ('513701605', '1', '标题er', NULL, '是根深蒂固', 'da\'ga', NULL, NULL, 1, '2020-08-30 11:53:08', '2020-08-30 11:53:10');
INSERT INTO `tb_candidate` VALUES ('751735335649542144', '751734909130768384', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-05 09:27:51', '2020-09-05 09:27:51');
INSERT INTO `tb_candidate` VALUES ('751735336408711168', '751734909130768384', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-05 09:27:51', '2020-09-05 09:27:51');
INSERT INTO `tb_candidate` VALUES ('751735338837213184', '751734909130768384', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-05 09:27:51', '2020-09-05 09:27:51');
INSERT INTO `tb_candidate` VALUES ('751735350283468800', '751734909130768384', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-05 09:27:54', '2020-09-05 09:27:54');
INSERT INTO `tb_candidate` VALUES ('751735352347066368', '751734909130768384', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-05 09:27:55', '2020-09-05 09:27:55');
INSERT INTO `tb_candidate` VALUES ('751739697792811008', '751739678947803136', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-05 09:45:11', '2020-09-05 09:45:11');
INSERT INTO `tb_candidate` VALUES ('751739698279350272', '751739678947803136', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-05 09:45:11', '2020-09-05 09:45:11');
INSERT INTO `tb_candidate` VALUES ('751739698279350273', '751739678947803136', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-05 09:45:11', '2020-09-05 09:45:11');
INSERT INTO `tb_candidate` VALUES ('751739698849775616', '751739678947803136', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-05 09:45:11', '2020-09-05 09:45:11');
INSERT INTO `tb_candidate` VALUES ('751739703991992320', '751739678947803136', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-05 09:45:12', '2020-09-05 09:45:12');
INSERT INTO `tb_candidate` VALUES ('751741677344915456', '751741601033748480', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-05 09:53:03', '2020-09-05 09:53:03');
INSERT INTO `tb_candidate` VALUES ('751741682151587840', '751741601033748480', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-05 09:53:04', '2020-09-05 09:53:04');
INSERT INTO `tb_candidate` VALUES ('751741684508786688', '751741601033748480', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-05 09:53:04', '2020-09-05 09:53:04');
INSERT INTO `tb_candidate` VALUES ('751741686845014016', '751741601033748480', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-05 09:53:05', '2020-09-05 09:53:05');
INSERT INTO `tb_candidate` VALUES ('751741689445482496', '751741601033748480', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-05 09:53:05', '2020-09-05 09:53:05');
INSERT INTO `tb_candidate` VALUES ('751741694721916928', '751741601033748480', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-05 09:53:07', '2020-09-05 09:53:07');
INSERT INTO `tb_candidate` VALUES ('751767294127898624', '751767284007043072', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-05 11:34:50', '2020-09-05 11:34:50');
INSERT INTO `tb_candidate` VALUES ('751767295839174656', '751767284007043072', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-05 11:34:50', '2020-09-05 11:34:50');
INSERT INTO `tb_candidate` VALUES ('751767297009385472', '751767284007043072', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-05 11:34:51', '2020-09-05 11:34:51');
INSERT INTO `tb_candidate` VALUES ('751767297181351936', '751767284007043072', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-05 11:34:51', '2020-09-05 11:34:51');
INSERT INTO `tb_candidate` VALUES ('751767298020212736', '751767284007043072', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-05 11:34:51', '2020-09-05 11:34:51');
INSERT INTO `tb_candidate` VALUES ('751767298481586176', '751767284007043072', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-05 11:34:51', '2020-09-05 11:34:51');
INSERT INTO `tb_candidate` VALUES ('751767962926448640', '751767951169814528', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-05 11:37:30', '2020-09-05 11:37:30');
INSERT INTO `tb_candidate` VALUES ('751767963824029696', '751767951169814528', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-05 11:37:30', '2020-09-05 11:37:30');
INSERT INTO `tb_candidate` VALUES ('751767964197322752', '751767951169814528', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-05 11:37:30', '2020-09-05 11:37:30');
INSERT INTO `tb_candidate` VALUES ('751767964251848704', '751767951169814528', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-05 11:37:30', '2020-09-05 11:37:30');
INSERT INTO `tb_candidate` VALUES ('751886765337346048', '751767951169814528', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-05 19:29:34', '2020-09-05 19:29:34');
INSERT INTO `tb_candidate` VALUES ('751886765664501760', '751767951169814528', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-05 19:29:34', '2020-09-05 19:29:34');
INSERT INTO `tb_candidate` VALUES ('751886766482391040', '751767951169814528', '新增的标题', 7, NULL, '', NULL, 0, 1, '2020-09-05 19:29:35', '2020-09-05 19:29:35');
INSERT INTO `tb_candidate` VALUES ('751886766520139776', '751767951169814528', '新增的标题', 8, NULL, '', NULL, 0, 1, '2020-09-05 19:29:35', '2020-09-05 19:29:35');
INSERT INTO `tb_candidate` VALUES ('751886767715516416', '751767951169814528', '新增的标题', 9, NULL, '', NULL, 0, 1, '2020-09-05 19:29:35', '2020-09-05 19:29:35');
INSERT INTO `tb_candidate` VALUES ('752167023517106176', '752165574024364032', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-06 14:03:13', '2020-09-06 14:03:13');
INSERT INTO `tb_candidate` VALUES ('752167026448924672', '752165574024364032', '李四', 2, NULL, '', NULL, 1, 1, '2020-09-06 14:03:14', '2020-09-11 10:38:34');
INSERT INTO `tb_candidate` VALUES ('752167026906103808', '752165574024364032', '王五', 3, NULL, '', NULL, 2, 1, '2020-09-06 14:03:14', '2020-09-11 10:38:34');
INSERT INTO `tb_candidate` VALUES ('752167028785152000', '752165574024364032', '新增的标题', 4, NULL, '', NULL, 2, 1, '2020-09-06 14:03:14', '2020-09-11 10:38:35');
INSERT INTO `tb_candidate` VALUES ('752167029212971008', '752165574024364032', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-06 14:03:14', '2020-09-06 14:03:14');
INSERT INTO `tb_candidate` VALUES ('752167031700193280', '752165574024364032', '张三', 2, NULL, '', NULL, 0, 0, '2020-09-06 14:03:15', '2020-09-06 16:03:35');
INSERT INTO `tb_candidate` VALUES ('752167863657168896', '752163101889003520', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-06 14:06:33', '2020-09-06 14:06:33');
INSERT INTO `tb_candidate` VALUES ('752167864374394880', '752163101889003520', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-06 14:06:33', '2020-09-06 14:06:33');
INSERT INTO `tb_candidate` VALUES ('752167865024512000', '752163101889003520', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-06 14:06:34', '2020-09-06 14:06:34');
INSERT INTO `tb_candidate` VALUES ('752167865964036096', '752163101889003520', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-06 14:06:34', '2020-09-06 14:06:34');
INSERT INTO `tb_candidate` VALUES ('752167866261831680', '752163101889003520', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-06 14:06:34', '2020-09-06 14:06:34');
INSERT INTO `tb_candidate` VALUES ('752167867234910208', '752163101889003520', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-06 14:06:34', '2020-09-06 14:06:34');
INSERT INTO `tb_candidate` VALUES ('752167883626250240', '752165494269673472', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-06 14:06:38', '2020-09-06 14:06:38');
INSERT INTO `tb_candidate` VALUES ('752167883974377472', '752165494269673472', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-06 14:06:38', '2020-09-06 14:06:38');
INSERT INTO `tb_candidate` VALUES ('752167884490276864', '752165494269673472', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-06 14:06:38', '2020-09-06 14:06:38');
INSERT INTO `tb_candidate` VALUES ('752167885320749056', '752165494269673472', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-06 14:06:38', '2020-09-06 14:06:38');
INSERT INTO `tb_candidate` VALUES ('752167885811482624', '752165494269673472', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-06 14:06:39', '2020-09-06 14:06:39');
INSERT INTO `tb_candidate` VALUES ('752167885975060480', '752165494269673472', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-06 14:06:39', '2020-09-06 14:06:39');
INSERT INTO `tb_candidate` VALUES ('752211387379351552', '752211378516787200', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-06 16:59:30', '2020-09-06 16:59:30');
INSERT INTO `tb_candidate` VALUES ('752211387974942720', '752211378516787200', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-06 16:59:30', '2020-09-06 16:59:30');
INSERT INTO `tb_candidate` VALUES ('752211389040295936', '752211378516787200', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-06 16:59:31', '2020-09-06 16:59:31');
INSERT INTO `tb_candidate` VALUES ('752211389635887104', '752211378516787200', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-06 16:59:31', '2020-09-06 16:59:31');
INSERT INTO `tb_candidate` VALUES ('752211390772543488', '752211378516787200', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-06 16:59:31', '2020-09-06 16:59:31');
INSERT INTO `tb_candidate` VALUES ('752211391024201728', '752211378516787200', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-06 16:59:31', '2020-09-06 16:59:31');
INSERT INTO `tb_candidate` VALUES ('752211391812730880', '752211378516787200', '新增的标题', 7, NULL, '', NULL, 0, 1, '2020-09-06 16:59:31', '2020-09-06 16:59:31');
INSERT INTO `tb_candidate` VALUES ('752211391892422656', '752211378516787200', '新增的标题', 8, NULL, '', NULL, 0, 1, '2020-09-06 16:59:31', '2020-09-06 16:59:31');
INSERT INTO `tb_candidate` VALUES ('752253333833515008', '752211378516787200', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-06 19:46:11', '2020-09-06 19:46:11');
INSERT INTO `tb_candidate` VALUES ('752260142547861504', '752256781182304256', '新增的标题', 1, NULL, '', NULL, 25, 1, '2020-09-06 20:13:14', '2020-09-06 20:13:14');
INSERT INTO `tb_candidate` VALUES ('752260143223144448', '752256781182304256', '新增的标题', 2, NULL, '', NULL, 53, 1, '2020-09-06 20:13:14', '2020-09-10 10:16:16');
INSERT INTO `tb_candidate` VALUES ('752260144103948288', '752256781182304256', '新增的标题', 3, '<p>我是张三，我为自己代言</p>', 'http://localhost:8443/api/file/1phdtl.png', NULL, 12, 1, '2020-09-06 20:13:15', '2020-09-07 18:55:01');
INSERT INTO `tb_candidate` VALUES ('752260144779231232', '752256781182304256', '新增的标题', 4, NULL, '', NULL, 23, 1, '2020-09-06 20:13:15', '2020-09-10 10:15:12');
INSERT INTO `tb_candidate` VALUES ('752260145660035072', '752256781182304256', '新增的标题', 5, NULL, '', NULL, 18, 1, '2020-09-06 20:13:15', '2020-09-06 20:13:15');
INSERT INTO `tb_candidate` VALUES ('752605888035946496', '752573232778838016', '新增的标题', 1, NULL, '', NULL, 5, 1, '2020-09-07 19:07:06', '2020-09-11 00:11:18');
INSERT INTO `tb_candidate` VALUES ('752605889801748480', '752573232778838016', 'zhangsan', 7, '<p>我是张三<img src=\"http://localhost:8443/api/file/oequ12.png\"></p>', 'http://localhost:8443/api/file/4y0lvp.png', NULL, 1, 1, '2020-09-07 19:07:07', '2020-09-11 00:11:18');
INSERT INTO `tb_candidate` VALUES ('752605890481225728', '752573232778838016', '新增的标题', 3, '<p>gsgsdgsgsdg</p>', '', NULL, 6, 1, '2020-09-07 19:07:07', '2020-09-10 14:55:45');
INSERT INTO `tb_candidate` VALUES ('752605890686746624', '752573232778838016', '新增的标题', 4, NULL, '', NULL, 2, 1, '2020-09-07 19:07:07', '2020-09-10 14:55:45');
INSERT INTO `tb_candidate` VALUES ('752605890934210560', '752573232778838016', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-07 19:07:07', '2020-09-07 19:07:07');
INSERT INTO `tb_candidate` VALUES ('752823624787820544', '752573232778838016', '新增的标题', 6, NULL, '', NULL, 1, 1, '2020-09-08 09:32:19', '2020-09-08 15:57:30');
INSERT INTO `tb_candidate` VALUES ('752823644702375936', '752573232778838016', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-08 09:32:24', '2020-09-10 09:44:57');
INSERT INTO `tb_candidate` VALUES ('753009235712802816', '753009229530398720', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-08 21:49:52', '2020-09-08 21:49:52');
INSERT INTO `tb_candidate` VALUES ('753009236367114240', '753009229530398720', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-08 21:49:52', '2020-09-08 21:49:52');
INSERT INTO `tb_candidate` VALUES ('753009237231140864', '753009229530398720', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-08 21:49:52', '2020-09-08 21:49:52');
INSERT INTO `tb_candidate` VALUES ('753009237826732032', '753009229530398720', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-08 21:49:53', '2020-09-08 21:49:53');
INSERT INTO `tb_candidate` VALUES ('753009238334242816', '753009229530398720', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-08 21:49:53', '2020-09-08 21:49:53');
INSERT INTO `tb_candidate` VALUES ('753014060441665536', '753014050056568832', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-08 22:09:02', '2020-09-08 22:09:02');
INSERT INTO `tb_candidate` VALUES ('753014060705906688', '753014050056568832', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-08 22:09:02', '2020-09-08 22:09:02');
INSERT INTO `tb_candidate` VALUES ('753014061523795968', '753014050056568832', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-08 22:09:03', '2020-09-08 22:09:03');
INSERT INTO `tb_candidate` VALUES ('753014062538817536', '753014050056568832', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-08 22:09:03', '2020-09-08 22:09:03');
INSERT INTO `tb_candidate` VALUES ('753014063709028352', '753014050056568832', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-08 22:09:03', '2020-09-08 22:09:03');
INSERT INTO `tb_candidate` VALUES ('753033812107067392', '752573232778838016', '发发', 6, '<p>dhdfyhdhdh</p>', '', NULL, 0, 1, '2020-09-08 23:27:31', '2020-09-10 09:57:45');
INSERT INTO `tb_candidate` VALUES ('753925901497925632', '752573232778838016', '新增的标题', 7, NULL, '', NULL, 0, 1, '2020-09-11 10:32:22', '2020-09-11 10:32:27');
INSERT INTO `tb_candidate` VALUES ('753925926332399616', '752573232778838016', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-11 10:32:28', '2020-09-11 10:32:28');
INSERT INTO `tb_candidate` VALUES ('753925940114882560', '752573232778838016', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-11 10:32:31', '2020-09-11 10:32:31');
INSERT INTO `tb_candidate` VALUES ('753925948054700032', '752573232778838016', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-11 10:32:33', '2020-09-11 10:32:33');
INSERT INTO `tb_candidate` VALUES ('753930049404534784', '753930040688771072', '李四', 2, NULL, '', NULL, 1, 1, '2020-09-11 10:48:51', '2020-09-11 10:54:39');
INSERT INTO `tb_candidate` VALUES ('753930049849131008', '753930040688771072', '阿飞噶', 3, NULL, '', NULL, 2, 1, '2020-09-11 10:48:51', '2020-09-11 20:05:56');
INSERT INTO `tb_candidate` VALUES ('753930050750906368', '753930040688771072', '张三', 1, '<ul><li>我是张三，喜欢健身游泳</li><li>欢迎大家多多支持我</li></ul><p><br></p>', '', NULL, 4, 1, '2020-09-11 10:48:51', '2020-09-13 16:22:24');
INSERT INTO `tb_candidate` VALUES ('753930052017586176', '753930040688771072', '赵六', 4, NULL, '', NULL, 1, 1, '2020-09-11 10:48:52', '2020-09-13 16:22:17');
INSERT INTO `tb_candidate` VALUES ('753930054110543872', '753930040688771072', '王五', 5, NULL, '', NULL, 1, 1, '2020-09-11 10:48:52', '2020-09-13 16:22:40');
INSERT INTO `tb_candidate` VALUES ('753930067603619840', '753930040688771072', '嘎嘎嘎', 6, NULL, '', NULL, 0, 1, '2020-09-11 10:48:55', '2020-09-11 10:50:00');
INSERT INTO `tb_candidate` VALUES ('754740695708729344', '754740691480870912', '王五', 1, '<p>我是王五，请大家多多支持我</p>', '', NULL, 0, 1, '2020-09-13 16:30:04', '2020-09-13 16:31:06');
INSERT INTO `tb_candidate` VALUES ('754740696241405952', '754740691480870912', '赵六', 2, '<p>我是赵六，请大家多多支持我</p>', '', NULL, 0, 1, '2020-09-13 16:30:04', '2020-09-13 16:31:12');
INSERT INTO `tb_candidate` VALUES ('754740696581144576', '754740691480870912', '阿发', 2, NULL, '', NULL, 0, 1, '2020-09-13 16:30:04', '2020-09-13 16:30:32');
INSERT INTO `tb_candidate` VALUES ('754740697269010432', '754740691480870912', '张三', 4, '<p>我是张三，请大家多多支持我</p>', '', NULL, 0, 1, '2020-09-13 16:30:05', '2020-09-13 16:30:57');
INSERT INTO `tb_candidate` VALUES ('754740697692635136', '754740691480870912', '李四', 5, '<p>我是李四，请大家多多支持我</p>', '', NULL, 0, 1, '2020-09-13 16:30:05', '2020-09-13 16:31:02');
INSERT INTO `tb_candidate` VALUES ('754742438270074880', '754742434017050624', '张三', 1, '<p>我是张三，请大家多多支持我</p>', 'http://oahouhs.xyz:8443/api/file/rj9wrl.jpg', NULL, 6, 1, '2020-09-13 16:37:00', '2020-11-17 14:08:16');
INSERT INTO `tb_candidate` VALUES ('754742438857277440', '754742434017050624', '李四', 2, '<p>我是李四，请大家多多支持我</p>', '', NULL, 4, 1, '2020-09-13 16:37:00', '2020-10-08 20:48:37');
INSERT INTO `tb_candidate` VALUES ('754742441755541504', '754742434017050624', '赵六', 3, '<p>我是赵六，请大家多多支持我</p>', '', NULL, 5, 1, '2020-09-13 16:37:01', '2020-11-17 14:08:16');
INSERT INTO `tb_candidate` VALUES ('754742444054020096', '754742434017050624', '王五', 4, '<p>我是王五，请大家多多支持我</p>', '', NULL, 5, 1, '2020-09-13 16:37:01', '2020-11-17 14:08:16');
INSERT INTO `tb_candidate` VALUES ('754742446289584128', '754742434017050624', '阿发', 5, NULL, '', NULL, 2, 1, '2020-09-13 16:37:02', '2020-09-20 11:07:25');
INSERT INTO `tb_candidate` VALUES ('755019108021436416', '755019094327033856', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-14 10:56:23', '2020-09-14 10:56:23');
INSERT INTO `tb_candidate` VALUES ('755019108919017472', '755019094327033856', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-14 10:56:23', '2020-09-14 10:56:23');
INSERT INTO `tb_candidate` VALUES ('755019110064062464', '755019094327033856', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-09-14 10:56:23', '2020-09-14 10:56:23');
INSERT INTO `tb_candidate` VALUES ('755019111951499264', '755019094327033856', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-14 10:56:24', '2020-09-14 10:56:24');
INSERT INTO `tb_candidate` VALUES ('757195279240790016', '751582630939459584', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-09-20 11:03:43', '2020-09-20 11:03:43');
INSERT INTO `tb_candidate` VALUES ('757195279643443200', '751582630939459584', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-20 11:03:43', '2020-09-20 11:03:43');
INSERT INTO `tb_candidate` VALUES ('757195280096428032', '751582630939459584', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-09-20 11:03:43', '2020-09-20 11:03:43');
INSERT INTO `tb_candidate` VALUES ('757195280679436288', '751582630939459584', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-09-20 11:03:43', '2020-09-20 11:03:43');
INSERT INTO `tb_candidate` VALUES ('757195281241473024', '751582630939459584', '新增的标题', 5, NULL, '', NULL, 0, 1, '2020-09-20 11:03:43', '2020-09-20 11:03:43');
INSERT INTO `tb_candidate` VALUES ('757198231158390784', '757198227018612736', '新增的标题', 1, NULL, '', NULL, 1, 1, '2020-09-20 11:15:26', '2020-09-26 20:27:21');
INSERT INTO `tb_candidate` VALUES ('757198231682678784', '757198227018612736', '新增的标题', 2, NULL, '', NULL, 2, 1, '2020-09-20 11:15:26', '2020-09-26 20:27:20');
INSERT INTO `tb_candidate` VALUES ('757198232194383872', '757198227018612736', '张三', 3, '<p>我是张三，请大家多多支持我</p>', 'http://oahouhs.xyz:8443/api/file/rj9wrl.jpg', NULL, 3, 1, '2020-09-20 11:15:27', '2020-09-26 20:27:19');
INSERT INTO `tb_candidate` VALUES ('757198232773197824', '757198227018612736', '李四', 4, '<p>我是李四，请大家多多支持我</p>', '', NULL, 0, 1, '2020-09-20 11:15:27', '2020-09-20 11:15:36');
INSERT INTO `tb_candidate` VALUES ('757198233310068736', '757198227018612736', '王五', 5, '<p>我是王五，请大家多多支持我</p>', '', NULL, 0, 1, '2020-09-20 11:15:27', '2020-09-20 11:15:38');
INSERT INTO `tb_candidate` VALUES ('760170810831798272', '751582630939459584', '新增的标题', 6, NULL, '', NULL, 0, 1, '2020-09-28 16:07:25', '2020-09-28 16:07:25');
INSERT INTO `tb_candidate` VALUES ('778256929024638976', '778256915976159232', '新增的标题', 1, NULL, '', NULL, 0, 1, '2020-11-17 13:55:11', '2020-11-17 13:55:11');
INSERT INTO `tb_candidate` VALUES ('778256931893542912', '778256915976159232', '新增的标题', 2, NULL, '', NULL, 0, 1, '2020-11-17 13:55:12', '2020-11-17 13:55:12');
INSERT INTO `tb_candidate` VALUES ('778256935056048128', '778256915976159232', '新增的标题', 3, NULL, '', NULL, 0, 1, '2020-11-17 13:55:13', '2020-11-17 13:55:13');
INSERT INTO `tb_candidate` VALUES ('778256938411491328', '778256915976159232', '新增的标题', 4, NULL, '', NULL, 0, 1, '2020-11-17 13:55:13', '2020-11-17 13:55:13');
INSERT INTO `tb_candidate` VALUES ('819132028329918464', '818476364364513280', '新增的标题', 1, NULL, '', NULL, 0, 1, '2021-03-10 08:58:14', '2021-03-10 08:58:14');
INSERT INTO `tb_candidate` VALUES ('819132036198432768', '818476364364513280', '新增的标题', 3, NULL, '', NULL, 0, 1, '2021-03-10 08:58:16', '2021-03-10 08:58:16');
INSERT INTO `tb_candidate` VALUES ('819132139646746624', '818476364364513280', '新增的标题', 3, NULL, '', NULL, 0, 1, '2021-03-10 08:58:41', '2021-03-10 08:58:41');
INSERT INTO `tb_candidate` VALUES ('819132146688983040', '818476364364513280', '新增的标题', 4, NULL, '', NULL, 0, 1, '2021-03-10 08:58:43', '2021-03-10 08:58:43');
INSERT INTO `tb_candidate` VALUES ('819132150254141440', '818476364364513280', '新增的标题', 5, NULL, '', NULL, 0, 1, '2021-03-10 08:58:43', '2021-03-10 08:58:43');

-- ----------------------------
-- Table structure for tb_notice
-- ----------------------------
DROP TABLE IF EXISTS `tb_notice`;
CREATE TABLE `tb_notice`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `uid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `state` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态：0表示删除，1表示正常',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_notice
-- ----------------------------
INSERT INTO `tb_notice` VALUES ('111', '2', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('112', '2', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('113', '3', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('114', '4', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('115', '5', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('116', '6', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('117', '7', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('118', '8', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('119', '9', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('120', '10', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('121', '11', '111', '111', '1', '2020-12-23 00:00:00', '2020-12-23 00:00:00');
INSERT INTO `tb_notice` VALUES ('753188497220698112', '1', '这是第一条公告的标题', '<p>这是第一条公告的内容</p>', '1', '2020-09-09 09:42:11', '2020-09-09 09:42:11');
INSERT INTO `tb_notice` VALUES ('753638821618253824', '1', '这是我的第二条公告', '<ul><li>这是第二条公告的内同</li><li>这案说法爱国诗歌</li><li><img src=\"http://localhost:8443/api/file/x5ki4j.png\"></li></ul>', '1', '2020-09-10 15:31:37', '2020-09-10 15:31:37');
INSERT INTO `tb_notice` VALUES ('754139202160951296', '1', 'hdjdjjd', '<p></p>', '1', '2020-09-12 00:39:57', '2020-09-12 00:39:57');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `avatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '头像地址',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱地址',
  `state` tinyint(1) NOT NULL COMMENT '状态：0表示删除，1表示正常',
  `reg_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '注册ip',
  `login_ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '登录Ip',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL COMMENT '更新时间',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, 'admin', '30ccc5b2011ce1e5074d70d7a186dc7e', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'admin@163.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-08-26 16:44:39', '2020-08-26 16:44:39', 'm33DRgsqEtALuZi2Cxz8fQ==');
INSERT INTO `tb_user` VALUES (2, 'zhangsan', 'f611729d572ba986a987c8afc0e192c2', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'test@163.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-01 16:49:57', '2020-09-01 16:49:57', 'ROEwo3MqYTBD2v9wTR0aqA==');
INSERT INTO `tb_user` VALUES (3, 'test', '7811a2d5b711f65ebec45e9b13107807', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'test@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-01 18:05:20', '2020-09-01 18:05:20', 'wqeTOTniBg6hcYGzRmSGTQ==');
INSERT INTO `tb_user` VALUES (4, 'lisi', '9236d58a7e8c79a554819fd46a7bc75f', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'lisi@163.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-02 11:43:56', '2020-09-02 11:43:56', 'NhZYR2fyOomUUHT+0ri61w==');
INSERT INTO `tb_user` VALUES (5, 'wangwu', '87d382b4e8a85bad58d7c849df5115c9', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'shuohao.yu@gmail.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-02 11:47:49', '2020-09-02 11:47:49', 'FsAc3klRT77sQucURQgeGQ==');
INSERT INTO `tb_user` VALUES (6, 'aaa', '4845ff073b24415d4e8eabd548467576', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '408777040@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-02 16:32:07', '2020-09-02 16:32:07', 'XBwK81Q68WmTmT/MpZekJg==');
INSERT INTO `tb_user` VALUES (7, 'fafafa', '79301dc9b44dfdedfa707273cda0bc8f', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'fafafa@163.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-03 23:04:05', '2020-09-03 23:04:05', 'bMrVBm+4UaI+uNF6VsU4rQ==');
INSERT INTO `tb_user` VALUES (8, 'hahaha', '4767a593e0bfe0b04bc013ba30fdd687', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'hahaha@qq.com', 0, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-03 23:41:54', '2020-09-03 23:41:54', 'bJKEHovzbAoxmu38KStpUg==');
INSERT INTO `tb_user` VALUES (9, 'nijo', 'bfef4e735b18ede44e694d454807a962', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'ni111jo@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-04 11:16:15', '2020-09-04 11:16:15', 'Da3mt5wHSQQjDF59PkyjaA==');
INSERT INTO `tb_user` VALUES (10, 'nihao', '0fb4df2ba9a21705ceaef5190045b482', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'nihao123@163.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-04 11:22:22', '2020-09-04 11:22:22', '/tkeZ6FDIMHxsl61w95m2A==');
INSERT INTO `tb_user` VALUES (11, 'nihaoa', '70e362743f5ecea9fce07683f14eb150', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'nihaof@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-04 11:23:57', '2020-09-04 11:23:57', 'CrX73KLlu3hNgxsY2Lz8oA==');
INSERT INTO `tb_user` VALUES (12, '发嘎嘎', '70e362743f5ecea9fce07683f14eb150', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'nihaoihif@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-04 11:23:57', '2020-09-04 11:23:57', 'CrX73KLlu3hNgxsY2Lz8oA==');
INSERT INTO `tb_user` VALUES (13, 'ssssg', 'e903784e4f9c1f1a8e3adcb2027f9328', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'ssssgf@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-09-05 21:09:01', '2020-09-05 21:09:01', 'Fq8g1dQYt9lQXM2Bjp5qVQ==');
INSERT INTO `tb_user` VALUES (14, 'shuohao', '8908dab28816a2e5f33f0953529295f6', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'shuohao.yu@hotmail.com', 1, '223.73.72.29', '223.73.72.29', '2020-09-11 20:20:49', '2020-09-11 20:20:49', 'D34tsUYXDwU7f9zYXo+OmQ==');
INSERT INTO `tb_user` VALUES (15, 'haohao', 'bc6d7061c24e599229cd856fa5b9975b', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '5137015@qq.com', 1, '223.73.72.117', '223.73.72.117', '2020-09-19 23:50:19', '2020-09-19 23:50:19', '/Qd9Ng3Sdm+GuwpWErjgSQ==');
INSERT INTO `tb_user` VALUES (16, 'tang', '4e04dcace9171836df36cf88bb062c1c', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'shuohaoa@163.com', 1, '223.73.72.117', '223.73.72.117', '2020-09-20 00:04:41', '2020-09-20 00:04:41', '6bjHLT4PKdxkhaI1hmldPw==');
INSERT INTO `tb_user` VALUES (17, 'test1', '1c50335ac877d55422808b6b67985424', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '565@qq.com', 1, '223.73.72.42', '223.73.72.42', '2020-09-23 09:21:40', '2020-09-23 09:21:40', 'YOb/KaZE2ISdegZJpnSE9w==');
INSERT INTO `tb_user` VALUES (18, '测试用户', '675e82a8ac40560cf0d097c4cdc07422', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '513701065@qq.com', 1, '223.73.72.42', '223.73.72.42', '2020-09-23 09:32:01', '2020-09-23 09:32:01', 'TaxyOVxkWU+rYmCu1ewm0w==');

-- ----------------------------
-- Table structure for tb_vote_record
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_record`;
CREATE TABLE `tb_vote_record`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `cid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应候选人的id',
  `aid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应活动的id',
  `vote_time` datetime(0) NOT NULL COMMENT '投票时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_vote_record
-- ----------------------------
INSERT INTO `tb_vote_record` VALUES ('752892120355831808', 2, '752605890481225728', '752573232778838016', '2020-09-08 13:58:17');
INSERT INTO `tb_vote_record` VALUES ('752917890755198976', 2, '752605890686746624', '752573232778838016', '2020-09-08 15:46:53');
INSERT INTO `tb_vote_record` VALUES ('752918403538223104', 2, '752605890481225728', '752573232778838016', '2020-09-08 15:48:56');
INSERT INTO `tb_vote_record` VALUES ('752919836270526464', 3, '752605890481225728', '752573232778838016', '2020-09-08 15:54:37');
INSERT INTO `tb_vote_record` VALUES ('752919874128314368', 3, '752605890481225728', '752573232778838016', '2020-09-08 15:54:46');
INSERT INTO `tb_vote_record` VALUES ('752920032849166336', 3, '752605889801748480', '752573232778838016', '2020-09-08 15:55:24');
INSERT INTO `tb_vote_record` VALUES ('752920450014642176', 4, '752605888035946496', '752573232778838016', '2020-09-08 15:57:04');
INSERT INTO `tb_vote_record` VALUES ('752920465743282176', 4, '752605888035946496', '752573232778838016', '2020-09-08 15:57:07');
INSERT INTO `tb_vote_record` VALUES ('752920557598539776', 4, '752823624787820544', '752573232778838016', '2020-09-08 15:57:29');
INSERT INTO `tb_vote_record` VALUES ('752922631748976640', 0, '752605888035946496', '752573232778838016', '2020-09-08 16:05:44');
INSERT INTO `tb_vote_record` VALUES ('752922653127344128', 0, '752605890481225728', '752573232778838016', '2020-09-08 16:05:49');
INSERT INTO `tb_vote_record` VALUES ('752922685465427968', 0, '752605888035946496', '752573232778838016', '2020-09-08 16:05:57');
INSERT INTO `tb_vote_record` VALUES ('753005146933297152', 1, '752167028785152000', '752165574024364032', '2020-09-08 21:33:37');
INSERT INTO `tb_vote_record` VALUES ('753005147956707328', 1, '752167026906103808', '752165574024364032', '2020-09-08 21:33:37');
INSERT INTO `tb_vote_record` VALUES ('753558016120324096', 1, '752260143223144448', '752256781182304256', '2020-09-10 10:10:31');
INSERT INTO `tb_vote_record` VALUES ('753558065940267008', 1, '752260144779231232', '752256781182304256', '2020-09-10 10:10:43');
INSERT INTO `tb_vote_record` VALUES ('753558075926904832', 1, '752260144779231232', '752256781182304256', '2020-09-10 10:10:46');
INSERT INTO `tb_vote_record` VALUES ('753559192488378368', 2, '752260144779231232', '752256781182304256', '2020-09-10 10:15:12');
INSERT INTO `tb_vote_record` VALUES ('753559227489845248', 2, '752260143223144448', '752256781182304256', '2020-09-10 10:15:20');
INSERT INTO `tb_vote_record` VALUES ('753559459539714048', 2, '752260143223144448', '752256781182304256', '2020-09-10 10:16:16');
INSERT INTO `tb_vote_record` VALUES ('753629793957707776', 1, '752605890481225728', '752573232778838016', '2020-09-10 14:55:45');
INSERT INTO `tb_vote_record` VALUES ('753629794964340736', 1, '752605890686746624', '752573232778838016', '2020-09-10 14:55:45');
INSERT INTO `tb_vote_record` VALUES ('753769602281897984', 1, '752605888035946496', '752573232778838016', '2020-09-11 00:11:18');
INSERT INTO `tb_vote_record` VALUES ('753769603556966400', 1, '752605889801748480', '752573232778838016', '2020-09-11 00:11:18');
INSERT INTO `tb_vote_record` VALUES ('753927459140796416', 2, '752167026448924672', '752165574024364032', '2020-09-11 10:38:34');
INSERT INTO `tb_vote_record` VALUES ('753927460055154688', 2, '752167026906103808', '752165574024364032', '2020-09-11 10:38:34');
INSERT INTO `tb_vote_record` VALUES ('753927461082759168', 2, '752167028785152000', '752165574024364032', '2020-09-11 10:38:34');
INSERT INTO `tb_vote_record` VALUES ('753931452327919616', 2, '753930049849131008', '753930040688771072', '2020-09-11 10:54:26');
INSERT INTO `tb_vote_record` VALUES ('753931507520765952', 2, '753930049404534784', '753930040688771072', '2020-09-11 10:54:39');
INSERT INTO `tb_vote_record` VALUES ('753931544002822144', 2, '753930050750906368', '753930040688771072', '2020-09-11 10:54:47');
INSERT INTO `tb_vote_record` VALUES ('754070245198528512', 1, '753930049849131008', '753930040688771072', '2020-09-11 20:05:56');
INSERT INTO `tb_vote_record` VALUES ('754070315130159104', 1, '753930050750906368', '753930040688771072', '2020-09-11 20:06:13');
INSERT INTO `tb_vote_record` VALUES ('754738542789263360', 1, '753930050750906368', '753930040688771072', '2020-09-13 16:21:31');
INSERT INTO `tb_vote_record` VALUES ('754738737354637312', 3, '753930052017586176', '753930040688771072', '2020-09-13 16:22:17');
INSERT INTO `tb_vote_record` VALUES ('754738765209010176', 3, '753930050750906368', '753930040688771072', '2020-09-13 16:22:24');
INSERT INTO `tb_vote_record` VALUES ('754738830925365248', 3, '753930054110543872', '753930040688771072', '2020-09-13 16:22:40');
INSERT INTO `tb_vote_record` VALUES ('754743380314947584', 1, '754742438270074880', '754742434017050624', '2020-09-13 16:40:44');
INSERT INTO `tb_vote_record` VALUES ('754743380340113408', 1, '754742438857277440', '754742434017050624', '2020-09-13 16:40:44');
INSERT INTO `tb_vote_record` VALUES ('754984992345423872', 1, '754742446289584128', '754742434017050624', '2020-09-14 08:40:49');
INSERT INTO `tb_vote_record` VALUES ('754984992488030208', 1, '754742438270074880', '754742434017050624', '2020-09-14 08:40:49');
INSERT INTO `tb_vote_record` VALUES ('756441731355901952', 2, '754742444054020096', '754742434017050624', '2020-09-18 09:09:23');
INSERT INTO `tb_vote_record` VALUES ('756441731431399424', 2, '754742438857277440', '754742434017050624', '2020-09-18 09:09:23');
INSERT INTO `tb_vote_record` VALUES ('756634283258413056', 1, '754742438270074880', '754742434017050624', '2020-09-18 21:54:31');
INSERT INTO `tb_vote_record` VALUES ('756634283359076352', 1, '754742438857277440', '754742434017050624', '2020-09-18 21:54:31');
INSERT INTO `tb_vote_record` VALUES ('757196211525517312', 1, '754742441755541504', '754742434017050624', '2020-09-20 11:07:25');
INSERT INTO `tb_vote_record` VALUES ('757196211571654656', 1, '754742446289584128', '754742434017050624', '2020-09-20 11:07:25');
INSERT INTO `tb_vote_record` VALUES ('757239339523506176', 1, '757198231682678784', '757198227018612736', '2020-09-20 13:58:47');
INSERT INTO `tb_vote_record` VALUES ('757239348797112320', 1, '757198232194383872', '757198227018612736', '2020-09-20 13:58:50');
INSERT INTO `tb_vote_record` VALUES ('757239379990151168', 1, '757198232194383872', '757198227018612736', '2020-09-20 13:58:57');
INSERT INTO `tb_vote_record` VALUES ('758116498806931456', 1, '754742438270074880', '754742434017050624', '2020-09-23 00:04:18');
INSERT INTO `tb_vote_record` VALUES ('758116499012452352', 1, '754742444054020096', '754742434017050624', '2020-09-23 00:04:18');
INSERT INTO `tb_vote_record` VALUES ('759511443300155392', 1, '757198232194383872', '757198227018612736', '2020-09-26 20:27:19');
INSERT INTO `tb_vote_record` VALUES ('759511448106827776', 1, '757198231682678784', '757198227018612736', '2020-09-26 20:27:20');
INSERT INTO `tb_vote_record` VALUES ('759511452833808384', 1, '757198231158390784', '757198227018612736', '2020-09-26 20:27:21');
INSERT INTO `tb_vote_record` VALUES ('759511608023056384', 1, '754742441755541504', '754742434017050624', '2020-09-26 20:27:58');
INSERT INTO `tb_vote_record` VALUES ('759511608039833600', 1, '754742444054020096', '754742434017050624', '2020-09-26 20:27:58');

SET FOREIGN_KEY_CHECKS = 1;
