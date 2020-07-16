Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EC72221EE
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jul 2020 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgGPL4w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jul 2020 07:56:52 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:62636 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726383AbgGPL4r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Jul 2020 07:56:47 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GBp647006958;
        Thu, 16 Jul 2020 04:56:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0818;
 bh=TBGJpKG+HEpBYPk1eUZXAhD5vv5Ak4rafmRWPlLZEX8=;
 b=jBAG0goqM7IfBMgT89/zclyJ3ThN9eSSp0zOAn8AN5kbQsWzXYIY+qssKXi5+Nz1d7tM
 kDC2YrNEdaApn1/wuvgrosCoHi41Jf7TRDXjPVEpgnlaZvDnUw1USqRaZkPLKzRwFLKe
 dXbcthxUxub+uU7GGC8LSP3pIw36lN322uzm/2pmETprfF8e7uC6R4f7KwHsu8a5byQk
 FVPToZllUK8gRjaKdLHSzm904/rwu0w8YX+C75cRMB6Ku0GUpGVxao2kkWUJLuvxtqt3
 QzAjIgt0Dy7giEo3acmPy8VpRS6+Atd0RUkiXMvEZkGY5gPIn8XRgwjLNG/vAVB3xOJv nw== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 328mmhyg4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 04:56:38 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul
 2020 04:56:36 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul
 2020 04:56:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jul 2020 04:56:35 -0700
Received: from NN-LT0049.marvell.com (NN-LT0049.marvell.com [10.193.54.6])
        by maili.marvell.com (Postfix) with ESMTP id D82813F703F;
        Thu, 16 Jul 2020 04:56:30 -0700 (PDT)
From:   Alexander Lobakin <alobakin@marvell.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Alexander Lobakin <alobakin@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <GR-everest-linux-l2@marvell.com>,
        <QLogic-Storage-Upstream@cavium.com>, <netdev@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 13/13] qed/qede: add support for the extended speed and FEC modes
Date:   Thu, 16 Jul 2020 14:54:46 +0300
Message-ID: <20200716115446.994-14-alobakin@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716115446.994-1-alobakin@marvell.com>
References: <20200716115446.994-1-alobakin@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_05:2020-07-16,2020-07-16 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add all necessary code (NVM parsing, MFW and Ethtool reports etc.) to
support extended speed and FEC modes.
These new modes are supported by the new boards revisions and newer
MFW versions.

Misc: correct port type for MEDIA_KR.

Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed.h         |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dev.c     | 102 ++++++-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     |  85 +++++-
 drivers/net/ethernet/qlogic/qed/qed_main.c    | 260 +++++++++++++++++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |  74 ++++-
 drivers/net/ethernet/qlogic/qed/qed_mcp.h     |  45 +++
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  10 +
 include/linux/qed/qed_if.h                    |  11 +
 8 files changed, 563 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed.h b/drivers/net/ethernet/qlogic/qed/qed.h
