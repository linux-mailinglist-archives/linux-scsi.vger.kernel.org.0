Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5809ABFB
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 11:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389667AbfHWJxJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 05:53:09 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:49816 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389467AbfHWJxJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 05:53:09 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7N9nL9h027729
        for <linux-scsi@vger.kernel.org>; Fri, 23 Aug 2019 02:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=y1QzHtZCtEKnKSHf2dOI/XikqK2+u6OkAznFcskh8u8=;
 b=Sotlhwr+Pv4HPVxBxtHl9wMcxg1TtYxyXoZw9PBssd8U/gdn9MqZw15K/txL58aA4M+S
 4tdr9AOwYbC9XyNJ9oFDGibOEYYg0HCSHLhnWuKA3BMSpyGDWI81EIYuNX7Kr5WFDwXB
 KMa4EcWsJmupuuhrp0CwU1f1ORbOzfnUEbLK0YDzOI3D4uDAFkWtVvDrpdj3WxL9qaVb
 7/quA9imcfKGQ8TLhA8dea29LuQWsZA8lhKPfjKuXLqPf7skklnU1sbMXo5kuAd8gVGQ
 cDr8jFA9jreLT6zgjIvHxVqwCYob6ibPBDCaPUkYQI6pfwkcTlqW06gnxfmnKYuYkb1X mQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uhag27tuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 23 Aug 2019 02:53:08 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 23 Aug
 2019 02:53:06 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 23 Aug 2019 02:53:07 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id CFBE03F7040;
        Fri, 23 Aug 2019 02:53:06 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x7N9r6d6007893;
        Fri, 23 Aug 2019 02:53:06 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x7N9r6Rn007892;
        Fri, 23 Aug 2019 02:53:06 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 07/14] qedf: Add support for 20 Gbps speed.
Date:   Fri, 23 Aug 2019 02:52:37 -0700
Message-ID: <20190823095244.7830-8-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190823095244.7830-1-skashyap@marvell.com>
References: <20190823095244.7830-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-23_03:2019-08-21,2019-08-23 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- The current code doeesn't support 20Gbps speed for current
and supported speed, add support for the same.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/qedf/qedf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 995fd32..50b1fa8 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -480,6 +480,9 @@ static void qedf_update_link_speed(struct qedf_ctx *qedf,
 	case 100000:
 		lport->link_speed = FC_PORTSPEED_100GBIT;
 		break;
+	case 20000:
+		lport->link_speed = FC_PORTSPEED_20GBIT;
+		break;
 	default:
 		lport->link_speed = FC_PORTSPEED_UNKNOWN;
 		break;
@@ -521,6 +524,8 @@ static void qedf_update_link_speed(struct qedf_ctx *qedf,
 	    (link->supported_caps & QED_LM_100000baseLR4_ER4_Full_BIT)) {
 		lport->link_supported_speeds |= FC_PORTSPEED_100GBIT;
 	}
+	if (link->supported_caps & QED_LM_20000baseKR2_Full_BIT)
+		lport->link_supported_speeds |= FC_PORTSPEED_20GBIT;
 	fc_host_supported_speeds(lport->host) = lport->link_supported_speeds;
 }
 
-- 
1.8.3.1

