/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : hmmsql

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2020-04-14 23:56:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO `auth_permission` VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO `auth_permission` VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO `auth_permission` VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO `auth_permission` VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO `auth_permission` VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO `auth_permission` VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO `auth_permission` VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO `auth_permission` VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO `auth_permission` VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO `auth_permission` VALUES ('24', 'Can view session', '6', 'view_session');
INSERT INTO `auth_permission` VALUES ('25', 'Can add user', '7', 'add_user');
INSERT INTO `auth_permission` VALUES ('26', 'Can change user', '7', 'change_user');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete user', '7', 'delete_user');
INSERT INTO `auth_permission` VALUES ('28', 'Can view user', '7', 'view_user');
INSERT INTO `auth_permission` VALUES ('29', 'Can add role', '8', 'add_role');
INSERT INTO `auth_permission` VALUES ('30', 'Can change role', '8', 'change_role');
INSERT INTO `auth_permission` VALUES ('31', 'Can delete role', '8', 'delete_role');
INSERT INTO `auth_permission` VALUES ('32', 'Can view role', '8', 'view_role');
INSERT INTO `auth_permission` VALUES ('33', 'Can add premission', '9', 'add_premission');
INSERT INTO `auth_permission` VALUES ('34', 'Can change premission', '9', 'change_premission');
INSERT INTO `auth_permission` VALUES ('35', 'Can delete premission', '9', 'delete_premission');
INSERT INTO `auth_permission` VALUES ('36', 'Can view premission', '9', 'view_premission');
INSERT INTO `auth_permission` VALUES ('37', 'Can add permission_api', '10', 'add_permission_api');
INSERT INTO `auth_permission` VALUES ('38', 'Can change permission_api', '10', 'change_permission_api');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete permission_api', '10', 'delete_permission_api');
INSERT INTO `auth_permission` VALUES ('40', 'Can view permission_api', '10', 'view_permission_api');
INSERT INTO `auth_permission` VALUES ('41', 'Can add premission_api', '10', 'add_premission_api');
INSERT INTO `auth_permission` VALUES ('42', 'Can change premission_api', '10', 'change_premission_api');
INSERT INTO `auth_permission` VALUES ('43', 'Can delete premission_api', '10', 'delete_premission_api');
INSERT INTO `auth_permission` VALUES ('44', 'Can view premission_api', '10', 'view_premission_api');

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for data_premission
-- ----------------------------
DROP TABLE IF EXISTS `data_premission`;
CREATE TABLE `data_premission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ps_name` varchar(50) NOT NULL,
  `ps_pid` int(11) NOT NULL,
  `ps_level` varchar(50) NOT NULL,
  `ps_c` varchar(50) NOT NULL,
  `ps_d` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_premission
-- ----------------------------
INSERT INTO `data_premission` VALUES ('1', '商品管理', '0', '0', '', '');
INSERT INTO `data_premission` VALUES ('2', '用户管理', '0', '0', '', '');
INSERT INTO `data_premission` VALUES ('3', '权限管理', '0', '0', '', '');
INSERT INTO `data_premission` VALUES ('4', '订单管理', '0', '0', '', '');
INSERT INTO `data_premission` VALUES ('5', '数据统计', '0', '0', '', '');
INSERT INTO `data_premission` VALUES ('6', '用户列表', '2', '1', '', '');
INSERT INTO `data_premission` VALUES ('7', '角色列表', '3', '1', '', '');
INSERT INTO `data_premission` VALUES ('8', '权限列表', '3', '1', '', '');
INSERT INTO `data_premission` VALUES ('9', '添加用户', '6', '2', '', '');
INSERT INTO `data_premission` VALUES ('10', '删除用户', '6', '2', '', '');
INSERT INTO `data_premission` VALUES ('11', '更新用户', '6', '2', '', '');
INSERT INTO `data_premission` VALUES ('12', '获取用户详情', '6', '2', '', '');
INSERT INTO `data_premission` VALUES ('13', '添加角色', '7', '2', ' ', ' ');
INSERT INTO `data_premission` VALUES ('14', '删除角色', '7', '2', ' ', ' ');
INSERT INTO `data_premission` VALUES ('15', '获取角色列表', '7', '2', ' ', ' ');
INSERT INTO `data_premission` VALUES ('16', '获取角色详情', '7', '2', ' ', ' ');
INSERT INTO `data_premission` VALUES ('17', '更新角色信息', '7', '2', ' ', ' ');
INSERT INTO `data_premission` VALUES ('18', '更新角色权限', '7', '2', ' ', ' ');
INSERT INTO `data_premission` VALUES ('19', '分配用户角色', '6', '2', ' ', ' ');