index 63fcbd5a295a..d255e8e68cf8 100644
--- a/drivers/net/ethernet/qlogic/qed/qed.h
+++ b/drivers/net/ethernet/qlogic/qed/qed.h
@@ -731,6 +731,7 @@ struct qed_dev {
 #define QED_IS_AH(dev)			((dev)->type == QED_DEV_TYPE_AH)
 #define QED_IS_K2(dev)			QED_IS_AH(dev)
 #define QED_IS_E4(dev)			(QED_IS_BB(dev) || QED_IS_AH(dev))
+#define QED_IS_E5(dev)			((dev)->type == QED_DEV_TYPE_E5)
 
 	u16				vendor_id;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_dev.c b/drivers/net/ethernet/qlogic/qed/qed_dev.c
index 4bad836d0f74..c25cf132dd46 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_dev.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_dev.c
@@ -3968,8 +3968,9 @@ static int qed_hw_get_resc(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 
 static int qed_hw_get_nvm_info(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 {
-	u32 port_cfg_addr, link_temp, nvm_cfg_addr, device_capabilities, fc;
+	u32 port_cfg_addr, link_temp, nvm_cfg_addr, device_capabilities, fld;
 	u32 nvm_cfg1_offset, mf_mode, addr, generic_cont0, core_cfg;
+	struct qed_mcp_link_speed_params *ext_speed;
 	struct qed_mcp_link_capabilities *p_caps;
 	struct qed_mcp_link_params *link;
 
@@ -4057,8 +4058,7 @@ static int qed_hw_get_nvm_info(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 	link_temp &= NVM_CFG1_PORT_DRV_SPEED_CAPABILITY_MASK_MASK;
 	link->speed.advertised_speeds = link_temp;
 
-	link_temp = link->speed.advertised_speeds;
-	p_hwfn->mcp_info->link_capabilities.speed_capabilities = link_temp;
+	p_caps->speed_capabilities = link->speed.advertised_speeds;
 
 	link_temp = qed_rd(p_hwfn, p_ptt,
 			   port_cfg_addr +
@@ -4093,13 +4093,12 @@ static int qed_hw_get_nvm_info(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 		DP_NOTICE(p_hwfn, "Unknown Speed in 0x%08x\n", link_temp);
 	}
 
-	p_hwfn->mcp_info->link_capabilities.default_speed_autoneg =
-		link->speed.autoneg;
+	p_caps->default_speed_autoneg = link->speed.autoneg;
 
-	fc = GET_MFW_FIELD(link_temp, NVM_CFG1_PORT_DRV_FLOW_CONTROL);
-	link->pause.autoneg = !!(fc & NVM_CFG1_PORT_DRV_FLOW_CONTROL_AUTONEG);
-	link->pause.forced_rx = !!(fc & NVM_CFG1_PORT_DRV_FLOW_CONTROL_RX);
-	link->pause.forced_tx = !!(fc & NVM_CFG1_PORT_DRV_FLOW_CONTROL_TX);
+	fld = GET_MFW_FIELD(link_temp, NVM_CFG1_PORT_DRV_FLOW_CONTROL);
+	link->pause.autoneg = !!(fld & NVM_CFG1_PORT_DRV_FLOW_CONTROL_AUTONEG);
+	link->pause.forced_rx = !!(fld & NVM_CFG1_PORT_DRV_FLOW_CONTROL_RX);
+	link->pause.forced_tx = !!(fld & NVM_CFG1_PORT_DRV_FLOW_CONTROL_TX);
 	link->loopback_mode = 0;
 
 	if (p_hwfn->mcp_info->capabilities &
@@ -4159,6 +4158,91 @@ static int qed_hw_get_nvm_info(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 		p_caps->default_eee = QED_MCP_EEE_UNSUPPORTED;
 	}
 
+	if (p_hwfn->mcp_info->capabilities &
+	    FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL) {
+		ext_speed = &link->ext_speed;
+
+		link_temp = qed_rd(p_hwfn, p_ptt,
+				   port_cfg_addr +
+				   offsetof(struct nvm_cfg1_port,
+					    extended_speed));
+
+		fld = GET_MFW_FIELD(link_temp, NVM_CFG1_PORT_EXTENDED_SPEED);
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_AN)
+			ext_speed->autoneg = true;
+
+		ext_speed->forced_speed = 0;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_1G)
+			ext_speed->forced_speed |= QED_EXT_SPEED_1G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_10G)
+			ext_speed->forced_speed |= QED_EXT_SPEED_10G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_20G)
+			ext_speed->forced_speed |= QED_EXT_SPEED_20G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_25G)
+			ext_speed->forced_speed |= QED_EXT_SPEED_25G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_40G)
+			ext_speed->forced_speed |= QED_EXT_SPEED_40G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R)
+			ext_speed->forced_speed |= QED_EXT_SPEED_50G_R;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R2)
+			ext_speed->forced_speed |= QED_EXT_SPEED_50G_R2;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R2)
+			ext_speed->forced_speed |= QED_EXT_SPEED_100G_R2;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R4)
+			ext_speed->forced_speed |= QED_EXT_SPEED_100G_R4;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_P4)
+			ext_speed->forced_speed |= QED_EXT_SPEED_100G_P4;
+
+		fld = GET_MFW_FIELD(link_temp,
+				    NVM_CFG1_PORT_EXTENDED_SPEED_CAP);
+
+		ext_speed->advertised_speeds = 0;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_RESERVED)
+			ext_speed->advertised_speeds |= QED_EXT_SPEED_MASK_RES;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_1G)
+			ext_speed->advertised_speeds |= QED_EXT_SPEED_MASK_1G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_10G)
+			ext_speed->advertised_speeds |= QED_EXT_SPEED_MASK_10G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_20G)
+			ext_speed->advertised_speeds |= QED_EXT_SPEED_MASK_20G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_25G)
+			ext_speed->advertised_speeds |= QED_EXT_SPEED_MASK_25G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_40G)
+			ext_speed->advertised_speeds |= QED_EXT_SPEED_MASK_40G;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R)
+			ext_speed->advertised_speeds |=
+				QED_EXT_SPEED_MASK_50G_R;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R2)
+			ext_speed->advertised_speeds |=
+				QED_EXT_SPEED_MASK_50G_R2;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R2)
+			ext_speed->advertised_speeds |=
+				QED_EXT_SPEED_MASK_100G_R2;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R4)
+			ext_speed->advertised_speeds |=
+				QED_EXT_SPEED_MASK_100G_R4;
+		if (fld & NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_P4)
+			ext_speed->advertised_speeds |=
+				QED_EXT_SPEED_MASK_100G_P4;
+
+		link_temp = qed_rd(p_hwfn, p_ptt,
+				   port_cfg_addr +
+				   offsetof(struct nvm_cfg1_port,
+					    extended_fec_mode));
+		link->ext_fec_mode = link_temp;
+
+		p_caps->default_ext_speed_caps = ext_speed->advertised_speeds;
+		p_caps->default_ext_speed = ext_speed->forced_speed;
+		p_caps->default_ext_autoneg = ext_speed->autoneg;
+		p_caps->default_ext_fec = link->ext_fec_mode;
+
+		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
+			   "Read default extended link config: Speed 0x%08x, Adv. Speed 0x%08x, AN: 0x%02x, FEC: 0x%02x\n",
+			   ext_speed->forced_speed,
+			   ext_speed->advertised_speeds, ext_speed->autoneg,
+			   p_caps->default_ext_fec);
+	}
+
 	DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
 		   "Read default link: Speed 0x%08x, Adv. Speed 0x%08x, AN: 0x%02x, PAUSE AN: 0x%02x, EEE: 0x%02x [0x%08x usec], FEC: 0x%02x\n",
 		   link->speed.forced_speed, link->speed.advertised_speeds,
