/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : kbw

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 16/10/2018 11:06:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tp_image
-- ----------------------------
DROP TABLE IF EXISTS `tp_image`;
CREATE TABLE `tp_image`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NULL DEFAULT 1 COMMENT '1轮播图',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `img` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` tinyint(4) NULL DEFAULT 100,
  `status` tinyint(4) NULL DEFAULT 1,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_image
-- ----------------------------
INSERT INTO `tp_image` VALUES (1, 1, 'aaa', '/images/flow_image/20180929/6c2a286d12f0420b37a3a8869c655d50.png', 100, 1, 1538187950, 1538187950, NULL);
INSERT INTO `tp_image` VALUES (2, 1, 'aaa', '/images/flow_image/20180929/6c2a286d12f0420b37a3a8869c655d50.png', 100, 2, 1538188072, 1538188979, NULL);

-- ----------------------------
-- Table structure for tp_news
-- ----------------------------
DROP TABLE IF EXISTS `tp_news`;
CREATE TABLE `tp_news`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NULL DEFAULT 1 COMMENT '1',
  `cate_id` tinyint(4) NULL DEFAULT 1 COMMENT '1折扣 2资讯',
  `author` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '作者',
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面图',
  `description` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '简介',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '新闻内容',
  `views` int(11) NULL DEFAULT 0 COMMENT '浏览量',
  `status` tinyint(2) NULL DEFAULT 1 COMMENT '1正常 2禁用 0删除',
  `sort` int(10) NULL DEFAULT 0,
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '资讯表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tp_news
-- ----------------------------
INSERT INTO `tp_news` VALUES (1, 1, 1, '国家统计局', '1-4月房地产开发投资同比增10.3% 商品房销售额增9%', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '简单介绍一下求职技巧', '&lt;p&gt;\r\n	2018年1-4月份全部房地产开发投资和销售情况：\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n	【房地产开发投资完成情况】\r\n&lt;/p&gt;\r\n&lt;p&gt;\r\n	&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;2018年1-4月份，全国房地产开发投资30592亿元，同比名义增长10.3%，增速比1-3月份回落0.1个百分点。其中，住宅投资21331亿元，增长14.2%，增速提高0.9个百分点、住宅投资占房地产开发投资的比重为69.7%。\r\n&lt;/p&gt;\r\n&lt;p style=&quot;text-align:center;&quot;&gt;\r\n	&lt;img src=&quot;/Uploads/Admin/2018-07-10/5b447fd3b7d58.png&quot; alt=&quot;&quot; /&gt;\r\n&lt;/p&gt;\r\n&lt;div&gt;\r\n	&lt;p&gt;\r\n		2018年1-4月份全部房地产开发投资和销售情况：\r\n	&lt;/p&gt;\r\n	&lt;p&gt;\r\n		【房地产开发投资完成情况】\r\n	&lt;/p&gt;\r\n&lt;span&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;2018年1-4月份，全国房地产开发投资30592亿元，同比名义增长10.3%，增速比1-3月份回落0.1个百分点。其中，住宅投资21331亿元，增长14.2%，增速提高0.9个百分点、住宅投资占房地产开发投资的比重为69.7%。&lt;/span&gt;&lt;br /&gt;\r\n&lt;/div&gt;', 9095, 1, 0, 1533743450, 1527837290);
INSERT INTO `tp_news` VALUES (3, 1, 2, '腾讯新闻', '买房技巧：买房看配套，配套重交通', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '买房技巧：买房看配套，配套重交通', '&lt;p&gt;\r\n	&lt;span style=&quot;font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px;&quot;&gt;房屋是比较特殊的商品，不管是首次购房客户，还是二次改善购房者，在买房前都会有一个比较周全的考量，比如楼盘地理位置、周边配套设施、休闲环境、交通便利、医疗教育等。在这里提醒大家：买房看配套，配套重交通！&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180731/1533022108948205.jpg&quot; title=&quot;1533022108948205.jpg&quot; alt=&quot;1.jpg&quot;/&gt;&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;为什么交通配套是关键？&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;1、交通配套决定了居民生活圈&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;大部分人买房主要有两方面，第一是为了生活，第二是为了工作。如果交通不好，一是上下班的时间成本、金钱成本和痛苦程度大大增加；二是出门做任何事都不方便，缺乏社交，尤其对于年轻人来说，小区交通不良影响深远。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;2、交通配套塑造地段价值&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;影响房价显著的因素是楼盘所在地段，而决定地段好坏的活跃因素就是交通配套状况。交通发达促进了沿线地段的开发，交通的升级重新塑造了该地段的新价值。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;如何看交通配套好不好？&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;看交通配套好不好重点在于轨道交通线，我们可以分两个方面来看：&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;一、轨道交通线已经运营&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;1、公共交通路线（公交/地铁）&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;你从住处到单位需要坐几趟线路？是都需要多次倒车？路上需要花费多少时间？公共交通的运营时间是几点到几点？间隔时间是多久？这些问题你都必须一一考察清楚，不然上班迟到就可能会变成你的日常。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;2、拥挤程度&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;道路及公共交通的拥挤程度一样也是需要考虑的，这不仅仅关乎着你的生活质量，同时也关乎着你上班是否会迟到。比如，如果你每天出门的时间刚好赶上下班高峰期，那么不仅开车收到影响，乘坐公共交通，从进站、检查、等车的时间都会与非高峰时段不同，而这些终都可能会导致你迟到。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;3、住处到站点的距离&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;如果购房者通过公共交通的形式出门，就必须了解家和轨道交通站的距离远近。如果距离过远，购房者每次需要花费不少的时间在走路。一般来说，住处距离站点的距离控制在步行15分钟之内比较适合。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;二、轨道交通线尚未运营&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;1、通车时间&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;对于正在规划期的交通轨道线，什么时候能通车、站点分布是否会改变等问题都还是不确定的，所以购房者买房的时候就要考虑到这些。通常来说，轨道建设破土动工后一到两年内可以投入运营，购买这样的楼盘就会更有保证。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;2、综合性价比&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;一些尚未运营的交通轨道线大多建设在外环城郊，大部分开发商在售房会把交通当做卖点，别的都省略不提，一味提升房价，但只要购房者综合考虑一下就会明白，那些房产根本不值这么多钱。所以，你在买房时，别忘了看楼盘的综合性价比。&lt;/p&gt;&lt;p style=&quot;text-align: left;&quot;&gt;&lt;br/&gt;&lt;/p&gt;', 51030, 1, 100, 1533772250, 1533022128);
INSERT INTO `tp_news` VALUES (4, 1, 1, '半月谈', '高地价低房价，开发商赔本拿地！谁会做亏本生意？', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '今年以来，多个城市加码房地产市场调控力度，出台了限购限价等措施。然而，一些开发商拿地热情并未减退。半月谈记者近期在江西南昌土地拍卖市场了解到，有的地块楼面价与新房价仅差1400多元。“面粉”与“面包”价格如此接近，能烤出好“面包”吗？', '<p >　　今年以来，多个城市加码房地产市场调控力度，出台了限购限价等措施。然而，一些开发商拿地热情并未减退。半月谈记者近期在江西南昌土地拍卖市场了解到，有的地块楼面价与新房价仅差1400多元。“面粉”与“面包”价格如此接近，能烤出好“面包”吗？</p>\r\n            <p >　　楼面价1万1，房价1万2</p>\r\n            <p >　　今年5月11日，南昌市西湖区水厂路以北、万店路以西DABJ2018009号地块，经过482轮、近4个小时的竞价，被南昌茂泰房地产开发有限公司竞得，楼面价高达每平方米11038.6元，溢价率高达112%。而相关土地出让须知明确，该地块所建住宅的控制性房屋销售价格(均价)上限为每平方米12500元。</p>\r\n            <p >　　当天同时被高价拍卖的还有位于南昌市东湖区中大路以东、安山路以南DAAJ2018008号地块，其楼面价高达每平方米10756.3元，与每平方米14300元的政府限价也只有3500元左右的价差。</p>\r\n            <p >　　“面粉”贵了，“面包”反而便宜了。半月谈记者注意到，这两宗地块附近带装修的商品房均价达每平方米1.8万元左右，与未来的限价新房价格形成每平方米5500元的价格倒挂。</p>\r\n            <p >　　业内人士表示，从一定程度上讲，这是违反常理的现象。“每平方米1400多元，连建筑安装成本都不够。”朝晖城建集团有限公司总工程师熊震洪介绍，一般而言，房屋主体建筑每平方米造价约为1300元，安装水电、消防等设施成本每平方米需要200元左右，另外还有道路管网、小区绿化等设施成本，核算下来每平方米建筑安装成本总计约为2500元。</p>\r\n            <p >　　江西财经大学房地产开发与管理系主任刘旦介绍，房地产项目开发总成本构成大致为：拍地成本约占40%、建安成本和各种税费等财务成本合计约占50%，自有利润约占10%。“每个公司拍地都会有基本的财务原则和投资收益预期，并进行内部收益测算，在很大可能面临亏损的情况下拍地，显然是有其他考虑。”</p>\r\n            <p >　　半月谈记者电话联系南昌茂泰房地产开发有限公司母公司新力地产，对方表示对此不便予以评说。南昌市国土局相关负责人表示，对新房限价有助于释放避免房价过热的信号，开发企业竞价拍地则是市场行为。</p>\r\n            <p >　　“土拍盛宴”缘何而起？</p>\r\n            <p >　　在强化房地产市场调控背景下，房价涨幅正成为一个敏感的考核指标。近期，住建部约谈12个城市的相关负责人，强调要毫不动摇地坚持“房子是用来住的、不是用来炒的”定位，坚持房地产市场调控目标不动摇、力度不放松，落实地方调控主体责任，因城因地制宜，精准施策。</p>\r\n            <p >　　相关专家指出，土地出让收入仍然是地方财政的重要来源。财政部近期公布的数据显示，今年1—4月，全国国有土地使用权出让收入约1.8万亿元，同比增长40.7%。</p>\r\n            <p >　　刘旦认为，近期南昌土地拍卖市场上之所以会出现开发企业宁肯冒赔本风险也要拿地的现象，不排除当地商品住宅市场库存偏紧的因素。在去化周期较短的背景下，一些资金实力雄厚的大企业可能会为了布局未来、抢占市场而进行反周期的操作。</p>\r\n            <p >　　半月谈记者了解到，南昌市近期拍卖的土地出让须知明确，宗地成交后，在《国有建设用地使用权出让合同》中明确竞得人接受宗地商品住宅销售均价上限。宗地的商品住宅自《商品房买卖合同》签订之日起，5年内不得转让。同时，交付土地后9个月开工建设，自开工之日起两年内整体竣工。</p>\r\n            <p >　　高地价低房价，是耶非耶？</p>\r\n            <p >　　一位房地产开发企业负责人分析指出，南昌茂泰房地产开发有限公司所竞得的这宗地块，新房至少要卖出每平方米1.6万元以上的价格才能保证不亏损，而这与政府限价相差约4000元。</p>\r\n            <p >　　刘旦指出，“限房价、竞地价”调控模式是对开发企业资金实力的重要考验，可能会推动房地产市场“大吃小”，淘汰中小开发企业，进一步提高房地产市场集中度。同时，这进一步释放出房地产市场投资收益率不会如过去那样高的信号。</p>\r\n            <p >　　微信网友“自由空间”评论说，楼面价这么高，售价这么低，总觉得是表象，开发商是市场主体，又不是慈善机构，谁会做亏本生意呢？舆论担忧，在高成本开发压力和一、二手房明显价格倒挂下，开发企业在售房时可能会采取另外加价、捆绑销售车位、抬高装修价格、提高首付比例等形式，规避政府限价。</p>\r\n            <p >　　有分析指出，土地市场的火热与房产市场的“冷清”现象难以持久，潜藏一定金融风险。作为一种市场行为，保障开发企业合理的利润空间是项目正常运作的题中之义。专家建议，限房价的同时，也应合理设置竞地报价上限。（记者：余贤红 ：《半月谈》2018年第11期）</p>', 60132, 1, 0, 1533811250, 1527837290);
INSERT INTO `tp_news` VALUES (5, 1, 1, '博鳌房地产论坛', '博鳌快讯|圣象连续九年出席博鳌论坛 引领美好住居新航海', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '博鳌快讯|圣象连续九年出席博鳌论坛 引领美好住居新航海', '&lt;p&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;&amp;nbsp;&lt;span style=&quot;font-family: &amp;quot;Microsoft YaHei&amp;quot;; text-indent: 32px; background-color: rgb(255, 255, 255);&quot;&gt;7月21日，第十八届博鳌o21世纪房地产论坛将在海南拉开帷幕。作为论坛的首席合作伙伴，面对如今房地产日新月异的变化趋势，圣象提出的独到见解与观点，深受现场业内人士的高度认可。中国房地产改革进入了第三个十年，今年博鳌论坛的主题“潮平风正，美好佳居新航海”，不仅为我们勾勒了美好居住空间的愿景，更是为当下中国房地产市场发展的机制建设和整体调控政策定下了基调。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;&lt;span style=&quot;font-family: &amp;quot;Microsoft YaHei&amp;quot;; text-indent: 32px; background-color: rgb(255, 255, 255);&quot;&gt;&lt;span style=&quot;font-family: &amp;quot;Microsoft YaHei&amp;quot;; text-indent: 32px; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;&amp;nbsp;本届论坛以一场汇聚业界精英领袖、酣战激烈的“圣象o21世纪高尔夫名人赛”拉开帷幄，大亚圣象家居股份有限公司暨圣象集团有限公司董事长陈晓龙先生致开幕词并开球。尽管当天气候受台风波及，但风雨并未影响参赛选手纵横捭阖的胸怀和挑战巅峰的决心。谈笑之间，众选手各展所长，以友谊精神和傲人成绩为论坛高调开局，彰显出潮风正平、合纵联横的市场新风向。&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;', 3111, 1, 100, 1533811619, 1533372833);
INSERT INTO `tp_news` VALUES (6, 1, 1, '南方都市报', '个税起征点将扣除房贷利息', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '个税起征点将扣除房贷利息，帮房奴算笔账：以后能多下几次馆子了', '&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;南都报道。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;6月19日，新的个人所得税法修正案草案提交全国人大常委会第三次会议审议，明确工资、薪金所得的基本减除费用标准(即俗称的“个税起征点”)从3500元每月上调至5000元每月，并扩大了税前专项扣除的范围：在目前“五险一金”等项目的基础上，增加了子女教育支出、继续教育支出、大病医疗支出、住房贷款利息和住房租金等。 这是继2011年将个税起征点从2000元上调至3500元后的再一次调整。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;若本次修正案通过全国人大审议并正式实施，每个人的工资单都将发生变化。对于广州人来说，这个调整会带来多大影响？南都记者走访了广州街坊。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;备注：以上换算根据现行个税税率和新版税率计算，仅扣除“五险一金”等项目。涉及的社保公积金个人缴纳比例设定为：养老保险8%、医保2%、失业保险1%、公积金12%，生育保险和工伤保险全由单位负担，个人无需缴纳。实际换算以税务部门解释为准。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;焦点1\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;减税算不算多？\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;多个行业工薪阶层迈入个税“0负担”一族\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;这次调整中，个税起征点从3500元每月上调至5000元每月，总体上每人缴纳的个税都会有所降低。对于广州人来说，这还意味着相当一部分中低收入人群从需要缴个税变成了不需再缴个税，因为广州去年的城镇私营单位员工的月平均收入是5103元，超出5000元起征点100余元。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;具体降低多少？南都记者计算了广州平均工资水平的减税情况。按广州市统计局公布的数据，2017年广州市城镇非私营单位就业人员年平均工资97522元，城镇私营单位就业人员年平均工资为61241元。换算下来，非私营的月平均工资8127元，私营的月平均工资是5103元，均为税前工资。据此计算，对于工资处于平均线8127元的广州城镇非私营单位员工来说，每年应交的个税为450元左右，比起现行起征点，每年可以减税1596元，平均到每个月是减税133元。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;对于工资处于平均线5103元的城镇私营单位员工来说，变化更直接，每年应交的个税为0，而此前他们每年还要交154.6元的个税。 实际上，上述平均工资都是税前工资，扣除社保公积金等之后，收入平均线的非私营员工拿到手的工资约为六七千元，调整后，他们将可以多拿到130多元的收入。用网友的话来说，“可以多吃一次大餐了”。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;对哪个行业影响大？根据南方人才市场等单位联合发布的2017-2018年广东地区薪酬调查报告，住宿和餐饮业的平均月薪是4838元，个税起征点调整后，这个行业的大部分员工将变为个税“0负担”一族，而居民服务、修理和其他服务业的平均月薪是5576元，这些行业的相当一部分员工也将跨入个税“0负担”一族。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;焦点2\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;扣减项能减多少税？\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;若扣减房贷利息，每月能多下几次馆子了\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;本次个税调整的另一大亮点是税前专项扣除范围的扩大，在目前“五险一金”等项目的基础上，增加了子女教育支出、继续教育支出、大病医疗支出、住房贷款利息和住房租金等。 其中，住房贷款利息一项尤其引人关注。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;市民王小姐看到新闻后第一反应是“房贷也扣除？那我就不用交个税了！”被人提醒是扣除房贷利息而不是房贷后，她算了算，发现也能减不少税。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;王小姐每月税前工资是1.4万元，到手1万出头，现在每月交个税是1000元左右，起征点调整后能少交500多元。她结婚时在番禺买了房，用等额本息方式贷了款，每月还房贷8000多元，其中6000多都是利息，若扣减了贷款利息和五险一金后，算下来只用交30多元的个税，相当于总共减免了近1000元的税负。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;“真的能实施吗？什么时候？怎么执行？”算完后，王小姐非常欢喜，“现在房贷压得人不敢买东西，消费能力不能跟买房之前比，若真这么扣减的话，每个月可以多下几次馆子了！”\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;焦点3\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;对企业有帮助吗？\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;减了个税也相当于给企业减轻了负担\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;个税调整也不光是个人收入的调整，广州荔湾一家企业老板邓先生认为，这次调整对于科技企业留住人才、节省人力成本也有帮助。 “对于我们这种科技企业，这是一个很好的消息，因为我们的产品成本没那么高，但劳动力成本较高”，邓先生说，员工一般只看实收部分，个税某种程度上是由企业承担的，减了税也相当于给企业减轻了负担。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;邓先生说，行业里现在竞争特别激烈，常有同行来“挖墙脚”，但企业要发展又必须留住人才，只能涨工资，调整后确实可以减轻企业负担、提高科研人员积极性。 “是大好事，是非常好的政策，有明显的帮助”，广州一家互联网企业负责人赖先生说，他们公司待遇在行业里算中上，这次起征点调整后，“按照我们员工的平均收入水平，大家拿到手会增加1000到2000元左右，对个人生活会有直接的帮助”，另外还有专项扣除，对于有子女、房贷压力的同事的帮助会更进一步。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;焦点4\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;教育支出扣减包含高等教育吗？\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;希望继续增加人性化的扣减项目\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;市民陈女士觉得，对于上有老下有小的中年人来说，这次调整增加子女教育、大病医疗的扣减项非常贴心，但具体怎样扣减是他们更关心的，“义务教育是免费的，扣减能包含高等教育吗？大病医疗是不是指本人的，会不会包含直系亲属的？比如老人生病？”\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;在很多网友看来，税前5000元的个税起征点对一线大城市来说还是较低，“在北京挣5000元的人要么是刚毕业的大学生，要么是城市的弱势群体，你征他们的税干嘛？让年轻人毕业工作几年，收入达到八千到一万元再征税更合适”，网友@王利芬的微博获得了25000多个赞。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;市民江女士希望在将来的修订中继续增加人性化的扣减项目，减轻工薪族的负担。比如，香港个税的扣除项和免税项很多，今年有部分还增加了免税额度，比如抚养子女免税项，  今年从10万元提高到了12万元，供养60岁或以上父母或祖父母的，非长住的免税额是5万元，长住的免税额是10万元，伤残人士免税额也从6.6万提升到了7.5万元。\r\n&lt;/p&gt;\r\n&lt;p class=&quot;one-p&quot;&gt;\r\n	&amp;emsp;&amp;emsp;采写：南都记者 李文 制图：张许君\r\n&lt;/p&gt;', 426, 1, 0, 1529496000, 1527837290);
INSERT INTO `tp_news` VALUES (7, 1, 1, '米宅', '龙岗将再建60所“百合”系学校 今年预计四所投入使用', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '龙岗将再建60所“百合”系学校 今年预计四所投入使用', '&lt;p&gt;龙岗区2018年上半年备受市民关注的民生事业捷报频传，下半年，龙岗区还将加快深外（龙岗）国际部小区、平湖中学等7所新改扩建项目建设，全年新增公办中小学学位1.5万个以上，启动第一批13所公办幼儿园建设。随着新校的正式投入使用，将极大缓解龙岗片区学位紧张的状况。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 10px 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; line-height: 25px; vertical-align: baseline; font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;龙岗区2018年上半年备受市民关注的民生事业捷报频传，华中师范大学附属龙园学校等7所新改扩建学校顺利推进；龙岗区中医院挂牌“三甲”；文化地标“红立方”开馆；深圳书城龙岗城开业；10年断头路稼先东路顺利通车，红棉路、沙荷路打通进展顺利，国庆前将全线贯通；轨道10号线顺利推进，14、16号线开工建设。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 10px 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; line-height: 25px; vertical-align: baseline; font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;此外，下半年，龙岗区还将加快深外（龙岗）国际部小区、平湖中学等7所新改扩建项目建设，全年新增公办中小学学位1.5万个以上，启动第一批13所公办幼儿园建设；持续提高医疗卫生服务水平，积极推进市吉华医院、市平湖医院建设等，持续织密扎牢社会保障网，全面推进社会老年人日间综合服务中心建设，确保年内每个街道新增养老床位40张以上。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 10px 0px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; line-height: 25px; vertical-align: baseline; font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255); text-align: center;&quot;&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180731/1533023012138708.jpg&quot; title=&quot;1533023012138708.jpg&quot; alt=&quot;148616743.jpg&quot;/&gt;&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 10px 0px 20px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; line-height: 25px; vertical-align: baseline; font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;据了解，目前“百合”系学校已涵盖春蕾幼儿园、春蕾小学、百合外国语等从小学到初中阶段的学校。此前，该学校主要负责人表示，计划投资数十亿元，再建60所“百合”系学校，成立一个庞大的教育集团。2018年预计有四所全新的“百合”系学校投入使用，包括两所幼儿园和两所小学，在龙岗区的吉华街道、南湾街道和坂田街道，都有“百合”系学校在筹建当中。&lt;/p&gt;&lt;p style=&quot;margin-top: 0px; margin-bottom: 0px; padding: 10px 0px 20px; border: 0px; font-variant-numeric: inherit; font-variant-east-asian: inherit; font-stretch: inherit; line-height: 25px; vertical-align: baseline; font-family: 微软雅黑; white-space: normal; background-color: rgb(255, 255, 255);&quot;&gt;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;龙岗基础教育的国际化程度也在不断提升。“十三五”期间龙岗区规划新建3—5所国际（化）学校；龙岗片区的2所高端国际化民办学校已于2016年正式开办；坂田片区的深圳外国语学校（龙岗）国际部的过渡校区已于2017年9月开学。随着新校的正式投入使用，将极大缓解龙岗片区学位紧张的状况。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 1151, 1, 100, 1529510400, 1533023014);
INSERT INTO `tp_news` VALUES (9, 1, 2, '南方都市报', '深圳人800万港币买深高会员卡获“赠别墅” 办产权成 了难题', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '深圳人800万港币买深高会员卡获“赠别墅” 办产权成\r\n了难题', '&lt;p&gt;&lt;span style=&quot;color: rgb(34, 34, 34); font-family: &amp;quot;PingFang SC&amp;quot;, Helvetica, Arial, &amp;quot;\\\\5FAE软雅黑&amp;quot;, &amp;quot;\\\\9ED1体&amp;quot;; font-size: 20.1157px; text-align: justify; background-color: rgb(255, 255, 255);&quot;&gt;回顾：深圳高尔夫俱乐部1.4平方公里用地早于3年前就到期，至今却未能收归国有。这块地上，除了球场，还有约70栋别墅，据规土部门介绍均未取得房产证明。南都7月12-13日连续报道有关部门的收地进展，深圳高尔夫球场别墅区的住户坐不住了。&lt;/span&gt;&lt;/p&gt;&lt;p style=&quot;text-align: center;&quot;&gt;&lt;img src=&quot;/ueditor/php/upload/image/20180731/1533022653135421.jpg&quot; title=&quot;1533022653135421.jpg&quot; alt=&quot;641 (1).jpg&quot;/&gt;&lt;/p&gt;&lt;p&gt;俯瞰深圳高尔夫俱乐部别墅区。南都记者 赵炎雄 摄&lt;/p&gt;&lt;p&gt;近日，深高别墅区住户向南都反映，20多年前他们花了800万-1000万港元买了别墅，十多年来一直为办合法产权而奔波，按政府文件，他们有条件申请办理的。目前，住户们已向法院提起诉讼，希望通过法律途径拿到房产证和土地证。对此，深高清算组人士称，文件是否适用还有待司法裁决。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 4534, 1, 100, 1529562060, 1533022695);
INSERT INTO `tp_news` VALUES (10, 1, 2, '广州日报', '广州公积金租房 每月最高可提6574元！', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '广州公积金租房 每月最高可提6574元！', '&lt;p&gt;7月25日，广州出台公积金新政，对提取支付房租、限制异地购房等方面做出了规定。日前，广州市住房公积金管理中心针对新政中市民较为关心的问题进行了解读。&lt;/p&gt;&lt;p&gt;目前，广州已暂停异地购房公积金提取。但如果异地购房者已经在25日之前办理住房公积金提取手续，仍可以继续提取。而用公积金租房，每人每月最高可以提取6574元。&lt;/p&gt;&lt;p&gt;&lt;span class=&quot;_3J3iNSz16QO03_VBd8XTFg&quot; style=&quot;margin: 0px; padding: 0px; -webkit-tap-highlight-color: transparent; font-weight: 700;&quot;&gt;▌在户籍所在地购房，不属于“异地购房”&lt;/span&gt;&lt;/p&gt;&lt;p&gt;广州市“公积金新政”发布之后，引起市民的极大关注，有些市民认为，如果自己在广州缴存住房公积金，那么在是不是在其他城市购房，就属于“异地购房”？&lt;/p&gt;&lt;p&gt;需要指出的是，“公积金新政”发布，并不意味着，职工在广州以外的其他城市购房都不能提取住房公积金，只是停止了缴存人本人及配偶在非户籍地购房的提取，若户籍仍在老家，回老家买房不受影响，不属于“异地购房”，仍然可以提取。&lt;/p&gt;&lt;p&gt;李先生是东莞人，在广州缴存住房公积金已经有10年有余，他的妻子则是佛山户籍。根据“公积金新政”，两人在佛山购房，属于在配偶的户籍所在地购房，并不属于异地购房，仍可以提取住房公积金购房。&lt;/p&gt;&lt;p&gt;但是需要指出的是如果，李先生夫妇在广州、东莞、佛山之外的城市购房，就属于“异地购房”，按规定，不能提取住房公积金。&lt;/p&gt;&lt;p&gt;&lt;span class=&quot;_3J3iNSz16QO03_VBd8XTFg&quot; style=&quot;margin: 0px; padding: 0px; -webkit-tap-highlight-color: transparent; font-weight: 700;&quot;&gt;▌已办结异地购房手续的可继续提取&lt;/span&gt;&lt;/p&gt;&lt;p&gt;也有市民询问，之前已经办理了异地购房提取公积金的手续，也提取了住房公积金用于异地购房，“公积金新政”出台后，会不会影响自己的住房公积金提取。&lt;/p&gt;&lt;p&gt;记者从广州住房公积金管理中心了解到，根据政策，已经成功提取过的或已经向广州住房公积金管理中心提交了异地购房提取公积金申请的，按原政策执行，提取住房公积金不受影响，可以继续每半年提取一次。&lt;/p&gt;&lt;p&gt;&lt;span class=&quot;_3J3iNSz16QO03_VBd8XTFg&quot; style=&quot;margin: 0px; padding: 0px; -webkit-tap-highlight-color: transparent; font-weight: 700;&quot;&gt;▌每月可最高提取6574元用于租房&lt;/span&gt;&lt;/p&gt;&lt;p&gt;还有不少市民问：缴存人没有买房，离职又不能提取，那离职后原先缴存的住房公积金是不是就白交了？&lt;/p&gt;&lt;p&gt;据记者了解，住房公积金并不只有买房时才能提取，有多种途径都可以提取住房公积金。缴存人可以在广州申请租房提取，无需租房证明都可以提取600元/人/月，每半年可提取一次，还可以办理自动转账，手续很简便。&lt;/p&gt;&lt;p&gt;此外，下岗、失业的，出境定居的，在缴存人户籍地、配偶户籍地购房的，离休退休的等等，都可以提取。&lt;/p&gt;&lt;p&gt;至于离职职工，需先封存住房公积金缴存账户。如果离开广州，在外地重新就业的，可以在新就业地开户缴存满半年后，办理账户转移，将广州市缴存的住房公积金转移过去，符合当地提取政策的，可以提取。&lt;/p&gt;&lt;p&gt;若缴存人离职后仍在广州市居住，且本人及配偶、未成年子女在我市都没有自有产权住房，可以提取600元/人/月用于交房租，或者提供租房备案证明及发票提取，最高可提取6574元/人/月，每半年可提取一次。&lt;/p&gt;&lt;p&gt;文：广州日报全媒体记者 贾政&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 471, 1, 100, 1529576531, 1532763626);
INSERT INTO `tp_news` VALUES (18, 1, 1, '大粤房产', '深圳男子收到破旧老房的新租金单时傻眼，租金上涨 两成！', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '深圳男子收到破旧老房的新租金单时傻眼，租金上涨\r\n两成！', '&lt;p&gt;市民赵先生在&lt;/p&gt;&lt;p&gt;四年前赵先生租了一套一室一厅的房子，每月租金是2000元，一年后月租金上涨到2200元，接下来的两年，租金的涨幅维持在一两百元以内。赵先生认为，租金年年涨是可以理解的，但是像今年这样的猛涨，赵先生就觉得有些不合理了。&lt;/p&gt;&lt;p&gt;赵先生：我这房子从来的时候就一直是比较旧，有一些门还是我自己修的，当时住的时候破破烂烂的，有些地方渗水。我就觉得不对劲，觉得接受不了，原来涨过也没涨得那么狠。&lt;/p&gt;&lt;p&gt;赵先生介绍，红梅苑小区的房子是由一家资产管理公司负责租赁，得知房租大涨的时候，他也曾经找过该公司，但该公司的相关负责人表示，上涨后的价格对赵先生这样的老租户已经是很照顾了。&lt;/p&gt;&lt;p&gt;相关负责人：我们对外宣称都是3200元的，对老租户还是便宜了200块钱的。&lt;/p&gt;&lt;p&gt;这位工作人员表示，租金的浮动是根据市场来调整的，&lt;span class=&quot;_3J3iNSz16QO03_VBd8XTFg&quot; style=&quot;margin: 0px; padding: 0px; -webkit-tap-highlight-color: transparent; font-weight: 700;&quot;&gt;租户只有两个选择，要么接受新的价格继续签约，要么就另寻住所。&lt;/span&gt;&lt;/p&gt;&lt;p&gt;相关负责人：我们不是公益机构，我们是政府机构公益单位。&lt;/p&gt;&lt;p&gt;来源：深圳电视台财经生活频道&lt;/p&gt;&lt;p&gt;本文来自腾讯新闻客户端自媒体，不代表腾讯新闻的观点和立场&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 20, 1, 100, 1532768967, 1533022551);
INSERT INTO `tp_news` VALUES (19, 1, 2, '腾讯新闻', '龙华新建10所公办学校 预计新增学位11160个', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '龙华新建10所公办学校 预计新增学位11160个', '&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;据悉，龙华区新建10所义务教育阶段公办学校，预计新增公办学位11160个。龙华区政府为加快学校规划建设，保障群众对优质教育的需求，到2020年，龙华将新改扩建26所学校，增加公办学位44300个。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-weight: bolder;&quot;&gt;龙华预计新增公办学位&lt;/span&gt;&lt;span style=&quot;font-weight: bolder;&quot;&gt;11160个&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;龙华区政府为加快学校规划建设，保障群众对优质教育的需求，在2018年到2020年，将新改扩建26所学校，增加学位44300个。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;据悉，今年龙华区新建10所义务教育阶段学校，包括深圳外国语学校龙华校区、华南实验学校、第二实验学校、龙华高级中学（高中）、教科院附属实验学校、清泉外国语小学、鹭湖外国语小学、第三实验学校、万科双语学校、曼彻斯通城堡学校，预计新增公办学位11160个。这10所新校目前基本都已完成招生工作。区教育局相关负责人表示，通过集团化发展，确保从资源调配、课程设置都能形成体系、统筹考虑，最终实现教育的优质均衡，逐渐保证教育公平。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-weight: bolder;&quot;&gt;深外龙华校区划分为“共享学区”&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;据龙华教育局表示，此次发布的学区划分坚持以“均衡教育资源、距离相对就近、主干道路为主”原则进行，录取原则按“先类别后积分”的原则进行，保障教育公平。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;另外，玉龙学校和深圳外国语学校龙华校区两采用两校“共享学区”方式进行招生。即两所学校共用同一个学区，“共享学区”包括平南铁路以南、梅龙路以西、玉龙路以北、新区大道以西、白龙路以北、金龙路以西的范围。深外龙华校区初中部与玉龙学校初中部共享学区，包括平南铁路以南、梅龙路以西、民乐路以南、梅观高速以西的范围。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 28, 1, 100, 1532768972, 1533022313);
INSERT INTO `tp_news` VALUES (17, 1, 1, '腾讯新闻', '深圳东部海岸将崛起海景文体中心', 'Uploads/room/list/2018-08-15/192035FrbdwPZsiIYhwsTQi_1OsyLL_TRD.jpg', '深圳东部海岸将崛起海景文体中心 “坝光之眼”10月开建', '&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;据大鹏新区建筑工务局表示，经过半年多设计优化，总投资预算约为9亿元的坝光文体中心将在10月开建，预计2020年8月建成。两年后，与前海东西呼应的深圳未来新增长极——国际生物谷坝光启动区将崛起海景文体中心“坝光之眼”。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-weight: bolder;&quot;&gt;深圳东部海岸将建设海景文体中心&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;据了解，面积31.9平方公里的坝光片区是深圳最大成片可开发区域，也是深圳生态环境保存最为完好的区域之一。三面靠山、一面临海，相当于2个前海或3个深圳高新产业园区。目前，深圳国际生物谷坝光居住区文化中心及体育中心项目规划效果已公开展出。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;深圳国际生物谷位于大鹏半岛坝光湾区。水廊密布，生态条件优越。而坝光文体中心选址就在坝光片区海心路以东，位于坝光片区中心区域，分为文化中心、中心公园和体育中心三部分。其中，文化中心用地面积22329平方米，体育中心用地面积13712平方米，规划容积率均为1.2。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;未来，这里将崛起一座具有国际竞争力的滨海生态科学小城。建成后的坝光居住区文化中心及体育中心，或将是深圳离海最近的文体中心。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;&lt;span style=&quot;font-weight: bolder;&quot;&gt;东部沿海大鹏半岛坝光片区即将崛起&lt;/span&gt;&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;据悉，2013年11月，深圳决定在东部滨海大鹏、坪山和盐田地区打造深圳国际生物谷，并以坝光为启动区，形成“西有前海、东有坝光”的双引擎驱动发展格局。2016年1月，坝光正式进入实质性、规模化建设阶段。&lt;/p&gt;&lt;p class=&quot;one-p&quot; style=&quot;margin-top: 0px; margin-bottom: 2em; padding: 0px; line-height: 2.2; word-break: break-all; font-family: &amp;quot;Microsoft Yahei&amp;quot;, Avenir, &amp;quot;Segoe UI&amp;quot;, &amp;quot;Hiragino Sans GB&amp;quot;, STHeiti, &amp;quot;Microsoft Sans Serif&amp;quot;, &amp;quot;WenQuanYi Micro Hei&amp;quot;, sans-serif; font-size: 18px; white-space: normal;&quot;&gt;除此之外，大鹏新区还进一步完善交通基础设施建设，目前正推进葵涌环城东路规划建设、坪西路改造，加快葵涌、大鹏和新大三级旅游集散中心建设，推动形成互联互通的内部路网与景区联络路网协调发展的格局。未来5至10年，大鹏新区将形成海陆空蓝绿立体交通体系，有力支撑高端生物产业和旅游产业的发展。&lt;/p&gt;&lt;p&gt;&lt;br/&gt;&lt;/p&gt;', 12, 1, 100, 1532768720, 1532768811);
INSERT INTO `tp_news` VALUES (22, 1, 0, 'xxxxxxxxxx', 'x\'x\'x\'xxxxx', 'images/article/20180829\\c84cacf060112aab550a85bdc682a145.jpg', 'xxxxx', '<p>xxxxxxx<br/></p>', 0, 2, 98, 1535527778, 1535527866);

-- ----------------------------
-- Table structure for tp_pro_auth
-- ----------------------------
DROP TABLE IF EXISTS `tp_pro_auth`;
CREATE TABLE `tp_pro_auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `img` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `create_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目审核表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tp_pro_delegate
-- ----------------------------
DROP TABLE IF EXISTS `tp_pro_delegate`;
CREATE TABLE `tp_pro_delegate`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户类型',
  `pid` int(11) NOT NULL COMMENT '项目id',
  `last_time` datetime NULL DEFAULT NULL COMMENT '最后操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uid`(`uid`, `pid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tp_pro_delegate
-- ----------------------------
INSERT INTO `tp_pro_delegate` VALUES (3, 25, 'pro', 6, '2018-10-16 10:43:19');
INSERT INTO `tp_pro_delegate` VALUES (4, 27, 'city', 6, '2018-10-16 10:43:19');

-- ----------------------------
-- Table structure for tp_pro_flow
-- ----------------------------
DROP TABLE IF EXISTS `tp_pro_flow`;
CREATE TABLE `tp_pro_flow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `opt_id` int(11) NOT NULL,
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `create_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `opt_id`(`opt_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_pro_flow
-- ----------------------------
INSERT INTO `tp_pro_flow` VALUES (2, 6, 25, '项目指派:项目经理', NULL, '2018-10-16 10:43:19');
INSERT INTO `tp_pro_flow` VALUES (3, 6, 25, '项目指派:城市经理', NULL, '2018-10-16 10:43:19');
INSERT INTO `tp_pro_flow` VALUES (4, 6, 25, '项目任务人员分配', NULL, '2018-10-16 10:57:28');
INSERT INTO `tp_pro_flow` VALUES (5, 6, 25, '项目任务人员分配', NULL, '2018-10-16 10:58:19');
INSERT INTO `tp_pro_flow` VALUES (6, 6, 25, '项目任务人员分配', NULL, '2018-10-16 10:58:43');

-- ----------------------------
-- Table structure for tp_pro_work
-- ----------------------------
DROP TABLE IF EXISTS `tp_pro_work`;
CREATE TABLE `tp_pro_work`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT NULL COMMENT '对应项目',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目-工作内容',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目-工作内容' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_pro_work
-- ----------------------------
INSERT INTO `tp_pro_work` VALUES (1, 1, '搬桌子');
INSERT INTO `tp_pro_work` VALUES (2, 1, '拆空调');
INSERT INTO `tp_pro_work` VALUES (3, 1, '清理');
INSERT INTO `tp_pro_work` VALUES (4, 6, '楼道');
INSERT INTO `tp_pro_work` VALUES (5, 6, '卧室');
INSERT INTO `tp_pro_work` VALUES (6, 6, '客厅');

-- ----------------------------
-- Table structure for tp_pro_worker
-- ----------------------------
DROP TABLE IF EXISTS `tp_pro_worker`;
CREATE TABLE `tp_pro_worker`  (
  `pid` int(11) NOT NULL COMMENT '项目id',
  `wid` int(11) NOT NULL COMMENT '任务id',
  `uid` int(11) NOT NULL COMMENT '人员id',
  UNIQUE INDEX `pid`(`pid`, `wid`, `uid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '项目人员分配' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_pro_worker
-- ----------------------------
INSERT INTO `tp_pro_worker` VALUES (6, 4, 25);
INSERT INTO `tp_pro_worker` VALUES (6, 4, 26);
INSERT INTO `tp_pro_worker` VALUES (6, 4, 27);
INSERT INTO `tp_pro_worker` VALUES (6, 5, 26);
INSERT INTO `tp_pro_worker` VALUES (6, 5, 27);
INSERT INTO `tp_pro_worker` VALUES (6, 6, 26);
INSERT INTO `tp_pro_worker` VALUES (6, 6, 27);

-- ----------------------------
-- Table structure for tp_project
-- ----------------------------
DROP TABLE IF EXISTS `tp_project`;
CREATE TABLE `tp_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `team_no` int(11) NULL DEFAULT NULL COMMENT '团队项目编号',
  `no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '编号',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `area` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目标题',
  `number` smallint(6) NULL DEFAULT 0 COMMENT '项目人数',
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '项目介绍',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `gold` decimal(10, 2) NULL DEFAULT NULL COMMENT '项目金',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '项目地址',
  `coordinate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '坐标 纬度,经度',
  `sort` tinyint(4) NULL DEFAULT 100 COMMENT '排序',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1正常 2禁用  3开始 4完成',
  `is_auth` tinyint(4) NULL DEFAULT 0 COMMENT '1待审核 2通过审核 3被拒',
  `submit_auth_time` int(11) NULL DEFAULT NULL COMMENT '提交时间',
  `auth_time` int(11) NULL DEFAULT NULL COMMENT '审核时间',
  `opt_id` int(11) NOT NULL COMMENT '操作人',
  `act_time` int(11) NULL DEFAULT NULL COMMENT '开始时间',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  `complete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tp_project
-- ----------------------------
INSERT INTO `tp_project` VALUES (1, 0, '20181015180133000002', '000002;广东省', '000011;深圳市', NULL, '福田车公庙-公司装修', 10, '1.完善自己的工作\r\n2.东西挪动到货车上\r\n3.完成后各自休息', '请谨慎处理，速度要快，姿势要帅', 888.00, '福田车公庙云松大厦10c-2', '22.53557,114.028704', 100, 1, 0, NULL, NULL, 1, NULL, 1539597693, 1539598130, NULL, NULL);
INSERT INTO `tp_project` VALUES (6, 4, '20181016104319000006', '000002;广东省', '000011;深圳市', NULL, '公寓清理', 3, '公寓清理\r\n1.速战速决', '各种备注', 888.00, '南山市场', '22.531409,113.925683', 100, 3, 0, NULL, NULL, 25, 1539658648, 1539657799, 1539658648, NULL, NULL);

-- ----------------------------
-- Table structure for tp_sys_cache
-- ----------------------------
DROP TABLE IF EXISTS `tp_sys_cache`;
CREATE TABLE `tp_sys_cache`  (
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  UNIQUE INDEX `type`(`type`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tp_sys_cache
-- ----------------------------
INSERT INTO `tp_sys_cache` VALUES ('proFlow', '<p style=\"text-align: center;\"><strong>项目流程</strong></p>');
INSERT INTO `tp_sys_cache` VALUES ('proSecurity', '<p style=\"text-align: center;\"><strong>安全措施</strong><br/></p>');
INSERT INTO `tp_sys_cache` VALUES ('proCheck', '<p style=\"text-align: center;\"><strong>QC检查</strong></p>');
INSERT INTO `tp_sys_cache` VALUES ('proMaintain', '<p style=\"text-align: center;\"><strong>设备维护</strong></p>');

-- ----------------------------
-- Table structure for tp_sys_location
-- ----------------------------
DROP TABLE IF EXISTS `tp_sys_location`;
CREATE TABLE `tp_sys_location`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NULL DEFAULT 0,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sort` tinyint(4) NULL DEFAULT 100,
  `status` tinyint(4) NULL DEFAULT 1,
  `last_time` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_sys_location
-- ----------------------------
INSERT INTO `tp_sys_location` VALUES (2, 0, '广东省', 1, 1, 1536723548, NULL);
INSERT INTO `tp_sys_location` VALUES (4, 0, 'xxxxx', 100, 1, 1536725063, 1536725063);
INSERT INTO `tp_sys_location` VALUES (5, 0, 'xxxxx', 100, 1, 1536725066, 1536725066);
INSERT INTO `tp_sys_location` VALUES (6, 0, 'xxxxx', 100, 1, 1536725070, 1536725070);
INSERT INTO `tp_sys_location` VALUES (7, 0, 'xxxxx', 100, 1, 1536725083, 1536725083);
INSERT INTO `tp_sys_location` VALUES (8, 0, 'xxxxx', 100, 1, 1536725085, 1536725085);
INSERT INTO `tp_sys_location` VALUES (9, 0, 'xxxxx', 100, 1, 1536725087, 1536725087);
INSERT INTO `tp_sys_location` VALUES (10, 2, '广州市', 1, 1, 1536725332, NULL);
INSERT INTO `tp_sys_location` VALUES (11, 2, '深圳市', 2, 1, 1536725356, NULL);
INSERT INTO `tp_sys_location` VALUES (12, 0, '福建', 1, 1, 1536728780, NULL);
INSERT INTO `tp_sys_location` VALUES (13, 12, '福州市', 1, 1, 1536728795, NULL);
INSERT INTO `tp_sys_location` VALUES (14, 12, '厦门市', 2, 1, 1536728802, NULL);

-- ----------------------------
-- Table structure for tp_user_award
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_award`;
CREATE TABLE `tp_user_award`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'project 项目奖励',
  `relation_id` int(11) NOT NULL COMMENT '关联主键id',
  `uid` int(11) NOT NULL,
  `gold` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '奖励金额',
  `param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '附加参数',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '1发放',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  `send_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tp_user_gold_log
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_gold_log`;
CREATE TABLE `tp_user_gold_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `gold_before` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '变动前金',
  `gold` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '变动金',
  `gold_after` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '变动后金额',
  `param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '附加数据',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '最后操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tp_user_notice
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_notice`;
CREATE TABLE `tp_user_notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '通知类型',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `intro` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简介',
  `param` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '跳转参数 json',
  `create_time` int(11) NULL DEFAULT NULL,
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1创建',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户通知表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_user_notice
-- ----------------------------
INSERT INTO `tp_user_notice` VALUES (1, 1, 'project', '福田车公庙-公司装修', '项目指派:城市经理', '{\"id\":\"1\"}', 1539598130, 1);
INSERT INTO `tp_user_notice` VALUES (2, 25, 'project', '公寓清理', '项目指派:项目经理', '{\"id\":\"6\"}', 1539657799, 1);
INSERT INTO `tp_user_notice` VALUES (3, 27, 'project', '公寓清理', '项目指派:城市经理', '{\"id\":\"6\"}', 1539657799, 1);

-- ----------------------------
-- Table structure for tp_user_req
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_req`;
CREATE TABLE `tp_user_req`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户id',
  `team_no` int(11) NULL DEFAULT 0 COMMENT '加入团队编号',
  `team_slice_no` int(11) NULL DEFAULT 0 COMMENT '加入团队组编号',
  `req_uid` int(11) NOT NULL COMMENT '邀请者id',
  `status` tinyint(4) NULL DEFAULT 0 COMMENT '处理状态 0未处理 1通过 2拒绝',
  `req_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请理由',
  `opt_uid` int(11) NULL DEFAULT 0 COMMENT '处理人用户id',
  `handle_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '处理理由',
  `handle_time` int(11) NULL DEFAULT NULL COMMENT '处理日期',
  `last_time` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户邀请成为合作伙伴记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tp_user_req_money
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_req_money`;
CREATE TABLE `tp_user_req_money`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `uid` int(11) NULL DEFAULT NULL,
  `money` decimal(10, 2) NULL DEFAULT 0.00,
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '1创建 2通过 3拒绝',
  `create_time` int(11) NULL DEFAULT NULL,
  `opt_id` int(11) NULL DEFAULT 0,
  `auth_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户提现' ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for tp_user_team
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_team`;
CREATE TABLE `tp_user_team`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NULL DEFAULT NULL COMMENT '团队管理者id',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '停用时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户团队' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_user_team
-- ----------------------------
INSERT INTO `tp_user_team` VALUES (1, 1, 1539598383, NULL);
INSERT INTO `tp_user_team` VALUES (2, 13, 1539600241, NULL);
INSERT INTO `tp_user_team` VALUES (3, 16, 1539654788, NULL);
INSERT INTO `tp_user_team` VALUES (4, 27, 1539654800, NULL);

-- ----------------------------
-- Table structure for tp_user_type
-- ----------------------------
DROP TABLE IF EXISTS `tp_user_type`;
CREATE TABLE `tp_user_type`  (
  `id` tinyint(11) NOT NULL AUTO_INCREMENT,
  `pid` tinyint(11) NULL DEFAULT 0,
  `en` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '别名',
  `is_login_admin` tinyint(4) NULL DEFAULT 0,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户类型' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_user_type
-- ----------------------------
INSERT INTO `tp_user_type` VALUES (1, 0, 'city', 1, '城市经理');
INSERT INTO `tp_user_type` VALUES (2, 0, 'pro', 1, '项目经理');
INSERT INTO `tp_user_type` VALUES (3, 0, NULL, 0, '工种');
INSERT INTO `tp_user_type` VALUES (4, 3, 'staff', 0, '搬运');
INSERT INTO `tp_user_type` VALUES (5, 3, 'staff', 0, '运输');
INSERT INTO `tp_user_type` VALUES (6, 3, 'staff', 0, '安装');

-- ----------------------------
-- Table structure for tp_users
-- ----------------------------
DROP TABLE IF EXISTS `tp_users`;
CREATE TABLE `tp_users`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `team_no` int(11) NULL DEFAULT 0 COMMENT '团队编号',
  `team_slice_no` int(11) NULL DEFAULT 0 COMMENT '团队组编号',
  `tid` int(10) NOT NULL DEFAULT 0 COMMENT '用户类型',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '账户类型',
  `province` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `area` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `gold` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '金',
  `history_gold` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '历史金',
  `cellphone` bigint(11) NULL DEFAULT NULL COMMENT '手机号码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '昵称',
  `sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '个性签名',
  `password` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盐',
  `sex` tinyint(4) NULL DEFAULT 0 COMMENT '性别：1男 2女',
  `header` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '头像',
  `money` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '我的余额',
  `req_id` int(11) NULL DEFAULT 0 COMMENT '邀请人id',
  `wechat_openid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信OPENID',
  `wechat_token` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '微信登录token',
  `wechat_refresh_token` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wechat_update_time` int(11) NULL DEFAULT NULL,
  `card_photo` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_card` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证',
  `bank_card` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '银行卡',
  `bank_location` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '开户行',
  `complete_pro_num` int(11) NULL DEFAULT 0,
  `status` tinyint(4) NULL DEFAULT 1,
  `is_auth` tinyint(4) NULL DEFAULT 0 COMMENT '审核状态 1通过审核',
  `auth_time` int(11) NULL DEFAULT NULL COMMENT '审核时间',
  `create_time` int(11) NULL DEFAULT NULL,
  `update_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cellphone`(`cellphone`) USING BTREE,
  UNIQUE INDEX `wechat_openid`(`wechat_openid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户信息表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of tp_users
-- ----------------------------
INSERT INTO `tp_users` VALUES (1, 0, 0, 0, 'manage', NULL, NULL, NULL, 0.00, 0.00, 180, NULL, '管理员', NULL, 'a55117d89ae51c267bc75df788e82005', '82836', 0, NULL, 0.00, 0, NULL, NULL, NULL, NULL, NULL, 'admin', NULL, NULL, NULL, 0, 1, 1, 1537940259, 1537940259, 1539598383);
INSERT INTO `tp_users` VALUES (13, 2, 0, 1, 'city', '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783601, '', 'a蒜', NULL, NULL, NULL, 0, 'http://thirdwx.qlogo.cn/mmopen/vi_32/0GRhYdVibScj1VLO1eH5nfTia8KmAxzermMvhV8XuASURojZnW2nm3elSUnYyuLqWmQSlzNep6hfanlCVuA0USsQ/132', 0.00, 1, NULL, '14_J3bgblhBwNLi_Qx6NHVqRgfWOnBkjLXKL9pIO0QUxV3ruRWPgIQf4tk2BRZXfD32JV__Ylwuv2EEyr7MY0B5ag', '14_4pY3svb4nm4RunU5En-w2CLoKe4KKjySB_RPt2EoQ9hqDTFxYPrcgFsimgPzGOzVh4bhGzfTixkoAlhYygr1EQ', 1539173387, NULL, '烨华', '234234234', '123123123213', '浦发', 0, 1, 1, 1537940259, 1539166187, 1539600241);
INSERT INTO `tp_users` VALUES (14, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783603, NULL, 'a蒜', NULL, NULL, NULL, 0, 'http://thirdwx.qlogo.cn/mmopen/vi_32/0GRhYdVibScj1VLO1eH5nfTia8KmAxzermMvhV8XuASURojZnW2nm3elSUnYyuLqWmQSlzNep6hfanlCVuA0USsQ/132', 0.00, 1, 'ouDeCjs_kUYb6E6eY8WDGMsQ-b3U', '14_0iuPkWJN7IwgSZ3esANVlwarWpnLptmzhqDqBDTZMlZ2mhs4ZRtA4KocIngD2-tOCjm7-XzAH6OjD8hJsuKpWA', '14_i7xV9JpyNgwN0UgXi08GBVDjwRRR7Odjskz7ftwswQ1kGZhjEtzCzOh_uGSoYBQBxEgsbG5IeeYE64Jb6QkTqA', 1539175067, NULL, '王老机', '234234234234', '234234234', '开户行', 0, 1, 1, 1537940259, 1539167867, 1539168409);
INSERT INTO `tp_users` VALUES (15, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783610, '', '610', NULL, 'cc391f653a1e699c6ae39c1008c0bdce', '98341', 0, '/images/header/default_header_7.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227026, 1539421064);
INSERT INTO `tp_users` VALUES (16, 3, 0, 1, 'city', '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783611, '', '611', NULL, '559d9259d62e58f5f25296ead71a0cdb', '40907', 0, '/images/header/default_header_1.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227047, 1539654788);
INSERT INTO `tp_users` VALUES (17, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783612, '', '612', NULL, '6ce3b896d7027a55cec9564ef9af6ef2', '63695', 0, '/images/header/default_header_7.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227152, 1539588387);
INSERT INTO `tp_users` VALUES (18, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783613, '', '613', NULL, 'a4bdee9ed9042cd0ed7f304de6a86804', '85044', 0, '/images/header/default_header_2.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227161, 1539421064);
INSERT INTO `tp_users` VALUES (19, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783615, '', '615', NULL, '157f36e2dfeed125c59af10dc92eb3e7', '53967', 0, '/images/header/default_header_2.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227169, 1539324634);
INSERT INTO `tp_users` VALUES (20, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783616, '', '616', NULL, 'f38d9399f4096b27bf375f8bc7e70e00', '19871', 0, '/images/header/default_header_2.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227173, 1539596677);
INSERT INTO `tp_users` VALUES (21, 4, 0, 1, 'city', '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783617, '', '617', NULL, '354a0cbcc10b32a9394b4569fd8a7dfb', '74443', 0, '/images/header/default_header_8.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227178, 1539654800);
INSERT INTO `tp_users` VALUES (22, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783618, '', '618', NULL, 'ed79aa393562457bc80d44566bae3f24', '48765', 0, '/images/header/default_header_7.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227182, 1539588387);
INSERT INTO `tp_users` VALUES (23, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783619, '', '619', NULL, '6480d0c23772e483551db51f30f45286', '27992', 0, '/images/header/default_header_7.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1537940259, 1539227186, 1539588387);
INSERT INTO `tp_users` VALUES (24, 0, 0, 0, NULL, '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783620, '', '620', NULL, 'a0cb916fb0aaee81cf7679dbc3bfa38a', '39811', 0, '/images/header/default_header_2.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1539586602, 1539227191, 1539588387);
INSERT INTO `tp_users` VALUES (25, 4, 0, 2, 'pro', '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783170, '', 'a蒜', NULL, 'a8154d1d77b368e0df9bbf34c4312b28', '39937', 0, '/images/header/default_header_1.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1539656372, 1539655519, 1539655519);
INSERT INTO `tp_users` VALUES (26, 4, 25, 4, 'staff', '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783171, '', '170-171', NULL, 'd51a722dce42d5bf3b0812a05d020b35', '12092', 0, '/images/header/default_header_7.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1539656372, 1539656372, 1539656372);
INSERT INTO `tp_users` VALUES (27, 4, 25, 6, 'staff', '000002;广东省', '000011;深圳市', NULL, 0.00, 0.00, 18702783172, '', '170-172', NULL, '3f219b1f327d08989558d553b1264339', '24279', 0, '/images/header/default_header_8.png', 0.00, 0, NULL, NULL, NULL, NULL, NULL, '', NULL, '', '', 0, 1, 1, 1539657001, 1539657001, 1539657001);

-- ----------------------------
-- Table structure for u_admin
-- ----------------------------
DROP TABLE IF EXISTS `u_admin`;
CREATE TABLE `u_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `rid` int(11) NULL DEFAULT 0 COMMENT '角色id',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密  码',
  `nickname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `logintime` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  `loginip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '管理员状态 1正常 0禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '管理员用户表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of u_admin
-- ----------------------------
INSERT INTO `u_admin` VALUES (1, 1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'Master', 1535423635, '127.0.0.1', 1);
INSERT INTO `u_admin` VALUES (9, 0, 'w708833018', '220c2a6edca3c53bc047c0e6beaa49ae', '王磊', 1421285227, '192.168.18.250', 0);
INSERT INTO `u_admin` VALUES (10, 3, 'slh', 'fcea920f7412b5da7be0cf42b8c93759', 'slh', 1532754850, '127.0.0.1', 1);

SET FOREIGN_KEY_CHECKS = 1;
