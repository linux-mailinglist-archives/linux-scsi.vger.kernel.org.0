Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5E1FE8F7
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Jun 2020 04:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgFRCwa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Jun 2020 22:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:34468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbgFRBIi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Jun 2020 21:08:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 073F021D7B;
        Thu, 18 Jun 2020 01:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442517;
        bh=62UpoBMOicIDb08JuJpbBMu5XKtfAtF6zirRNTmWJvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t5PIg5ezNWEHrEcrUPkusT9OO11yf+chj8AgqpxXWqN+1KLHq32fTfDbSB3cmBg5s
         339NebfBmtIwy2Knne4ipLlNrPGREwiNwV4/BDLtFu6IBjjdOACSh6680QEkrLtMmi
         P4tJykqfsSEEdXoqy/SpULU1IhdtdX6lfrnK036Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 023/388] scsi: qedi: Check for buffer overflow in qedi_set_path()
Date:   Wed, 17 Jun 2020 21:02:00 -0400
Message-Id: <20200618010805.600873-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 4a4c0cfb4be74e216dd4446b254594707455bfc6 ]

Smatch complains that the "path_data->handle" variable is user controlled.
It comes from iscsi_set_path() so that seems possible.  It's harmless to
add a limit check.

The qedi->ep_tbl[] array has qedi->max_active_conns elements (which is
always ISCSI_MAX_SESS_PER_HBA (4096) elements).  The array is allocated in
the qedi_cm_alloc_mem() function.

Link: https://lore.kernel.org/r/20200428131939.GA696531@mwanda
Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
Acked-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_iscsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 1f4a5fb00a05..d2e5b485afeb 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -1218,6 +1218,10 @@ static int qedi_set_path(struct Scsi_Host *shost, struct iscsi_path *path_data)
 	}
 
 	iscsi_cid = (u32)path_data->handle;
+	if (iscsi_cid >= qedi->max_active_conns) {
+		ret = -EINVAL;
+		goto set_path_exit;
+	}
 	qedi_ep = qedi->ep_tbl[iscsi_cid];
 	QEDI_INFO(&qedi->dbg_ctx, QEDI_LOG_INFO,
 		  "iscsi_cid=0x%x, qedi_ep=%p\n", iscsi_cid, qedi_ep);
-- 
2.25.1

