Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824C03EB651
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Aug 2021 15:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbhHMNyn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 13 Aug 2021 09:54:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3649 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbhHMNyj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 13 Aug 2021 09:54:39 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GmQ4m5BBYz6D8Vt;
        Fri, 13 Aug 2021 21:53:28 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 13 Aug 2021 15:54:11 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 14:54:08 +0100
From:   John Garry <john.garry@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>, <hch@lst.de>, <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/3] scsi: Remove scsi_cmnd.tag
Date:   Fri, 13 Aug 2021 21:49:13 +0800
Message-ID: <1628862553-179450-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
References: <1628862553-179450-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

It is never read, so get rid of it.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/scsi_lib.c  | 1 -
 include/scsi/scsi_cmnd.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 9ba1aa7530a9..572673873ddf 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1540,7 +1540,6 @@ static blk_status_t scsi_prepare_cmd(struct request *req)
 
 	scsi_init_command(sdev, cmd);
 
-	cmd->tag = req->tag;
 	cmd->prot_op = SCSI_PROT_NORMAL;
 	if (blk_rq_bytes(req))
 		cmd->sc_data_direction = rq_dma_dir(req);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 6c5a1c1c6b1e..eaf04c9a1dfc 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -139,7 +139,6 @@ struct scsi_cmnd {
 	int flags;		/* Command flags */
 	unsigned long state;	/* Command completion state */
 
-	unsigned char tag;	/* SCSI-II queued command tag */
 	unsigned int extra_len;	/* length of alignment and padding */
 };
 
-- 
2.26.2