-- ----------------------------
-- Table structure for data_premission_api
-- ----------------------------
DROP TABLE IF EXISTS `data_premission_api`;
CREATE TABLE `data_premission_api` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ps_api_action` varchar(50) NOT NULL,
  `ps_api_order` int(11) DEFAULT NULL,
  `ps_id_id` int(11) DEFAULT NULL,
  `ps_api_path` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `data_permission_api_ps_id_id_d53af40e_fk_data_premission_id` (`ps_id_id`),
  CONSTRAINT `data_permission_api_ps_id_id_d53af40e_fk_data_premission_id` FOREIGN KEY (`ps_id_id`) REFERENCES `data_premission` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_premission_api
-- ----------------------------
INSERT INTO `data_premission_api` VALUES ('1', ' ', null, '1', 'goods');
INSERT INTO `data_premission_api` VALUES ('2', ' ', null, '2', 'users');
INSERT INTO `data_premission_api` VALUES ('3', ' ', null, '3', 'rights');
INSERT INTO `data_premission_api` VALUES ('4', ' ', null, '4', 'orders');
INSERT INTO `data_premission_api` VALUES ('5', 'get_premission_list', null, '8', 'rights');
INSERT INTO `data_premission_api` VALUES ('6', ' ', null, '5', 'reports');
INSERT INTO `data_premission_api` VALUES ('7', 'getAllUsers', null, '6', 'users');
INSERT INTO `data_premission_api` VALUES ('8', 'createUser', null, '9', 'users');
INSERT INTO `data_premission_api` VALUES ('9', 'deleteUser', null, '10', 'users');
INSERT INTO `data_premission_api` VALUES ('10', 'updateUser', null, '11', 'users');
INSERT INTO `data_premission_api` VALUES ('11', 'getUser', null, '12', 'users');
INSERT INTO `data_premission_api` VALUES ('12', 'getAllRoles', null, '7', 'roles');
INSERT INTO `data_premission_api` VALUES ('13', 'createRole', null, '13', 'roles');
INSERT INTO `data_premission_api` VALUES ('14', 'deleteRole', null, '14', 'roles');
INSERT INTO `data_premission_api` VALUES ('15', 'updateRole', null, '17', 'roles');
INSERT INTO `data_premission_api` VALUES ('16', 'getRoleById', null, '16', 'roles');
INSERT INTO `data_premission_api` VALUES ('17', 'updateRoleRight', null, '18', 'roles');
INSERT INTO `data_premission_api` VALUES ('18', 'setRole', null, '19', 'roles');
INSERT INTO `data_premission_api` VALUES ('19', 'getAllRoles', null, '15', 'roles');

-- ----------------------------
-- Table structure for data_role
-- ----------------------------
DROP TABLE IF EXISTS `data_role`;
CREATE TABLE `data_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL,
  `ps_ids` varchar(50) NOT NULL,
  `role_desc` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_role
