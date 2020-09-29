Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBB27C248
	for <lists+linux-scsi@lfdr.de>; Tue, 29 Sep 2020 12:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI2KWn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 06:22:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53638 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725372AbgI2KWn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 06:22:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TAKSad004826
        for <linux-scsi@vger.kernel.org>; Tue, 29 Sep 2020 03:22:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=f09+N/PXSCvI1ANa52PgREUMgEmsuY/UtLqJY54HblM=;
 b=X5qZH5K5qo6Kbp+QhaDpscd9dXQQd37KaFSbsQh+iK1TuV1uAQ2oO6RyHeeYYGfhuXWD
 wHURx+AxMmRLU317W8siHk3DY/aolK9ycLDQT7B+uRDAGGlC0Sgi653qjEgjWKye5pmF
 QAp7CQNeKBNg/N5H0e2pEf2EMPsDAsAfbZyIpniiUZM0Tt8KzmzsAQzIInUBBNd/43TW
 DrY4rVkuFNL0RVj4c9JyQ/3tcyAtH6TerzxOChiPVnIlzslh0J/kUQYczJDgO5h4ihKR
 4auDFO/5hKCC36lm4gis1fqEsurCZyJEjfUoQMT1xR6h22iSBYd3ImYrlrBXemBV/5E+ hQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 33t55p5g0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 29 Sep 2020 03:22:42 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Sep
 2020 03:22:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Sep 2020 03:22:40 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 7EFBD3F703F;
        Tue, 29 Sep 2020 03:22:40 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 08TAMe0V032325;
        Tue, 29 Sep 2020 03:22:40 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 08TAMeRr032316;
        Tue, 29 Sep 2020 03:22:40 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 1/7] qla2xxx: Correct the check for sscanf return value
Date:   Tue, 29 Sep 2020 03:21:46 -0700
Message-ID: <20200929102152.32278-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200929102152.32278-1-njavali@marvell.com>
References: <20200929102152.32278-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_01:2020-09-29,2020-09-29 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

Since the version string is modified sscanf returns 4 instead of 6.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_tmpl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_tmpl.c b/drivers/scsi/qla2xxx/qla_tmpl.c
index 8dc82cfd38b2..591df89a4d13 100644
--- a/drivers/scsi/qla2xxx/qla_tmpl.c
+++ b/drivers/scsi/qla2xxx/qla_tmpl.c
@@ -906,8 +906,8 @@ qla27xx_driver_info(struct qla27xx_fwdt_template *tmp)
 	uint8_t v[] = { 0, 0, 0, 0, 0, 0 };
 
 	WARN_ON_ONCE(sscanf(qla2x00_version_str,
-			    "%hhu.%hhu.%hhu.%hhu.%hhu.%hhu",
-			    v+0, v+1, v+2, v+3, v+4, v+5) != 6);
+			    "%hhu.%hhu.%hhu.%hhu",
+			    v + 0, v + 1, v + 2, v + 3) != 4);
 
 	tmp->driver_info[0] = cpu_to_le32(
 		v[3] << 24 | v[2] << 16 | v[1] << 8 | v[0]);
-- 
2.19.0.rc0

