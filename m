Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E5A38EC76
	for <lists+linux-scsi@lfdr.de>; Mon, 24 May 2021 17:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhEXPPo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 May 2021 11:15:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234801AbhEXPJK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 24 May 2021 11:09:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C9A61132;
        Mon, 24 May 2021 14:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621867906;
        bh=9liq446dUtNHzkDe9cd9s7fywZ722+6e6Sek6Sb8DE4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFJ6cmYhdDcSJvXxcInxeNUkdKkQ7OD12sy5+XLibzBpa72pzB3JfjyVxrORLqwYn
         Dubm7rtHxPbvUdjrh3ImQty4TWPtYFlXVY9NYgA0RqIpjyuQs2DlbGV7BAnGJtW69H
         NLjr/EbV0DMxQueOAPmJC29rXu6RlXBEnTJMYSzC/DgshQUQL/XdOUi6ollpdGugg+
         Fk8qu/jKvNiFvbVwW1/YH+ZwiMudx+dI5e2BVhz24vxP6DWDFcJguyeWPADtkY/aCw
         GppUtlyWvdrxQSDgiYGHCaPf7ka2SHuUiXWb6msfOa7TU5iu1eDwh1WS91abfzPx76
         VnfWjC5lTEWAQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matt Wang <wwentao@vmware.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 13/16] scsi: BusLogic: Fix 64-bit system enumeration error for Buslogic
Date:   Mon, 24 May 2021 10:51:27 -0400
Message-Id: <20210524145130.2499829-13-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210524145130.2499829-1-sashal@kernel.org>
References: <20210524145130.2499829-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Matt Wang <wwentao@vmware.com>

[ Upstream commit 56f396146af278135c0ff958c79b5ee1bd22453d ]

Commit 391e2f25601e ("[SCSI] BusLogic: Port driver to 64-bit")
introduced a serious issue for 64-bit systems.  With this commit,
64-bit kernel will enumerate 8*15 non-existing disks.  This is caused
by the broken CCB structure.  The change from u32 data to void *data
increased CCB length on 64-bit system, which introduced an extra 4
byte offset of the CDB.  This leads to incorrect response to INQUIRY
commands during enumeration.

Fix disk enumeration failure by reverting the portion of the commit
above which switched the data pointer from u32 to void.

Link: https://lore.kernel.org/r/C325637F-1166-4340-8F0F-3BCCD59D4D54@vmware.com
Acked-by: Khalid Aziz <khalid@gonehiking.org>
Signed-off-by: Matt Wang <wwentao@vmware.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/BusLogic.c | 6 +++---
 drivers/scsi/BusLogic.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index c7be7bb37209..b9b4491d732a 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -3081,11 +3081,11 @@ static int blogic_qcmd_lck(struct scsi_cmnd *command,
 		ccb->opcode = BLOGIC_INITIATOR_CCB_SG;
 		ccb->datalen = count * sizeof(struct blogic_sg_seg);
 		if (blogic_multimaster_type(adapter))
-			ccb->data = (void *)((unsigned int) ccb->dma_handle +
+			ccb->data = (unsigned int) ccb->dma_handle +
 					((unsigned long) &ccb->sglist -
-					(unsigned long) ccb));
+					(unsigned long) ccb);
 		else
-			ccb->data = ccb->sglist;
+			ccb->data = virt_to_32bit_virt(ccb->sglist);
 
 		scsi_for_each_sg(command, sg, count, i) {
 			ccb->sglist[i].segbytes = sg_dma_len(sg);
diff --git a/drivers/scsi/BusLogic.h b/drivers/scsi/BusLogic.h
index b53ec2f1e8cd..5c950a7a1b1c 100644
--- a/drivers/scsi/BusLogic.h
+++ b/drivers/scsi/BusLogic.h
@@ -821,7 +821,7 @@ struct blogic_ccb {
 	unsigned char cdblen;				/* Byte 2 */
 	unsigned char sense_datalen;			/* Byte 3 */
 	u32 datalen;					/* Bytes 4-7 */
-	void *data;					/* Bytes 8-11 */
+	u32 data;					/* Bytes 8-11 */
 	unsigned char:8;				/* Byte 12 */
 	unsigned char:8;				/* Byte 13 */
 	enum blogic_adapter_status adapter_status;	/* Byte 14 */
-- 
2.30.2

