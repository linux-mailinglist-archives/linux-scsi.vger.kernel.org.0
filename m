Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8799B6AFF1
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jul 2019 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbfGPTh7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 15:37:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52948 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPTh7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 15:37:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GJXv60072762;
        Tue, 16 Jul 2019 19:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=sNykf3duT3KzCBKfLuPVcEcJgxJJOt5PG7Ky6LhfGBg=;
 b=cVDNx0p2Pg+rg5ubY+ZoVoRGEnCum04SOJxTPcblgtQNQSfFw2igSLvQ5FsoEKJBTRp6
 fy6m4jnJ1Y+tqYAGMl9rB+yuds+yoe22aHH66jUSru8EqZ0Qvx3QYQ1nmEEC+qkqyOQR
 4wF7xvoR47/oibtGO9U3D8Nf0e/jixntJc4K7eyACzxZb622vFc1FKcodByD3F5BNTgn
 9ZcB21w5DtbtES3zQRyfCv1pi/WvtHKn+zuia6dmKZ0nkw3t+tw4Ui2VmRAPyLZoHuj1
 IJHcVHmWO9GUvYGn9Er5tQmagDzAs2b0r1+Sk2MqSNL8lFCm3KFmijuoPfkJgjoRVZ+q TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tq78pphpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 19:37:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6GJbtT2128284;
        Tue, 16 Jul 2019 19:37:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2tq5bckhdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 19:37:56 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6GJbs87015790;
        Tue, 16 Jul 2019 19:37:55 GMT
Received: from jubi-laptop.us.oracle.com (/10.11.23.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Jul 2019 19:37:54 +0000
From:   Junxiao Bi <junxiao.bi@oracle.com>
To:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, martin.petersen@oracle.com
Subject: [PATCH] scsi: megaraid_sas: fix panic on loading firmware crashdump
Date:   Tue, 16 Jul 2019 12:37:57 -0700
Message-Id: <20190716193757.20488-1-junxiao.bi@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907160240
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=828 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907160239
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

While loading fw crashdump in function fw_crash_buffer_show(),
left bytes in one dma chunk was not checked, if copying size
over it, overflow access will cause kernel panic.

Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 80ab9700f1de..3eef0858fa8e 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -3153,6 +3153,7 @@ fw_crash_buffer_show(struct device *cdev,
 		(struct megasas_instance *) shost->hostdata;
 	u32 size;
 	unsigned long dmachunk = CRASH_DMA_BUF_SIZE;
+	unsigned long chunk_left_bytes;
 	unsigned long src_addr;
 	unsigned long flags;
 	u32 buff_offset;
@@ -3176,6 +3177,8 @@ fw_crash_buffer_show(struct device *cdev,
 	}
 
 	size = (instance->fw_crash_buffer_size * dmachunk) - buff_offset;
+	chunk_left_bytes = dmachunk - (buff_offset % dmachunk);
+	size = (size > chunk_left_bytes) ? chunk_left_bytes : size;
 	size = (size >= PAGE_SIZE) ? (PAGE_SIZE - 1) : size;
 
 	src_addr = (unsigned long)instance->crash_buf[buff_offset / dmachunk] +
-- 
2.17.1