diff --git a/drivers/net/ethernet/qlogic/qed/qed_hsi.h b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
index 5b81d5d42397..1af3f65ab862 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_hsi.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_hsi.h
@@ -11580,6 +11580,54 @@ struct eth_phy_cfg {
 #define FEC_FORCE_MODE_FIRECODE			0x01
 #define FEC_FORCE_MODE_RS			0x02
 #define FEC_FORCE_MODE_AUTO			0x07
+#define FEC_EXTENDED_MODE_MASK			0xffffff00
+#define FEC_EXTENDED_MODE_OFFSET		8
+#define ETH_EXT_FEC_NONE			0x00000100
+#define ETH_EXT_FEC_10G_NONE			0x00000200
+#define ETH_EXT_FEC_10G_BASE_R			0x00000400
+#define ETH_EXT_FEC_20G_NONE			0x00000800
+#define ETH_EXT_FEC_20G_BASE_R			0x00001000
+#define ETH_EXT_FEC_25G_NONE			0x00002000
+#define ETH_EXT_FEC_25G_BASE_R			0x00004000
+#define ETH_EXT_FEC_25G_RS528			0x00008000
+#define ETH_EXT_FEC_40G_NONE			0x00010000
+#define ETH_EXT_FEC_40G_BASE_R			0x00020000
+#define ETH_EXT_FEC_50G_NONE			0x00040000
+#define ETH_EXT_FEC_50G_BASE_R			0x00080000
+#define ETH_EXT_FEC_50G_RS528			0x00100000
+#define ETH_EXT_FEC_50G_RS544			0x00200000
+#define ETH_EXT_FEC_100G_NONE			0x00400000
+#define ETH_EXT_FEC_100G_BASE_R			0x00800000
+#define ETH_EXT_FEC_100G_RS528			0x01000000
+#define ETH_EXT_FEC_100G_RS544			0x02000000
+
+	u32					extended_speed;
+#define ETH_EXT_SPEED_MASK			0x0000ffff
+#define ETH_EXT_SPEED_OFFSET			0
+#define ETH_EXT_SPEED_AN			0x00000001
+#define ETH_EXT_SPEED_1G			0x00000002
+#define ETH_EXT_SPEED_10G			0x00000004
+#define ETH_EXT_SPEED_20G			0x00000008
+#define ETH_EXT_SPEED_25G			0x00000010
+#define ETH_EXT_SPEED_40G			0x00000020
+#define ETH_EXT_SPEED_50G_BASE_R		0x00000040
+#define ETH_EXT_SPEED_50G_BASE_R2		0x00000080
+#define ETH_EXT_SPEED_100G_BASE_R2		0x00000100
+#define ETH_EXT_SPEED_100G_BASE_R4		0x00000200
+#define ETH_EXT_SPEED_100G_BASE_P4		0x00000400
+#define ETH_EXT_ADV_SPEED_MASK			0xffff0000
+#define ETH_EXT_ADV_SPEED_OFFSET		16
+#define ETH_EXT_ADV_SPEED_RESERVED		0x00010000
+#define ETH_EXT_ADV_SPEED_1G			0x00020000
+#define ETH_EXT_ADV_SPEED_10G			0x00040000
+#define ETH_EXT_ADV_SPEED_20G			0x00080000
+#define ETH_EXT_ADV_SPEED_25G			0x00100000
+#define ETH_EXT_ADV_SPEED_40G			0x00200000
+#define ETH_EXT_ADV_SPEED_50G_BASE_R		0x00400000
+#define ETH_EXT_ADV_SPEED_50G_BASE_R2		0x00800000
+#define ETH_EXT_ADV_SPEED_100G_BASE_R2		0x01000000
+#define ETH_EXT_ADV_SPEED_100G_BASE_R4		0x02000000
+#define ETH_EXT_ADV_SPEED_100G_BASE_P4		0x04000000
 };
 
 struct port_mf_cfg {
@@ -12571,6 +12619,7 @@ struct public_drv_mb {
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_OFFSET		0
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EEE			0x00000002
 #define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_FEC_CONTROL		0x00000004
+#define DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EXT_SPEED_FEC_CONTROL	0x00000008
 #define DRV_MB_PARAM_FEATURE_SUPPORT_FUNC_VLINK			0x00010000
 
 /* DRV_MSG_CODE_DEBUG_DATA_SEND parameters */
@@ -12660,6 +12709,7 @@ struct public_drv_mb {
 #define FW_MB_PARAM_FEATURE_SUPPORT_SMARTLINQ			BIT(0)
 #define FW_MB_PARAM_FEATURE_SUPPORT_EEE				BIT(1)
 #define FW_MB_PARAM_FEATURE_SUPPORT_FEC_CONTROL			BIT(5)
+#define FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL	BIT(6)
 #define FW_MB_PARAM_FEATURE_SUPPORT_VLINK			BIT(16)
 
 #define FW_MB_PARAM_LOAD_DONE_DID_EFUSE_ERROR			BIT(0)
@@ -13174,7 +13224,40 @@ struct nvm_cfg1_port {
 	u32							mnm_100g_ctrl;
 	u32							mnm_100g_misc;
 
-	u32							reserved[116];
+	u32							temperature;
+	u32							ext_phy_cfg1;
+
+	u32							extended_speed;
+#define NVM_CFG1_PORT_EXTENDED_SPEED_MASK			0x0000ffff
+#define NVM_CFG1_PORT_EXTENDED_SPEED_OFFSET			0
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_AN		0x1
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_1G		0x2
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_10G		0x4
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_20G		0x8
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_25G		0x10
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_40G		0x20
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R		0x40
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_50G_R2		0x80
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R2		0x100
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_R4		0x200
+#define NVM_CFG1_PORT_EXTENDED_SPEED_EXTND_SPD_100G_P4		0x400
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_MASK			0xffff0000
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_OFFSET			16
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_RESERVED	0x1
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_1G		0x2
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_10G		0x4
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_20G		0x8
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_25G		0x10
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_40G		0x20
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R	0x40
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_50G_R2	0x80
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R2	0x100
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_R4	0x200
+#define NVM_CFG1_PORT_EXTENDED_SPEED_CAP_EXTND_SPD_100G_P4	0x400
+
+	u32							extended_fec_mode;
+
+	u32							reserved[112];
 };
 
 struct nvm_cfg1_func {
diff --git a/drivers/net/ethernet/qlogic/qed/qed_main.c b/drivers/net/ethernet/qlogic/qed/qed_main.c
index 28f13cd7bd9b..cfc51c5e5bc5 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_main.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_main.c
@@ -82,6 +82,85 @@ struct qed_mfw_speed_map {
 	.arr_size	= ARRAY_SIZE(arr),	\
 }
 
+static const u32 qed_mfw_ext_1g[] __initconst = {
+	QED_LM_1000baseT_Full,
+	QED_LM_1000baseKX_Full,
+	QED_LM_1000baseX_Full,
+};
+
+static const u32 qed_mfw_ext_10g[] __initconst = {
+	QED_LM_10000baseT_Full,
+	QED_LM_10000baseKR_Full,
+	QED_LM_10000baseKX4_Full,
+	QED_LM_10000baseR_FEC,
+	QED_LM_10000baseCR_Full,
+	QED_LM_10000baseSR_Full,
+	QED_LM_10000baseLR_Full,
+	QED_LM_10000baseLRM_Full,
+};
+
+static const u32 qed_mfw_ext_20g[] __initconst = {
+	QED_LM_20000baseKR2_Full,
+};
+
+static const u32 qed_mfw_ext_25g[] __initconst = {
+	QED_LM_25000baseKR_Full,
+	QED_LM_25000baseCR_Full,
+	QED_LM_25000baseSR_Full,
+};
+
+static const u32 qed_mfw_ext_40g[] __initconst = {
+	QED_LM_40000baseLR4_Full,
+	QED_LM_40000baseKR4_Full,
+	QED_LM_40000baseCR4_Full,
+	QED_LM_40000baseSR4_Full,
+};
+
+static const u32 qed_mfw_ext_50g_base_r[] __initconst = {
+	QED_LM_50000baseKR_Full,
+	QED_LM_50000baseCR_Full,
+	QED_LM_50000baseSR_Full,
+	QED_LM_50000baseLR_ER_FR_Full,
+	QED_LM_50000baseDR_Full,
+};
+
+static const u32 qed_mfw_ext_50g_base_r2[] __initconst = {
+	QED_LM_50000baseKR2_Full,
+	QED_LM_50000baseCR2_Full,
+	QED_LM_50000baseSR2_Full,
+};
+
+static const u32 qed_mfw_ext_100g_base_r2[] __initconst = {
+	QED_LM_100000baseKR2_Full,
+	QED_LM_100000baseSR2_Full,
+	QED_LM_100000baseCR2_Full,
+	QED_LM_100000baseDR2_Full,
+	QED_LM_100000baseLR2_ER2_FR2_Full,
+};
+
+static const u32 qed_mfw_ext_100g_base_r4[] __initconst = {
+	QED_LM_100000baseKR4_Full,
+	QED_LM_100000baseSR4_Full,
+	QED_LM_100000baseCR4_Full,
+	QED_LM_100000baseLR4_ER4_Full,
+};
+
+static struct qed_mfw_speed_map qed_mfw_ext_maps[] __ro_after_init = {
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_1G, qed_mfw_ext_1g),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_10G, qed_mfw_ext_10g),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_20G, qed_mfw_ext_20g),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_25G, qed_mfw_ext_25g),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_40G, qed_mfw_ext_40g),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_50G_BASE_R,
+			  qed_mfw_ext_50g_base_r),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_50G_BASE_R2,
+			  qed_mfw_ext_50g_base_r2),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_100G_BASE_R2,
+			  qed_mfw_ext_100g_base_r2),
+	QED_MFW_SPEED_MAP(ETH_EXT_ADV_SPEED_100G_BASE_R4,
+			  qed_mfw_ext_100g_base_r4),
+};
+
 static const u32 qed_mfw_legacy_1g[] __initconst = {
 	QED_LM_1000baseT_Full,
 	QED_LM_1000baseKX_Full,
@@ -161,6 +240,9 @@ static void __init qed_mfw_speed_maps_init(void)
 {
 	u32 i;
 
+	for (i = 0; i < ARRAY_SIZE(qed_mfw_ext_maps); i++)
+		qed_mfw_speed_map_populate(qed_mfw_ext_maps + i);
+
 	for (i = 0; i < ARRAY_SIZE(qed_mfw_legacy_maps); i++)
 		qed_mfw_speed_map_populate(qed_mfw_legacy_maps + i);
 }
@@ -1556,6 +1638,141 @@ static bool qed_can_link_change(struct qed_dev *cdev)
 	return true;
 }
 
