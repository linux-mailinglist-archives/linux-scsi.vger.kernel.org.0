Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3673A0DC2
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Jun 2021 09:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhFIHdV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Jun 2021 03:33:21 -0400
Received: from m12-13.163.com ([220.181.12.13]:57691 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhFIHdU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Jun 2021 03:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gtWew
        a1T8Ws2oVqwcieQNTG9cy6X0zHfsV+sO8nxfeg=; b=Jdz/LIHAIDdzV6IssdsfK
        +fRYn9c1tgVDqONimZgmxUWpaz4JChfxnokfrb6/E1xIlsasj7lGfs/+7lpwNjqz
        k4Ns9yHJaBm3U85FvpUYNyEmwB2+y6FHbn/X+KqQ5jvgzw/p3RYIwiTsY2jlxdZ1
        TEelXzoxRyxq6qmbIvsFSM=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowACXZEUsbsBgVRmKFQ--.2749S2;
        Wed, 09 Jun 2021 15:30:53 +0800 (CST)
From:   lijian_8010a29@163.com
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] scsi: lpfc: lpfc_attr: Removed unnecessary 'return'
Date:   Wed,  9 Jun 2021 15:29:51 +0800
Message-Id: <20210609072951.459196-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowACXZEUsbsBgVRmKFQ--.2749S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtFWxGrWxGF4fGF18XFW3GFg_yoW8Jry8pa
        yqka4Uur95tFnayrsxJr45Zw1Yy3W0ga4jkay2v34F9F18AFWfJryUXryrXry5tFW2krya
        qFZrKrW7C3WUJrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jKQ6XUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqw2sUFUMZwcergAAsT
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: lijian <lijian@yulong.com>

Removed unnecessary 'return'.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 6bf76576527c..d63217a35a31 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -109,7 +109,6 @@ lpfc_jedec_to_ascii(int incr, char hdw[])
 		incr = (incr >> 4);
 	}
 	hdw[8] = 0;
-	return;
 }
 
 /**
@@ -6969,8 +6968,6 @@ lpfc_reset_stats(struct Scsi_Host *shost)
 	psli->stats_start = ktime_get_seconds();
 
 	mempool_free(pmboxq, phba->mbox_mem_pool);
-
-	return;
 }
 
 /*
@@ -7433,8 +7430,6 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_ras_fwlog_buffsize_init(phba, lpfc_ras_fwlog_buffsize);
 	lpfc_ras_fwlog_level_init(phba, lpfc_ras_fwlog_level);
 	lpfc_ras_fwlog_func_init(phba, lpfc_ras_fwlog_func);
-
-	return;
 }
 
 /**
@@ -7527,5 +7522,4 @@ lpfc_get_vport_cfgparam(struct lpfc_vport *vport)
 	lpfc_max_luns_init(vport, lpfc_max_luns);
 	lpfc_scan_down_init(vport, lpfc_scan_down);
 	lpfc_enable_da_id_init(vport, lpfc_enable_da_id);
-	return;
 }
-- 
2.25.1


