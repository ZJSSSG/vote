/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50736
 Source Host           : localhost:3306
 Source Schema         : vote_system

 Target Server Type    : MySQL
 Target Server Version : 50736
 File Encoding         : 65001

 Date: 18/10/2024 14:13:08
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
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 280 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 154 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 119 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of admin_user_role
-- ----------------------------
INSERT INTO `admin_user_role` VALUES (109, 1, 1);
INSERT INTO `admin_user_role` VALUES (112, 21, 3);
INSERT INTO `admin_user_role` VALUES (113, 19, 2);
INSERT INTO `admin_user_role` VALUES (118, 20, 3);

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
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_activity
-- ----------------------------
INSERT INTO `tb_activity` VALUES ('1224770762305437696', '二狗子', '班长竞选', '<p>班长竞选</p>', NULL, '{\"voteType\":\"single\",\"cycleType\":\"false\",\"totalVotes\":\"1\",\"oneVotes\":\"1\"}', '1', 0, '2024-04-02 00:00:00', '2024-04-04 00:00:00', '2024-04-02 17:21:45', '2024-04-02 17:23:22');
INSERT INTO `tb_activity` VALUES ('1225035045417254912', '李四', '竞选市长', '<p>市长竞选投票、每人只能投一票</p>', NULL, '{\"voteType\":\"single\",\"cycleType\":\"false\",\"totalVotes\":\"1\",\"oneVotes\":\"1\"}', '1', 0, '2024-04-03 00:00:00', '2024-04-07 00:00:00', '2024-04-03 10:51:55', '2024-04-03 10:52:59');
INSERT INTO `tb_activity` VALUES ('1296831692182388736', 'youluoyuan.com', '幽络源副站长竞选', '<p>竞选成功者可管理网站后台，管理群内用户</p><p>www.youluoyuan.com</p>', NULL, '{\"voteType\":\"single\",\"cycleType\":\"false\",\"totalVotes\":\"1\",\"oneVotes\":\"1\"}', '1', 0, '2024-10-18 00:00:00', '2024-10-19 00:00:00', '2024-10-18 13:46:09', '2024-10-18 13:59:25');

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
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_candidate
-- ----------------------------
INSERT INTO `tb_candidate` VALUES ('1224770769146347520', '1224770762305437696', '张三', 1, NULL, '', NULL, 1, 1, '2024-04-02 17:21:47', '2024-04-02 17:24:19');
INSERT INTO `tb_candidate` VALUES ('1224770779342700544', '1224770762305437696', '李四', 2, NULL, '', NULL, 0, 1, '2024-04-02 17:21:49', '2024-04-02 17:22:52');
INSERT INTO `tb_candidate` VALUES ('1225035051247337472', '1225035045417254912', '张一', 1, NULL, '', NULL, 1, 1, '2024-04-03 10:51:56', '2024-04-03 10:55:08');
INSERT INTO `tb_candidate` VALUES ('1225035160106303488', '1225035045417254912', '张二', 2, NULL, '', NULL, 1, 1, '2024-04-03 10:52:22', '2024-04-03 10:54:31');
INSERT INTO `tb_candidate` VALUES ('1225035183917367296', '1225035045417254912', '张三', 3, NULL, '', NULL, 0, 1, '2024-04-03 10:52:28', '2024-04-03 10:52:32');
INSERT INTO `tb_candidate` VALUES ('1296831702433267712', '1296831692182388736', '土拨鼠', 1, NULL, '', NULL, 2, 1, '2024-10-18 13:46:12', '2024-10-18 14:00:03');
INSERT INTO `tb_candidate` VALUES ('1296831754753015808', '1296831692182388736', '土豆', 2, NULL, '', NULL, 0, 1, '2024-10-18 13:46:24', '2024-10-18 13:54:16');
INSERT INTO `tb_candidate` VALUES ('1296831819747950592', '1296831692182388736', '佩恩', 3, NULL, '', NULL, 0, 1, '2024-10-18 13:46:40', '2024-10-18 13:46:48');

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
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_notice
-- ----------------------------
INSERT INTO `tb_notice` VALUES ('1296831351692984320', '1', '幽络源网站官方QQ群：307531422', '<p>群内会第一时间发布网站最新资源信息，欢迎加入我们！！</p>', '1', '2024-10-18 13:44:48', '2024-10-18 13:44:48');

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
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `salt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '盐值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, 'youluoyuan.com', '30ccc5b2011ce1e5074d70d7a186dc7e', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', 'admin@163.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2020-08-26 16:44:39', '2020-08-26 16:44:39', 'm33DRgsqEtALuZi2Cxz8fQ==');
INSERT INTO `tb_user` VALUES (19, '张三', '9a439f645dbe150a4efe849d1268b522', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '473116749@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2024-04-02 17:15:50', '2024-04-02 17:15:50', '1g668MwFXA1eYai8/TVC7Q==');
INSERT INTO `tb_user` VALUES (20, '土豆', 'c961a45a92f9798d531ad0b1c32400bb', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '47311679@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2024-04-02 17:19:54', '2024-04-02 17:19:54', 'n8x/dx3pI1itEDEx6XgA5A==');
INSERT INTO `tb_user` VALUES (21, '李四', '5bf1f55c7812c5cbffa7ad144121b093', 'https://s1.ax1x.com/2020/09/10/wGlRa9.png', '4731167499@qq.com', 1, '0:0:0:0:0:0:0:1', '0:0:0:0:0:0:0:1', '2024-04-02 17:20:25', '2024-04-02 17:20:25', 'qk1KP2d0U734DnEP9l1NgA==');

-- ----------------------------
-- Table structure for tb_vote_record
-- ----------------------------
DROP TABLE IF EXISTS `tb_vote_record`;
CREATE TABLE `tb_vote_record`  (
  `id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'ID',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `cid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应候选人的id',
  `aid` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应活动的id',
  `vote_time` datetime NOT NULL COMMENT '投票时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tb_vote_record
-- ----------------------------
INSERT INTO `tb_vote_record` VALUES ('1224771410098913280', 20, '1224770769146347520', '1224770762305437696', '2024-04-02 17:24:19');
INSERT INTO `tb_vote_record` VALUES ('1225035698734628864', 21, '1225035160106303488', '1225035045417254912', '2024-04-03 10:54:31');
INSERT INTO `tb_vote_record` VALUES ('1225035855601598464', 19, '1225035051247337472', '1225035045417254912', '2024-04-03 10:55:08');
INSERT INTO `tb_vote_record` VALUES ('1296835086129299456', 1, '1296831702433267712', '1296831692182388736', '2024-10-18 13:59:39');
INSERT INTO `tb_vote_record` VALUES ('1296835187891503104', 20, '1296831702433267712', '1296831692182388736', '2024-10-18 14:00:03');

SET FOREIGN_KEY_CHECKS = 1;
