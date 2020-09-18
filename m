Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6017B26EC9C
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 04:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgIRCNU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 22:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgIRCNO (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:13:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49E08235F9;
        Fri, 18 Sep 2020 02:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395194;
        bh=gJt5tl5bFwD12yQeDxuwhK+rvQNS3vF57KVmKFCezj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eC4/kBkykT50FsU9NCrw6vSVZ3+LMNb1NrAR6azkIae5JJqnVZ+TBtRj/+TrwZoiV
         onMGpfUwQZbkFhQkEw69JQ6HVWk0BheESMUUlo+uMq3O98puPXPLxVBK8uL4jDb7FH
         AMcXO4JHgMTgZeGvp7td7HuOB98yKon8dC4LBjdM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 045/127] scsi: lpfc: Fix RQ buffer leakage when no IOCBs available
Date:   Thu, 17 Sep 2020 22:10:58 -0400
Message-Id: <20200918021220.2066485-45-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021220.2066485-1-sashal@kernel.org>
References: <20200918021220.2066485-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: James Smart <jsmart2021@gmail.com>

[ Upstream commit 39c4f1a965a9244c3ba60695e8ff8da065ec6ac4 ]

The driver is occasionally seeing the following SLI Port error, requiring
reset and reinit:

 Port Status Event: ... error 1=0x52004a01, error 2=0x218

The failure means an RQ timeout. That is, the adapter had received
asynchronous receive frames, ran out of buffer slots to place the frames,
and the driver did not replenish the buffer slots before a timeout
occurred. The driver should not be so slow in replenishing buffers that a
timeout can occur.

When the driver received all the frames of a sequence, it allocates an IOCB
to put the frames in. In a situation where there was no IOCB available for
the frame of a sequence, the RQ buffer corresponding to the first frame of
the sequence was not returned to the FW. Eventually, with enough traffic
encountering the situation, the timeout occurred.

Fix by releasing the buffer back to firmware whenever there is no IOCB for
the first frame.

[mkp: typo]

Link: https://lore.kernel.org/r/20200128002312.16346-2-jsmart2021@gmail.com
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/lpfc/lpfc_sli.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 480d2d467f7a6..45445dafc80cf 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -17038,6 +17038,10 @@ lpfc_prep_seq(struct lpfc_vport *vport, struct hbq_dmabuf *seq_dmabuf)
 			list_add_tail(&iocbq->list, &first_iocbq->list);
 		}
 	}
+	/* Free the sequence's header buffer */
+	if (!first_iocbq)
+		lpfc_in_buf_free(vport->phba, &seq_dmabuf->dbuf);
+
 	return first_iocbq;
 }
 
-- 
2.25.1

