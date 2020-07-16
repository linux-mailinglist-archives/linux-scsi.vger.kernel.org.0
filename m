Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4D52221F1
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jul 2020 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGPL4U (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jul 2020 07:56:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:17732 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728596AbgGPL4P (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Jul 2020 07:56:15 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GBpRim032120;
        Thu, 16 Jul 2020 04:56:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0818;
 bh=jobk3xeLzTHzvJN0Y5cg0OyORp8n4gGX83l30lQJ68I=;
 b=apvwltjkkkx7cLbXR33cxzp/ce7rkRkO9Sy7Z7ZD4AxcNenBjcq2mh0IqeEPKig3/OGF
 2Jk/HJ4bYsha+F+f8lb81/FO5Nd+S2tAjuoiPyeyyl44MnTpxKDF3tVe03kMlxgWPz+f
 1tYAR6ZXoyzEAM9ff2ItoWceH0NSirAbwX9Dzq+MhOlVBhJ6Q9sPxWwbGDt1osNHc6M6
 7JpkfkXlEvBG9SfmPnj5Tf3+myF0jQTMqTgCg4HmyRHVBbyRn6cI3F2N3/76sJZV+QKA
 nl8V6YxlLyLXHgv/vVq6NIabWW2vsU7ltpaCfAS+rDKizoE+OTX5fSzzlhL7kac8l7LW CQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 32ap7v81r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 04:56:13 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 16 Jul
 2020 04:56:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jul 2020 04:56:12 -0700
Received: from NN-LT0049.marvell.com (NN-LT0049.marvell.com [10.193.54.6])
        by maili.marvell.com (Postfix) with ESMTP id 335F33F7040;
        Thu, 16 Jul 2020 04:56:07 -0700 (PDT)
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
Subject: [PATCH net-next 08/13] qede: introduce support for FEC control
Date:   Thu, 16 Jul 2020 14:54:41 +0300
Message-ID: <20200716115446.994-9-alobakin@marvell.com>
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

Add Ethtool callbacks for querying and setting FEC parameters if it's
supported by the underlying qed module and MFW version running on the
device.

Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
---
 .../net/ethernet/qlogic/qede/qede_ethtool.c   | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index f5851a6ae729..12ec80d9247c 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -1861,6 +1861,78 @@ static int qede_set_eee(struct net_device *dev, struct ethtool_eee *edata)
 	return 0;
 }
 
+static u32 qede_link_to_ethtool_fec(u32 link_fec)
+{
+	u32 eth_fec = 0;
+
+	if (link_fec & QED_FEC_MODE_NONE)
+		eth_fec |= ETHTOOL_FEC_OFF;
+	if (link_fec & QED_FEC_MODE_FIRECODE)
+		eth_fec |= ETHTOOL_FEC_BASER;
+	if (link_fec & QED_FEC_MODE_RS)
+		eth_fec |= ETHTOOL_FEC_RS;
+	if (link_fec & QED_FEC_MODE_AUTO)
+		eth_fec |= ETHTOOL_FEC_AUTO;
+	if (link_fec & QED_FEC_MODE_UNSUPPORTED)
+		eth_fec |= ETHTOOL_FEC_NONE;
+
+	return eth_fec;
+}
+
+static u32 qede_ethtool_to_link_fec(u32 eth_fec)
+{
+	u32 link_fec = 0;
+
+	if (eth_fec & ETHTOOL_FEC_OFF)
+		link_fec |= QED_FEC_MODE_NONE;
+	if (eth_fec & ETHTOOL_FEC_BASER)
+		link_fec |= QED_FEC_MODE_FIRECODE;
+	if (eth_fec & ETHTOOL_FEC_RS)
+		link_fec |= QED_FEC_MODE_RS;
+	if (eth_fec & ETHTOOL_FEC_AUTO)
+		link_fec |= QED_FEC_MODE_AUTO;
+	if (eth_fec & ETHTOOL_FEC_NONE)
+		link_fec |= QED_FEC_MODE_UNSUPPORTED;
+
+	return link_fec;
+}
+
+static int qede_get_fecparam(struct net_device *dev,
+			     struct ethtool_fecparam *fecparam)
+{
+	struct qede_dev *edev = netdev_priv(dev);
+	struct qed_link_output curr_link;
+
+	memset(&curr_link, 0, sizeof(curr_link));
+	edev->ops->common->get_link(edev->cdev, &curr_link);
+
+	fecparam->active_fec = qede_link_to_ethtool_fec(curr_link.active_fec);
+	fecparam->fec = qede_link_to_ethtool_fec(curr_link.sup_fec);
+
+	return 0;
+}
+
+static int qede_set_fecparam(struct net_device *dev,
+			     struct ethtool_fecparam *fecparam)
+{
+	struct qede_dev *edev = netdev_priv(dev);
+	struct qed_link_params params;
+
+	if (!edev->ops || !edev->ops->common->can_link_change(edev->cdev)) {
+		DP_INFO(edev, "Link settings are not allowed to be changed\n");
+		return -EOPNOTSUPP;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.override_flags |= QED_LINK_OVERRIDE_FEC_CONFIG;
+	params.fec = qede_ethtool_to_link_fec(fecparam->fec);
+	params.link_up = true;
+
+	edev->ops->common->set_link(edev->cdev, &params);
+
+	return 0;
+}
+
 static int qede_get_module_info(struct net_device *dev,
 				struct ethtool_modinfo *modinfo)
 {
@@ -2097,6 +2169,8 @@ static const struct ethtool_ops qede_ethtool_ops = {
 	.get_module_eeprom		= qede_get_module_eeprom,
 	.get_eee			= qede_get_eee,
 	.set_eee			= qede_set_eee,
+	.get_fecparam			= qede_get_fecparam,
+	.set_fecparam			= qede_set_fecparam,
 	.get_tunable			= qede_get_tunable,
 	.set_tunable			= qede_set_tunable,
 	.flash_device			= qede_flash_device,
-- 
2.25.1

