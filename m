Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CA13A0C21
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Jun 2021 08:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhFIGGy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Jun 2021 02:06:54 -0400
Received: from m12-13.163.com ([220.181.12.13]:46006 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFIGGy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 9 Jun 2021 02:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0Fiu3
        nIqGkixooBN2UGMj5DUbDXTfwhLGRwVn84aCWs=; b=daiXV7uxutF5CDeY7x/iX
        vKHlGemnO3cQUSM3gYTDnvJiKqWhicmffCXP96IUZIBfg0lHlfXN3+Z2dn9QMPEi
        G6GGe2QUlB2QGzrY2+wC4L8udWSQII+YhCNB7dXB/yGI/l7kvDU+mgRMf15Ze6oj
        Tjp4yc4tpulMUBvQPTMLWQ=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowAA3ngLQWcBgVi5_FQ--.1778S2;
        Wed, 09 Jun 2021 14:04:01 +0800 (CST)
From:   lijian_8010a29@163.com
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] scsi: lpfc: lpfc_els: deleted the repeated word
Date:   Wed,  9 Jun 2021 14:03:03 +0800
Message-Id: <20210609060303.398046-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAA3ngLQWcBgVi5_FQ--.1778S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWrCw1DXFWruw1fXr15CFg_yoW3uFg_uF
        W8Ar1xJ3yDAF97AF13Jr13Z3s2y3yru3Z2krnaqr93ur48XryDZr98Jr1UX345ZrnIqF47
        XanrWr1Fvw1xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU52PfJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiHRGsUFSIrGlnuAAAs2
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: lijian <lijian@yulong.com>

deleted the repeated word 'the' in the comments.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 21108f322c99..f743bb338665 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -7516,7 +7516,7 @@ lpfc_els_rcv_rtv(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
  * @rrq: Pointer to the rrq struct.
  *
  * Build a ELS RRQ command and send it to the target. If the issue_iocb is
- * Successful the the completion handler will clear the RRQ.
+ * Successful the completion handler will clear the RRQ.
  *
  * Return codes
  *   0 - Successfully sent rrq els iocb.
-- 
2.25.1


