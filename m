Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4625D3A0AA7
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Jun 2021 05:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhFIDcy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Jun 2021 23:32:54 -0400
Received: from m12-18.163.com ([220.181.12.18]:51731 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhFIDcx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 8 Jun 2021 23:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yJLcy
        jTevYDfAhXcqjAfCgmhRvB5rbZiOSIOO/QaL3c=; b=N2VaTyPpuxUzeXS9sGtgA
        Rqg4ACRYP3FsJHVhUfk5xnxOQDwFaM6sikDOIBUEkQUlPuy186FvPG4uuQ0m7GDF
        kk7ZOCL4PNMcM8EitKDfKWhb3toYQpcbXts+tzxE2kIzXpg5mqJTkXi38vMOuOoB
        0d1tq6TZOROlN3WiAjXm0s=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp14 (Coremail) with SMTP id EsCowABXWODPNcBg+fqCoQ--.1118S2;
        Wed, 09 Jun 2021 11:30:24 +0800 (CST)
From:   lijian_8010a29@163.com
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] scsi: lpfc: lpfc_mbox: deleted these repeated words
Date:   Wed,  9 Jun 2021 11:29:22 +0800
Message-Id: <20210609032922.367111-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABXWODPNcBg+fqCoQ--.1118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kry3JF47Zr43Xw4Dur1Utrb_yoW8ZrWUpF
        WxC3WUJr1kAF1IyFy2ya18ZFnIyan5XFZ0ka17K3yY9r90kFy0qFWSqry8uay5WFyIvF42
        vryDKa4UW3W0qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bba0PUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqxCsUFUMZwQ5NgAAsy
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: lijian <lijian@yulong.com>

deleted these repeated words 'the' and 'routine' in the comments.

Signed-off-by: lijian <lijian@yulong.com>
---
 drivers/scsi/lpfc/lpfc_mbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_mbox.c b/drivers/scsi/lpfc/lpfc_mbox.c
index 1b40a3bbd1cd..a232e8dfbda8 100644
--- a/drivers/scsi/lpfc/lpfc_mbox.c
+++ b/drivers/scsi/lpfc/lpfc_mbox.c
@@ -2015,7 +2015,7 @@ lpfc_sli_config_mbox_opcode_get(struct lpfc_hba *phba, LPFC_MBOXQ_t *mbox)
  * @mboxq: pointer to lpfc mbox command.
  * @fcf_index: index to fcf table.
  *
- * This routine routine allocates and constructs non-embedded mailbox command
+ * This routine allocates and constructs non-embedded mailbox command
  * for reading a FCF table entry referred by @fcf_index.
  *
  * Return: pointer to the mailbox command constructed if successful, otherwise
@@ -2464,7 +2464,7 @@ lpfc_sli4_dump_page_a0(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also is used
  * to indicate where received unsolicited frames from this FCF will be sent. By
  * default this routine will set up the FCF to forward all unsolicited frames
- * the the RQ ID passed in the @phba. This can be overridden by the caller for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
@@ -2532,7 +2532,7 @@ lpfc_reg_fcfi(struct lpfc_hba *phba, struct lpfcMboxq *mbox)
  * information via a READ_FCF mailbox command. This mailbox command also is used
  * to indicate where received unsolicited frames from this FCF will be sent. By
  * default this routine will set up the FCF to forward all unsolicited frames
- * the the RQ ID passed in the @phba. This can be overridden by the caller for
+ * the RQ ID passed in the @phba. This can be overridden by the caller for
  * more complicated setups.
  **/
 void
-- 
2.25.1