-- ----------------------------
INSERT INTO `data_role` VALUES ('1', '超级管理员', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19', '超级管理员');
INSERT INTO `data_role` VALUES ('2', '测试角色', '1,2', '测试');
INSERT INTO `data_role` VALUES ('3', '测试角色2', '3,4,5,6', '测试');

-- ----------------------------
-- Table structure for data_user
-- ----------------------------
DROP TABLE IF EXISTS `data_user`;
CREATE TABLE `data_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `mobile` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `mg_state` tinyint(1) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `data_user_role_id_77664869_fk_data_role_id` (`role_id`),
  CONSTRAINT `data_user_role_id_77664869_fk_data_role_id` FOREIGN KEY (`role_id`) REFERENCES `data_role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of data_user
-- ----------------------------
INSERT INTO `data_user` VALUES ('1', 'hmm', '123456', '15829742201', '2363497179@qq.com', '1', '超级管理员', '1');
INSERT INTO `data_user` VALUES ('2', '李白', '123456', '1223345', '252@qq.com', '0', '超级管理员', '2');
INSERT INTO `data_user` VALUES ('3', '白居易', '123456', '1223345', '252@qq.com', '0', '超级管理员', '2');
INSERT INTO `data_user` VALUES ('4', '杜甫', '123456', '1223345', '252@qq.com', '0', '超级管理员', '3');
INSERT INTO `data_user` VALUES ('5', '张大千', '123456', '1223345', '252@qq.com', '0', '超级管理员', '3');
INSERT INTO `data_user` VALUES ('6', '齐白石', '123456', '1223345', '252@qq.com', '0', '超级管理员', '3');
INSERT INTO `data_user` VALUES ('7', '我爱你', '123456', '1223345', '252@qq.com', '0', '超级管理员', '2');
INSERT INTO `data_user` VALUES ('8', '唐伯虎', '123456', '12345678911', '123456@qq.com', '0', '', '3');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('4', 'auth', 'user');
INSERT INTO `django_content_type` VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('9', 'data', 'premission');
INSERT INTO `django_content_type` VALUES ('10', 'data', 'premission_api');
INSERT INTO `django_content_type` VALUES ('8', 'data', 'role');
INSERT INTO `django_content_type` VALUES ('7', 'data', 'user');
INSERT INTO `django_content_type` VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2020-03-28 10:00:43.191065');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2020-03-28 10:00:43.337681');
INSERT INTO `django_migrations` VALUES ('3', 'admin', '0001_initial', '2020-03-28 10:00:43.745754');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0002_logentry_remove_auto_add', '2020-03-28 10:00:43.840468');
INSERT INTO `django_migrations` VALUES ('5', 'admin', '0003_logentry_add_action_flag_choices', '2020-03-28 10:00:43.849444');
INSERT INTO `django_migrations` VALUES ('6', 'contenttypes', '0002_remove_content_type_name', '2020-03-28 10:00:43.930557');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0002_alter_permission_name_max_length', '2020-03-28 10:00:43.986532');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0003_alter_user_email_max_length', '2020-03-28 10:00:44.035492');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0004_alter_user_username_opts', '2020-03-28 10:00:44.043470');
INSERT INTO `django_migrations` VALUES ('10', 'auth', '0005_alter_user_last_login_null', '2020-03-28 10:00:44.087641');
INSERT INTO `django_migrations` VALUES ('11', 'auth', '0006_require_contenttypes_0002', '2020-03-28 10:00:44.090605');
INSERT INTO `django_migrations` VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', '2020-03-28 10:00:44.322881');
INSERT INTO `django_migrations` VALUES ('13', 'auth', '0008_alter_user_username_max_length', '2020-03-28 10:00:44.374742');
INSERT INTO `django_migrations` VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', '2020-03-28 10:00:44.424638');
INSERT INTO `django_migrations` VALUES ('15', 'auth', '0010_alter_group_name_max_length', '2020-03-28 10:00:44.471484');
INSERT INTO `django_migrations` VALUES ('16', 'auth', '0011_update_proxy_permissions', '2020-03-28 10:00:44.479462');
INSERT INTO `django_migrations` VALUES ('18', 'sessions', '0001_initial', '2020-03-28 10:00:44.540379');
INSERT INTO `django_migrations` VALUES ('21', 'data', '0001_initial', '2020-04-12 15:07:53.457454');
INSERT INTO `django_migrations` VALUES ('22', 'data', '0002_permission_api', '2020-04-13 11:57:13.960953');
INSERT INTO `django_migrations` VALUES ('23', 'data', '0003_permission_api_ps_api_path', '2020-04-13 14:39:12.818458');
INSERT INTO `django_migrations` VALUES ('24', 'data', '0004_auto_20200413_2248', '2020-04-13 14:48:17.538659');
INSERT INTO `django_migrations` VALUES ('25', 'data', '0005_auto_20200413_2335', '2020-04-13 15:36:21.540695');
INSERT INTO `django_migrations` VALUES ('26', 'data', '0006_auto_20200414_2202', '2020-04-14 14:02:21.726760');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('0uvzitlkxdc3qm3en8zsoaw9it20z10w', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:37:04.392738');
INSERT INTO `django_session` VALUES ('3314p9guur9w96z1mirgwibxxafkiv6b', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:12:44.307456');
INSERT INTO `django_session` VALUES ('3epzje40stctltvtdmcnrprdxe3m05vb', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:44:12.488500');
INSERT INTO `django_session` VALUES ('4207mjyed8b3rn29ykt0z029484gr8kn', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:03:20.856895');
INSERT INTO `django_session` VALUES ('49z7duxl2ulcigzzakod21sbvfaka630', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:15:46.845407');
INSERT INTO `django_session` VALUES ('5eobdzztqnej8mnrf8na73sty0ikacyv', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 12:47:34.542931');
INSERT INTO `django_session` VALUES ('8g8zyv4y19jeykcxnzfev2rz77h329g5', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:53:43.510094');
INSERT INTO `django_session` VALUES ('917p49vaehcup19fbfr2m4zpkd8ltaod', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:49:29.999567');
INSERT INTO `django_session` VALUES ('9ngq7ny54l2xfvigmqdo7jcx9vq1mk18', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:03:55.607120');
INSERT INTO `django_session` VALUES ('cqzyy97fka4xdcagfdj5l8dm002tauto', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:13:50.929165');
INSERT INTO `django_session` VALUES ('d6d4ux8nfdfx31hi04svwc7dfiuo99lp', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:15:14.671897');
INSERT INTO `django_session` VALUES ('f24u63zq5ruj9k19da94hm5wzbe0skii', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:43:48.561649');
INSERT INTO `django_session` VALUES ('fhozdow71vol2w37292r0w5w2tpx8smz', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 13:25:43.567572');
INSERT INTO `django_session` VALUES ('hod11000rb1d1rga3hersnq1o9ymhf4r', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:40:28.553070');
INSERT INTO `django_session` VALUES ('irnl8iwqa3i7pwnklidiiz2iu5auxhqq', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 12:45:43.945668');
INSERT INTO `django_session` VALUES ('j484teaxawxai2vekhso12cfk2dsxrg2', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:54:38.345539');
INSERT INTO `django_session` VALUES ('l3vu9y03v2rslbp8nvmz7e8nyj8p5ppy', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 13:07:18.004844');
INSERT INTO `django_session` VALUES ('lsc9mhvw42jicayniz4lnj4smn0okiz4', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:49:42.021293');
INSERT INTO `django_session` VALUES ('pz8kxyo05a9s4xzj2trh7mu5f31r1lg3', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 13:32:27.267629');
INSERT INTO `django_session` VALUES ('q8la26xmvgddfoclklx5shqnuqldel9r', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:39:41.284176');
INSERT INTO `django_session` VALUES ('sfq7y6yd1tyabri3l1lqsuhgbxr49bww', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-28 14:39:23.961074');
INSERT INTO `django_session` VALUES ('sz9pqwgmw1khcghrvo828q365scsqxy8', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:14:57.145732');
INSERT INTO `django_session` VALUES ('vmisdbez73opoa70r6xa4kr8cl6gv48e', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 13:08:27.458870');
INSERT INTO `django_session` VALUES ('vs6c41ij4yrwokb3syacp3texqp3hvqj', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:12:41.708066');
INSERT INTO `django_session` VALUES ('wge3htprpa76u83vz6ggrkx21xl98ere', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:37:30.641867');
INSERT INTO `django_session` VALUES ('wm8q4ydu6v8vg3z8oybbowrrveq3r3l7', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 02:13:16.769073');
INSERT INTO `django_session` VALUES ('wtjvzplppycvgqcq7k8dy9hm98cl5s7s', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-27 13:01:15.430007');
INSERT INTO `django_session` VALUES ('xrvo1dexrvrmgv4o074bm45p8g7s8qgp', 'ODkzY2IxY2ViNjdkYWIwZmUzMjY1ZjA4ZWZjODk5ZWEyNDAyZDFiYzp7InVzZXJfaWQiOjF9', '2020-04-14 01:38:17.932897');

-- ----------------------------
-- Table structure for ershoufang
-- ----------------------------
DROP TABLE IF EXISTS `ershoufang`;
CREATE TABLE `ershoufang` (
  `title` varchar(255) DEFAULT NULL,
  `style` varchar(255) DEFAULT NULL,
  `area` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `total_price` varchar(255) DEFAULT NULL,
  `unit_price` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ershoufang
-- ----------------------------
INSERT INTO `ershoufang` VALUES ('鱼化寨地铁口，绿地国际花都，大四室，捡漏房，满三', '4室2厅2卫', '143.27㎡', '高新区--绿地国际花都', '190', '13261元/㎡');
INSERT INTO `ershoufang` VALUES ('恒大御景精装大三室。带家具家电。中间楼层', '3室2厅2卫', '125.33㎡', '灞桥--恒大御景', '168', '13404元/㎡');
INSERT INTO `ershoufang` VALUES ('地铁口房源 精装修三室 业主急售 带三小二中指标', '3室2厅1卫', '90.17㎡', '曲江新区--万科城市之光', '169', '18742元/㎡');
INSERT INTO `ershoufang` VALUES ('急急急！和基听城85平全明豪装两室 从未住过人 ', '2室2厅1卫', '85.39㎡', '莲湖--和基听城', '140', '16395元/㎡');
INSERT INTO `ershoufang` VALUES ('二环内 土门 和基听城 两室 豪华装修 降价处理', '2室2厅1卫', '85.39㎡', '莲湖--和基听城', '140', '16395元/㎡');
INSERT INTO `ershoufang` VALUES ('舒适三居室 首付十万 忍痛急售 可按揭 不限购 ', '3室2厅1卫', '101.00㎡', '高陵--嘉园蓝湖九郡', '59', '10000元/㎡');
INSERT INTO `ershoufang` VALUES ('出售  公园北路  西光三十五街坊 2室', '2室1厅1卫', '59㎡', '新城--西光厂三十五街坊', '45', '9782元/㎡');
INSERT INTO `ershoufang` VALUES ('中海碧林湾小两室67平130万特价房', '2室2厅1卫', '67.00㎡', '曲江新区--中海碧林湾', '120', '13355元/㎡');
INSERT INTO `ershoufang` VALUES ('地铁口 loft复试 通双气 可按揭 不限购 9', '2室2厅2卫', '46㎡', '灞桥--华南城', '135', '15809元/㎡');
INSERT INTO `ershoufang` VALUES ('吉祥村地铁口 品质电梯房 温馨二居 正在手按揭 ', '2室2厅1卫', '89.85㎡', '雁塔--阳光嘉庭', '125', '16988元/㎡');
INSERT INTO `ershoufang` VALUES ('秒杀！急售！！西二环 和基听城 铜雀台 全明户型', '2室2厅1卫', '85.39㎡', '莲湖--和基听城', '188', '14603元/㎡');
INSERT INTO `ershoufang` VALUES ('现房 现房  低于市场价  即卖即住', '2室2厅1卫', '90㎡', '雁塔--南姜美景', '42', '7118元/㎡');
INSERT INTO `ershoufang` VALUES ('116平 满五唯一住房 南北通透 75万 楼层好', '3室2厅2卫', '116㎡', '鄠邑--紫云小区', '35.8', '8325元/㎡');
INSERT INTO `ershoufang` VALUES ('南北通透 大城小院 2室2厅 107平 电梯房 ', '2室2厅2卫', '107㎡', '临潼--大城小院', '100', '11111元/㎡');
INSERT INTO `ershoufang` VALUES ('中海精装2室74平125万 拎包入住', '2室2厅1卫', '73.58㎡', '未央--中海开元壹号(东区)', '132', '10683元/㎡');
INSERT INTO `ershoufang` VALUES ('满二唯一住房 南北通透 188万 荣华北经城 精', '3室2厅2卫', '128.74㎡', '未央--荣华北经城', '249', '16165元/㎡');
INSERT INTO `ershoufang` VALUES ('浐灞 经典两居室 团购6800起 五证齐全 不限', '2室1厅1卫', '59㎡', '灞桥--华南城', '248', '17971元/㎡');
INSERT INTO `ershoufang` VALUES ('浐灞生态区 地铁口 无缝对接 不限购 一手lof', '2室2厅2卫', '43㎡', '灞桥--华南城', '78', '11142元/㎡');
INSERT INTO `ershoufang` VALUES ('园林社区 环境真正美 奢华安静 舒心小区 业主诚', '2室2厅1卫', '90㎡', '莲湖--丰盛园小区', '32', '10666元/㎡');
INSERT INTO `ershoufang` VALUES ('满五唯一住房 电梯房 96平 77万 2室2厅 ', '2室2厅1卫', '96㎡', '鄠邑--家福花园', '47', '6025元/㎡');
INSERT INTO `ershoufang` VALUES ('西苑 西航三校旁，有钥匙 三室， 产证在手无税 ', '3室2厅1卫', '123.56㎡', '经开区--西航西苑小区', '110', '8686元/㎡');
INSERT INTO `ershoufang` VALUES ('78万精装中层全款急售 高铁新城东晋桃源园96平', '2室2厅1卫', '96.17㎡', '经开区--东晋桃源缙福源', '42', '8936元/㎡');
INSERT INTO `ershoufang` VALUES ('南郊电子城电子正街 圣都大厦 三室 看房方便诚意', '3室1厅2卫', '121.83㎡', '雁塔--圣都大厦', '54', '14594元/㎡');
INSERT INTO `ershoufang` VALUES ('41万 北城新天地 电梯房 精装修 满五唯一住房', '2室1厅2卫', '60㎡', '高陵--北城新天地', '299', '20909元/㎡');
INSERT INTO `ershoufang` VALUES ('67万 精装修 南北通透 3室2厅 满二唯一住房', '3室2厅1卫', '104.5㎡', '高陵--天正花园', '46', '10000元/㎡');
INSERT INTO `ershoufang` VALUES ('送车位 产证在手 可按揭 两梯两户 南北通透大三', '3室2厅2卫', '154.03㎡', '曲江新区--万科城市之光', '123', '13303元/㎡');
INSERT INTO `ershoufang` VALUES ('高新一中旁仅有电梯房，只卖215万，单价1.6W', '3室2厅2卫', '138㎡', '高新区--枫叶新家园', '105', '9545元/㎡');
INSERT INTO `ershoufang` VALUES ('急售 劳动路地铁口 西仪103家属院 70平只要', '2室2厅1卫', '70㎡', '莲湖--西仪103厂家属院', '110', '11578元/㎡');
INSERT INTO `ershoufang` VALUES ('朝南 电梯房 2室2厅 73平 精装修 满二 房', '2室2厅1卫', '73㎡', '高陵--天正银河湾', '52', '6117元/㎡');
INSERT INTO `ershoufang` VALUES ('市政府旁 地铁口 名校对面 首付6万起 配套齐全', '1室1厅1卫', '30㎡', '经开区--华岭中央公园', '61', '9838元/㎡');
INSERT INTO `ershoufang` VALUES ('急售！45万 精装修 78平  2室2厅 诚心出', '2室2厅1卫', '78㎡', '未央--美美佳园', '98', '7368元/㎡');
INSERT INTO `ershoufang` VALUES ('华远永兴大厦 电梯房  精装修 南北通透 169', '3室2厅2卫', '169㎡', '莲湖--华远永兴大厦', '110', '8686元/㎡');
INSERT INTO `ershoufang` VALUES ('地铁口，河景房，品质小区，中间楼层，自带幼儿园', '2室2厅1卫', '92㎡', '高陵--水半湾', '57', '8507元/㎡');
INSERT INTO `ershoufang` VALUES ('明光路十字  3室电梯 自住改善 单价8300电', '3室2厅2卫', '126.63㎡', '未央--天竹综合大厦', '81', '18881元/㎡');
INSERT INTO `ershoufang` VALUES ('东郊 双地铁口 配套齐全 捡漏特价房 网红复式 ', '2室2厅2卫', '47㎡', '灞桥--华南城', '245', '24500元/㎡');
INSERT INTO `ershoufang` VALUES ('捡漏了  现急售   精装两房  首付10万  ', '2室2厅2卫', '50㎡', '高陵--北城新天地', '230', '26744元/㎡');
INSERT INTO `ershoufang` VALUES ('奥林匹克花园两室复试得房率超高地铁口不限购急售', '2室2厅1卫', '37㎡', '西咸新区--奥林匹克花园伦敦奥运村(1期)', '125', '12367元/㎡');
INSERT INTO `ershoufang` VALUES ('直降10万中海大盘 南北通透 园林小区 有车位 ', '4室2厅2卫', '143.00㎡', '曲江新区--中海凯旋门', '135', '11946元/㎡');
INSERT INTO `ershoufang` VALUES ('地铁3号线长乐公园永嘉坊1室1厅精装双气可按揭4', '1室1厅1卫', '46㎡', '碑林--兴庆小区永嘉坊', '53', '13712元/㎡');
INSERT INTO `ershoufang` VALUES ('环境优美，地理位置优越，周边配套齐全，交通便利', '2室1厅2卫', '40㎡', '高陵--爱尚泾渭', '200', '21956元/㎡');
INSERT INTO `ershoufang` VALUES ('龙首原地铁口 龙首北路文景路颐馨花园两室精装朝南', '2室2厅1卫', '92.46㎡', '未央--颐馨花园', '145', '11600元/㎡');
INSERT INTO `ershoufang` VALUES ('西大街桥梓口（早慈巷小区家属院）双气3楼3室可按', '3室2厅1卫', '110㎡', '莲湖--早慈巷小区', '318', '17976元/㎡');
INSERT INTO `ershoufang` VALUES ('拼搏多年，也该给自己漂泊的灵魂安家了，地铁口两室', '2室2厅1卫', '95㎡', '碑林--北沙庄园', '100', '10917元/㎡');
INSERT INTO `ershoufang` VALUES ('现房  交通便利 开发商直售  单价9000即卖', '2室2厅1卫', '112㎡', '雁塔--南姜美景', '118.4', '10033元/㎡');
INSERT INTO `ershoufang` VALUES ('急售天正花园三室南北通透精装全陪楼梯房小区自带幼', '3室2厅1卫', '100㎡', '高陵--天正花园', '148', '10647元/㎡');
INSERT INTO `ershoufang` VALUES ('成南客运站 欧亚旁飞升国际毛坯2室 一把付诚心出', '2室2厅1卫', '78㎡', '雁塔--飞升国际广场', '110', '12145元/㎡');
INSERT INTO `ershoufang` VALUES ('西航花园，132平三室两厅两卫，精装，75万，三', '3室2厅2卫', '132.00㎡', '灞桥--西航花园(公寓住宅)', '140', '16395元/㎡');
INSERT INTO `ershoufang` VALUES ('石家街地铁口  45万包更名  新房 暖气 毛坯', '2室1厅2卫', '85.00㎡', '新城--东岸阳光', '790', '22246元/㎡');
INSERT INTO `ershoufang` VALUES ('诚心急售秦川社区28街坊  1楼 简单装修  满', '2室1厅1卫', '62㎡', '新城--秦川社区28街坊', '103', '12516元/㎡');
INSERT INTO `ershoufang` VALUES ('保真 捡漏 美包包楼层 精装大三室 三桥地铁口 ', '3室2厅2卫', '133㎡', '高陵--西纺三村小区', '168', '12849元/㎡');
INSERT INTO `ershoufang` VALUES ('2室2厅 天朗大兴郡蔚蓝君城 128万 精装修 ', '2室2厅1卫', '79.86㎡', '莲湖--天朗大兴郡蔚蓝君城', '125', '10416元/㎡');
INSERT INTO `ershoufang` VALUES ('捡漏急售 单价8300 天竹大厦 三室 105万', '3室2厅2卫', '126.63㎡', '未央--天竹综合大厦', '98', '11951元/㎡');
INSERT INTO `ershoufang` VALUES ('新地标温泉花园，精装小两室，铁小学跟前，可按揭，', '2室1厅1卫', '73㎡', '临潼--群星莱骊', '345', '15972元/㎡');
INSERT INTO `ershoufang` VALUES ('（保真）i都会 一室指标房 带租约 业主诚售 看', '1室1厅1卫', '35.1㎡', '高新区--逸翠园i都会', '260', '18683元/㎡');
INSERT INTO `ershoufang` VALUES ('西大街 儿童医院 早慈巷 精装修双气两室 南北房', '2室1厅1卫', '67㎡', '莲湖--早慈巷小区', '91', '10705元/㎡');
INSERT INTO `ershoufang` VALUES ('东方罗马花园精装新房两室 没住过人 客厅很大 临', '2室2厅1卫', '42.9㎡', '浐灞--东方罗马花园', '438', '16653元/㎡');
INSERT INTO `ershoufang` VALUES ('澜泊湾，精装小两室，地铁口，证满二，可按揭', '2室1厅2卫', '88㎡', '临潼--澜泊湾', '128', '10666元/㎡');
INSERT INTO `ershoufang` VALUES ('高新一中高新一小学位，精装修即买即住诚心出售', '3室2厅2卫', '100㎡', '高新区--高科花园(北区)', '700', '28355元/㎡');
INSERT INTO `ershoufang` VALUES ('带高新一中一小，双指标中间楼层，看房方便', '2室2厅1卫', '86㎡', '高新区--枫叶苑北区', '83', '13606元/㎡');
INSERT INTO `ershoufang` VALUES ('城东大盘  央企高科   四室豪装  送家具家电', '4室2厅2卫', '134.88㎡', '灞桥--高科绿水东城(四期)', '85', '16634元/㎡');
INSERT INTO `ershoufang` VALUES ('精装两室  可拎包入住  不限购 直接过户', '2室2厅1卫', '77.00㎡', '高陵--北城新天地', '68', '13335元/㎡');
INSERT INTO `ershoufang` VALUES ('47万北十字城区中心 多层六楼三室简单装修 房产', '3室2厅1卫', '98㎡', '临潼--区委小区(临潼区)', '220', '13414元/㎡');
INSERT INTO `ershoufang` VALUES ('3室两室两卫，交通便利，大型社区，有证可按揭贷款', '3室2厅2卫', '137㎡', '临潼--中国临潼石油生活城', '600', '26086元/㎡');