+static void qed_set_ext_speed_params(struct qed_mcp_link_params *link_params,
+				     const struct qed_link_params *params)
+{
+	struct qed_mcp_link_speed_params *ext_speed = &link_params->ext_speed;
+	const struct qed_mfw_speed_map *map;
+	u32 i;
+
+	if (params->override_flags & QED_LINK_OVERRIDE_SPEED_AUTONEG)
+		ext_speed->autoneg = !!params->autoneg;
+
+	if (params->override_flags & QED_LINK_OVERRIDE_SPEED_ADV_SPEEDS) {
+		ext_speed->advertised_speeds = 0;
+
+		for (i = 0; i < ARRAY_SIZE(qed_mfw_ext_maps); i++) {
+			map = qed_mfw_ext_maps + i;
+
+			if (qed_link_mode_intersects(params->adv_speeds,
+						     map->caps))
+				ext_speed->advertised_speeds |= map->mfw_val;
+		}
+	}
+
+	if (params->override_flags & QED_LINK_OVERRIDE_SPEED_FORCED_SPEED) {
+		switch (params->forced_speed) {
+		case SPEED_1000:
+			ext_speed->forced_speed = QED_EXT_SPEED_1G;
+			break;
+		case SPEED_10000:
+			ext_speed->forced_speed = QED_EXT_SPEED_10G;
+			break;
+		case SPEED_20000:
+			ext_speed->forced_speed = QED_EXT_SPEED_20G;
+			break;
+		case SPEED_25000:
+			ext_speed->forced_speed = QED_EXT_SPEED_25G;
+			break;
+		case SPEED_40000:
+			ext_speed->forced_speed = QED_EXT_SPEED_40G;
+			break;
+		case SPEED_50000:
+			ext_speed->forced_speed = QED_EXT_SPEED_50G_R |
+						  QED_EXT_SPEED_50G_R2;
+			break;
+		case SPEED_100000:
+			ext_speed->forced_speed = QED_EXT_SPEED_100G_R2 |
+						  QED_EXT_SPEED_100G_R4 |
+						  QED_EXT_SPEED_100G_P4;
+		default:
+			break;
+		}
+	}
+
+	if (!(params->override_flags & QED_LINK_OVERRIDE_FEC_CONFIG))
+		return;
+
+	switch (params->forced_speed) {
+	case SPEED_25000:
+		switch (params->fec) {
+		case FEC_FORCE_MODE_NONE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_25G_NONE;
+			break;
+		case FEC_FORCE_MODE_FIRECODE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_25G_BASE_R;
+			break;
+		case FEC_FORCE_MODE_RS:
+			link_params->ext_fec_mode = ETH_EXT_FEC_25G_RS528;
+			break;
+		case FEC_FORCE_MODE_AUTO:
+			link_params->ext_fec_mode = ETH_EXT_FEC_25G_RS528 |
+						    ETH_EXT_FEC_25G_BASE_R |
+						    ETH_EXT_FEC_25G_NONE;
+		default:
+			break;
+		}
+
+		break;
+	case SPEED_40000:
+		switch (params->fec) {
+		case FEC_FORCE_MODE_NONE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_40G_NONE;
+			break;
+		case FEC_FORCE_MODE_FIRECODE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_40G_BASE_R;
+			break;
+		case FEC_FORCE_MODE_AUTO:
+			link_params->ext_fec_mode = ETH_EXT_FEC_40G_BASE_R |
+						    ETH_EXT_FEC_40G_NONE;
+		default:
+			break;
+		}
+
+		break;
+	case SPEED_50000:
+		switch (params->fec) {
+		case FEC_FORCE_MODE_NONE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_50G_NONE;
+			break;
+		case FEC_FORCE_MODE_FIRECODE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_50G_BASE_R;
+			break;
+		case FEC_FORCE_MODE_RS:
+			link_params->ext_fec_mode = ETH_EXT_FEC_50G_RS528;
+			break;
+		case FEC_FORCE_MODE_AUTO:
+			link_params->ext_fec_mode = ETH_EXT_FEC_50G_RS528 |
+						    ETH_EXT_FEC_50G_BASE_R |
+						    ETH_EXT_FEC_50G_NONE;
+		default:
+			break;
+		}
+
+		break;
+	case SPEED_100000:
+		switch (params->fec) {
+		case FEC_FORCE_MODE_NONE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_100G_NONE;
+			break;
+		case FEC_FORCE_MODE_FIRECODE:
+			link_params->ext_fec_mode = ETH_EXT_FEC_100G_BASE_R;
+			break;
+		case FEC_FORCE_MODE_RS:
+			link_params->ext_fec_mode = ETH_EXT_FEC_100G_RS528;
+			break;
+		case FEC_FORCE_MODE_AUTO:
+			link_params->ext_fec_mode = ETH_EXT_FEC_100G_RS528 |
+						    ETH_EXT_FEC_100G_BASE_R |
+						    ETH_EXT_FEC_100G_NONE;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+}
+
 static int qed_set_link(struct qed_dev *cdev, struct qed_link_params *params)
 {
 	struct qed_mcp_link_params *link_params;
@@ -1609,6 +1826,9 @@ static int qed_set_link(struct qed_dev *cdev, struct qed_link_params *params)
 	if (params->override_flags & QED_LINK_OVERRIDE_SPEED_FORCED_SPEED)
 		speed->forced_speed = params->forced_speed;
 
+	if (qed_mcp_is_ext_speed_supported(hwfn))
+		qed_set_ext_speed_params(link_params, params);
+
 	if (params->override_flags & QED_LINK_OVERRIDE_PAUSE_CONFIG) {
 		if (params->pause_config & QED_LINK_PAUSE_AUTONEG_ENABLE)
 			link_params->pause.autoneg = true;
@@ -1686,7 +1906,6 @@ static int qed_get_port_type(u32 media_type)
 	case MEDIA_SFP_1G_FIBER:
 	case MEDIA_XFP_FIBER:
 	case MEDIA_MODULE_FIBER:
-	case MEDIA_KR:
 		port_type = PORT_FIBRE;
 		break;
 	case MEDIA_DA_TWINAX:
@@ -1695,6 +1914,7 @@ static int qed_get_port_type(u32 media_type)
 	case MEDIA_BASE_T:
 		port_type = PORT_TP;
 		break;
+	case MEDIA_KR:
 	case MEDIA_NOT_PRESENT:
 		port_type = PORT_NONE;
 		break;
@@ -1986,9 +2206,34 @@ static void qed_fill_link(struct qed_hwfn *hwfn,
 	if (link.link_up)
 		if_link->link_up = true;
 
-	/* TODO - at the moment assume supported and advertised speed equal */
-	if (link_caps.default_speed_autoneg)
-		__set_bit(QED_LM_Autoneg, if_link->supported_caps);
+	if (IS_PF(hwfn->cdev) && qed_mcp_is_ext_speed_supported(hwfn)) {
+		if (link_caps.default_ext_autoneg)
+			__set_bit(QED_LM_Autoneg, if_link->supported_caps);
+
+		qed_link_mode_copy(if_link->advertised_caps,
+				   if_link->supported_caps);
+
+		if (params.ext_speed.autoneg)
+			__set_bit(QED_LM_Autoneg, if_link->advertised_caps);
+		else
+			clear_bit(QED_LM_Autoneg, if_link->advertised_caps);
+
+		qed_fill_link_capability(hwfn, ptt,
+					 params.ext_speed.advertised_speeds,
+					 if_link->advertised_caps);
+	} else {
+		if (link_caps.default_speed_autoneg)
+			__set_bit(QED_LM_Autoneg, if_link->supported_caps);
+
+		qed_link_mode_copy(if_link->advertised_caps,
+				   if_link->supported_caps);
+
+		if (params.speed.autoneg)
+			__set_bit(QED_LM_Autoneg, if_link->advertised_caps);
+		else
+			clear_bit(QED_LM_Autoneg, if_link->advertised_caps);
+	}
+
 	if (params.pause.autoneg ||
 	    (params.pause.forced_rx && params.pause.forced_tx))
 		__set_bit(QED_LM_Asym_Pause, if_link->supported_caps);
@@ -1996,13 +2241,6 @@ static void qed_fill_link(struct qed_hwfn *hwfn,
 	    params.pause.forced_tx)
 		__set_bit(QED_LM_Pause, if_link->supported_caps);
 
-	qed_link_mode_copy(if_link->advertised_caps, if_link->supported_caps);
-
-	if (params.speed.autoneg)
-		__set_bit(QED_LM_Autoneg, if_link->advertised_caps);
-	else
-		__clear_bit(QED_LM_Autoneg, if_link->advertised_caps);
-
 	if_link->sup_fec = link_caps.fec_default;
 	if_link->active_fec = params.fec;
 
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.c b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
index 78c0d3a2d164..988d84564849 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.c
@@ -1476,6 +1476,7 @@ int qed_mcp_set_link(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, bool b_up)
 	struct qed_mcp_mb_params mb_params;
 	struct eth_phy_cfg phy_cfg;
 	u32 cmd, fec_bit = 0;
+	u32 val, ext_speed;
 	int rc = 0;
 
 	/* Set the shmem configuration according to params */
@@ -1522,16 +1523,77 @@ int qed_mcp_set_link(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt, bool b_up)
 		SET_MFW_FIELD(phy_cfg.fec_mode, FEC_FORCE_MODE, fec_bit);
 	}
 
+	if (p_hwfn->mcp_info->capabilities &
+	    FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL) {
+		ext_speed = 0;
+		if (params->ext_speed.autoneg)
+			ext_speed |= ETH_EXT_SPEED_AN;
+
+		val = params->ext_speed.forced_speed;
+		if (val & QED_EXT_SPEED_1G)
+			ext_speed |= ETH_EXT_SPEED_1G;
+		if (val & QED_EXT_SPEED_10G)
+			ext_speed |= ETH_EXT_SPEED_10G;
+		if (val & QED_EXT_SPEED_20G)
+			ext_speed |= ETH_EXT_SPEED_20G;
+		if (val & QED_EXT_SPEED_25G)
+			ext_speed |= ETH_EXT_SPEED_25G;
+		if (val & QED_EXT_SPEED_40G)
+			ext_speed |= ETH_EXT_SPEED_40G;
+		if (val & QED_EXT_SPEED_50G_R)
+			ext_speed |= ETH_EXT_SPEED_50G_BASE_R;
+		if (val & QED_EXT_SPEED_50G_R2)
+			ext_speed |= ETH_EXT_SPEED_50G_BASE_R2;
+		if (val & QED_EXT_SPEED_100G_R2)
+			ext_speed |= ETH_EXT_SPEED_100G_BASE_R2;
+		if (val & QED_EXT_SPEED_100G_R4)
+			ext_speed |= ETH_EXT_SPEED_100G_BASE_R4;
+		if (val & QED_EXT_SPEED_100G_P4)
+			ext_speed |= ETH_EXT_SPEED_100G_BASE_P4;
+
+		SET_MFW_FIELD(phy_cfg.extended_speed, ETH_EXT_SPEED,
+			      ext_speed);
+
+		ext_speed = 0;
+
+		val = params->ext_speed.advertised_speeds;
+		if (val & QED_EXT_SPEED_MASK_1G)
+			ext_speed |= ETH_EXT_ADV_SPEED_1G;
+		if (val & QED_EXT_SPEED_MASK_10G)
+			ext_speed |= ETH_EXT_ADV_SPEED_10G;
+		if (val & QED_EXT_SPEED_MASK_20G)
+			ext_speed |= ETH_EXT_ADV_SPEED_20G;
+		if (val & QED_EXT_SPEED_MASK_25G)
+			ext_speed |= ETH_EXT_ADV_SPEED_25G;
+		if (val & QED_EXT_SPEED_MASK_40G)
+			ext_speed |= ETH_EXT_ADV_SPEED_40G;
+		if (val & QED_EXT_SPEED_MASK_50G_R)
+			ext_speed |= ETH_EXT_ADV_SPEED_50G_BASE_R;
+		if (val & QED_EXT_SPEED_MASK_50G_R2)
+			ext_speed |= ETH_EXT_ADV_SPEED_50G_BASE_R2;
+		if (val & QED_EXT_SPEED_MASK_100G_R2)
+			ext_speed |= ETH_EXT_ADV_SPEED_100G_BASE_R2;
+		if (val & QED_EXT_SPEED_MASK_100G_R4)
+			ext_speed |= ETH_EXT_ADV_SPEED_100G_BASE_R4;
+		if (val & QED_EXT_SPEED_MASK_100G_P4)
+			ext_speed |= ETH_EXT_ADV_SPEED_100G_BASE_P4;
+
+		phy_cfg.extended_speed |= ext_speed;
+
+		SET_MFW_FIELD(phy_cfg.fec_mode, FEC_EXTENDED_MODE,
+			      params->ext_fec_mode);
+	}
+
 	p_hwfn->b_drv_link_init = b_up;
 
 	if (b_up) {
 		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
-			   "Configuring Link: Speed 0x%08x, Pause 0x%08x, adv_speed 0x%08x, loopback 0x%08x, FEC 0x%08x\n",
+			   "Configuring Link: Speed 0x%08x, Pause 0x%08x, Adv. Speed 0x%08x, Loopback 0x%08x, FEC 0x%08x, Ext. Speed 0x%08x\n",
 			   phy_cfg.speed, phy_cfg.pause, phy_cfg.adv_speed,
-			   phy_cfg.loopback_mode, phy_cfg.fec_mode);
+			   phy_cfg.loopback_mode, phy_cfg.fec_mode,
+			   phy_cfg.extended_speed);
 	} else {
-		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK,
-			   "Resetting link\n");
+		DP_VERBOSE(p_hwfn, NETIF_MSG_LINK, "Resetting link\n");
 	}
 
 	memset(&mb_params, 0, sizeof(mb_params));
@@ -3838,6 +3900,10 @@ int qed_mcp_set_capabilities(struct qed_hwfn *p_hwfn, struct qed_ptt *p_ptt)
 		   DRV_MB_PARAM_FEATURE_SUPPORT_FUNC_VLINK |
 		   DRV_MB_PARAM_FEATURE_SUPPORT_PORT_FEC_CONTROL;
 
+	if (QED_IS_E5(p_hwfn->cdev))
+		features |=
+		    DRV_MB_PARAM_FEATURE_SUPPORT_PORT_EXT_SPEED_FEC_CONTROL;
+
 	return qed_mcp_cmd(p_hwfn, p_ptt, DRV_MSG_CODE_FEATURE_SUPPORT,
 			   features, &mcp_resp, &mcp_param);
 }
