Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 680BDF161F
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Nov 2019 13:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfKFMcz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Nov 2019 07:32:55 -0500
Received: from mail-m974.mail.163.com ([123.126.97.4]:37442 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbfKFMcz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Nov 2019 07:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=CgYUH4XHr5w2XeXP9y
        jIu87F+L7k9QHEB4zdKmLhZUU=; b=a+cxZvr01oxJ2vIYNCP6AYiSVnKMVCMbLS
        VsHN9iwcxTxvtsld4JJT7DeoRSmSTdC4nKGwQERExkDcsnexx/64htg4Yzzii3jR
        oWyi3FCt5GnQq+cYYBjWxv+nqb9mBGk4g0l/7dq1U/cmHf+alxojDk0owGwRJ6do
        gFLfEEWAQ=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp4 (Coremail) with SMTP id HNxpCgBnQrxWvcJd4xuXBQ--.252S3;
        Wed, 06 Nov 2019 20:32:24 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     QLogic-Storage-Upstream@qlogic.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] scsi: bnx2i: fix potential use after free
Date:   Wed,  6 Nov 2019 20:32:21 +0800
Message-Id: <1573043541-19126-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: HNxpCgBnQrxWvcJd4xuXBQ--.252S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF48CF17XrWrGryxAr1kXwb_yoWDtwcE9F
        WjqrW7JryUC39rGr1UWrWrZ39Yk3y3XryIv3Z2ka4rurWUXrnrZry8uFyFvw45W3yUW3s8
        t3yDAay2vrsxKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1WSotUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQBhlclSIdIKejgAAs1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The membe hba->pcidev may be used after its reference is dropped. Move
the put function to where it is never used to avoid potential use after
free issues.

Fixes: a77171806515 ("[SCSI] bnx2i: Removed the reference to the netdev->base_addr")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/scsi/bnx2i/bnx2i_iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2i/bnx2i_iscsi.c b/drivers/scsi/bnx2i/bnx2i_iscsi.c
index c5fa5f3b00e9..0b28d44d3573 100644
--- a/drivers/scsi/bnx2i/bnx2i_iscsi.c
+++ b/drivers/scsi/bnx2i/bnx2i_iscsi.c
@@ -915,12 +915,12 @@ void bnx2i_free_hba(struct bnx2i_hba *hba)
 	INIT_LIST_HEAD(&hba->ep_ofld_list);
 	INIT_LIST_HEAD(&hba->ep_active_list);
 	INIT_LIST_HEAD(&hba->ep_destroy_list);
-	pci_dev_put(hba->pcidev);
 
 	if (hba->regview) {
 		pci_iounmap(hba->pcidev, hba->regview);
 		hba->regview = NULL;
 	}
+	pci_dev_put(hba->pcidev);
 	bnx2i_free_mp_bdt(hba);
 	bnx2i_release_free_cid_que(hba);
 	iscsi_host_free(shost);
-- 
2.7.4

