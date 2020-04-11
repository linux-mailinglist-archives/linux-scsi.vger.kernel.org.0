Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9331A591E
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Apr 2020 01:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgDKXeq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 11 Apr 2020 19:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbgDKXJP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5A1217D8;
        Sat, 11 Apr 2020 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646555;
        bh=ORdiuhU2dCCpWV3CRgYE5CPAYMKh4bXPE412c+Clh64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RqnI/5bdbMeenQfw7a33DXRi2f02VYgmGXwPZFra9umL3umLazi75EfgllSMSNb4v
         C8j7tmaQOplK9/Z3aNSDdqzDleNbSwhPQDwNPVSBmtdhCrCo4VGVD4Kpy7wuhsdzVl
         BtmX8HsjVYhjxXxgimQcM+oz6VD7wvfG0RJE1qgg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Joe Carnuccio <joe.carnuccio@cavium.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 105/121] scsi: qla2xxx: Fix qla2x00_echo_test() based on ISP type
Date:   Sat, 11 Apr 2020 19:06:50 -0400
Message-Id: <20200411230706.23855-105-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Joe Carnuccio <joe.carnuccio@cavium.com>

[ Upstream commit 83cfd3dc002fc730387a1ec5fa0d4097cc31ee9f ]

Ths patch fixes MBX in-direction for setting right bits for
qla2x00_echo_test()

Link: https://lore.kernel.org/r/20200212214436.25532-19-hmadhani@marvell.com
Signed-off-by: Joe Carnuccio <joe.carnuccio@cavium.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index f0846ce0c4da4..0e8426e1e1149 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5173,10 +5173,11 @@ qla2x00_echo_test(scsi_qla_host_t *vha, struct msg_echo_lb *mreq,
 		mcp->out_mb |= MBX_2;
 
 	mcp->in_mb = MBX_0;
-	if (IS_QLA24XX_TYPE(ha) || IS_QLA25XX(ha) ||
-	    IS_CNA_CAPABLE(ha) || IS_QLA2031(ha))
+	if (IS_CNA_CAPABLE(ha) || IS_QLA24XX_TYPE(ha) || IS_QLA25XX(ha) ||
+	    IS_QLA2031(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha))
 		mcp->in_mb |= MBX_1;
-	if (IS_CNA_CAPABLE(ha) || IS_QLA2031(ha))
+	if (IS_CNA_CAPABLE(ha) || IS_QLA2031(ha) || IS_QLA27XX(ha) ||
+	    IS_QLA28XX(ha))
 		mcp->in_mb |= MBX_3;
 
 	mcp->tov = MBX_TOV_SECONDS;
-- 
2.20.1