diff --git a/drivers/net/ethernet/qlogic/qed/qed_mcp.h b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
index ea956c43e596..8edb450d0abf 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_mcp.h
+++ b/drivers/net/ethernet/qlogic/qed/qed_mcp.h
@@ -17,8 +17,31 @@
 
 struct qed_mcp_link_speed_params {
 	bool					autoneg;
+
 	u32					advertised_speeds;
+#define QED_EXT_SPEED_MASK_RES			0x1
+#define QED_EXT_SPEED_MASK_1G			0x2
+#define QED_EXT_SPEED_MASK_10G			0x4
+#define QED_EXT_SPEED_MASK_20G			0x8
+#define QED_EXT_SPEED_MASK_25G			0x10
+#define QED_EXT_SPEED_MASK_40G			0x20
+#define QED_EXT_SPEED_MASK_50G_R		0x40
+#define QED_EXT_SPEED_MASK_50G_R2		0x80
+#define QED_EXT_SPEED_MASK_100G_R2		0x100
+#define QED_EXT_SPEED_MASK_100G_R4		0x200
+#define QED_EXT_SPEED_MASK_100G_P4		0x400
+
 	u32					forced_speed;	   /* In Mb/s */
+#define QED_EXT_SPEED_1G			0x1
+#define QED_EXT_SPEED_10G			0x2
+#define QED_EXT_SPEED_20G			0x4
+#define QED_EXT_SPEED_25G			0x8
+#define QED_EXT_SPEED_40G			0x10
+#define QED_EXT_SPEED_50G_R			0x20
+#define QED_EXT_SPEED_50G_R2			0x40
+#define QED_EXT_SPEED_100G_R2			0x80
+#define QED_EXT_SPEED_100G_R4			0x100
+#define QED_EXT_SPEED_100G_P4			0x200
 };
 
 struct qed_mcp_link_pause_params {
@@ -39,6 +62,9 @@ struct qed_mcp_link_params {
 	u32					loopback_mode;
 	struct qed_link_eee_params		eee;
 	u32					fec;
+
+	struct qed_mcp_link_speed_params	ext_speed;
+	u32					ext_fec_mode;
 };
 
 struct qed_mcp_link_capabilities {
@@ -48,6 +74,11 @@ struct qed_mcp_link_capabilities {
 	enum qed_mcp_eee_mode			default_eee;
 	u32					eee_lpi_timer;
 	u8					eee_speed_caps;
+
+	u32					default_ext_speed_caps;
+	u32					default_ext_autoneg;
+	u32					default_ext_speed;
+	u32					default_ext_fec;
 };
 
 struct qed_mcp_link_state {
@@ -750,6 +781,20 @@ struct qed_drv_tlv_hdr {
 	u8 tlv_flags;
 };
 
+/**
+ * qed_mcp_is_ext_speed_supported() - Check if management firmware supports
+ *                                    extended speeds.
+ * @p_hwfn: HW device data.
+ *
+ * Return: true if supported, false otherwise.
+ */
+static inline bool
+qed_mcp_is_ext_speed_supported(const struct qed_hwfn *p_hwfn)
+{
+	return !!(p_hwfn->mcp_info->capabilities &
+		  FW_MB_PARAM_FEATURE_SUPPORT_EXT_SPEED_FEC_CONTROL);
+}
+
 /**
  * @brief Initialize the interface with the MCP
  *
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 12ec80d9247c..8e08bf249a06 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -462,6 +462,16 @@ static const struct qede_link_mode_mapping qed_lm_map[] = {
 	QEDE_ETHTOOL_LM_MAP(10000baseSR_Full),
 	QEDE_ETHTOOL_LM_MAP(10000baseLR_Full),
 	QEDE_ETHTOOL_LM_MAP(10000baseLRM_Full),
+	QEDE_ETHTOOL_LM_MAP(50000baseKR_Full),
+	QEDE_ETHTOOL_LM_MAP(50000baseCR_Full),
+	QEDE_ETHTOOL_LM_MAP(50000baseSR_Full),
+	QEDE_ETHTOOL_LM_MAP(50000baseLR_ER_FR_Full),
+	QEDE_ETHTOOL_LM_MAP(50000baseDR_Full),
+	QEDE_ETHTOOL_LM_MAP(100000baseKR2_Full),
+	QEDE_ETHTOOL_LM_MAP(100000baseSR2_Full),
+	QEDE_ETHTOOL_LM_MAP(100000baseCR2_Full),
+	QEDE_ETHTOOL_LM_MAP(100000baseLR2_ER2_FR2_Full),
+	QEDE_ETHTOOL_LM_MAP(100000baseDR2_Full),
 };
 
 static_assert(ARRAY_SIZE(qed_lm_map) == QED_LM_COUNT);
diff --git a/include/linux/qed/qed_if.h b/include/linux/qed/qed_if.h
index 9edd5de5645d..b41ea5e13b4a 100644
--- a/include/linux/qed/qed_if.h
+++ b/include/linux/qed/qed_if.h
@@ -594,6 +594,7 @@ enum qed_hw_err_type {
 enum qed_dev_type {
 	QED_DEV_TYPE_BB,
 	QED_DEV_TYPE_AH,
+	QED_DEV_TYPE_E5,
 };
 
 struct qed_dev_info {
@@ -694,6 +695,16 @@ enum qed_link_mode_bits {
 	QED_LM_10000baseSR_Full,
 	QED_LM_10000baseLR_Full,
 	QED_LM_10000baseLRM_Full,
+	QED_LM_50000baseKR_Full,
+	QED_LM_50000baseCR_Full,
+	QED_LM_50000baseSR_Full,
+	QED_LM_50000baseLR_ER_FR_Full,
+	QED_LM_50000baseDR_Full,
+	QED_LM_100000baseKR2_Full,
+	QED_LM_100000baseSR2_Full,
+	QED_LM_100000baseCR2_Full,
+	QED_LM_100000baseLR2_ER2_FR2_Full,
+	QED_LM_100000baseDR2_Full,
 	QED_LM_COUNT,
 };
 
-- 
2.25.1

