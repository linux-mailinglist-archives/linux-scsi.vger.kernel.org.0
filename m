Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5F326EE94
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 04:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgIRCPG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 22:15:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgIRCOt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:14:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E4BE239A1;
        Fri, 18 Sep 2020 02:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395289;
        bh=q4MqQEMeVjXUteqrkCzOYQn50fCqKwcytNOP0ZMrXrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hVYNGLhTbkpfzlsgaAJgquve3ac+L0pYJF7ZgPq9kHwZLNVQx7yUUkyLeoVc/t02s
         rljZc4YvbyreB3xxvY1sP69NJ1OAgfKtzBVgfKAEVVxiA/nhWWMz1rDpXRK1WoAgt+
         mrDt75CjMXttyh3HMPBrm/vebyt/ZK6WF9sko6dM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javed Hasan <jhasan@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        Shyam Sundar <ssundar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, fcoe-devel@open-fcoe.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 123/127] scsi: libfc: Handling of extra kref
Date:   Thu, 17 Sep 2020 22:12:16 -0400
Message-Id: <20200918021220.2066485-123-sashal@kernel.org>
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

From: Javed Hasan <jhasan@marvell.com>

[ Upstream commit 71f2bf85e90d938d4a9ef9dd9bfa8d9b0b6a03f7 ]

Handling of extra kref which is done by lookup table in case rdata is
already present in list.

This issue was leading to memory leak. Trace from KMEMLEAK tool:

  unreferenced object 0xffff8888259e8780 (size 512):
    comm "kworker/2:1", pid 182614, jiffies 4433237386 (age 113021.971s)
    hex dump (first 32 bytes):
    58 0a ec cf 83 88 ff ff 00 00 00 00 00 00 00 00
    01 00 00 00 08 00 00 00 13 7d f0 1e 0e 00 00 10
  backtrace:
	[<000000006b25760f>] fc_rport_recv_req+0x3c6/0x18f0 [libfc]
	[<00000000f208d994>] fc_lport_recv_els_req+0x120/0x8a0 [libfc]
	[<00000000a9c437b8>] fc_lport_recv+0xb9/0x130 [libfc]
	[<00000000ad5be37b>] qedf_ll2_process_skb+0x73d/0xad0 [qedf]
	[<00000000e0eb6893>] process_one_work+0x382/0x6c0
	[<000000002dfd9e21>] worker_thread+0x57/0x5c0
	[<00000000b648204f>] kthread+0x1a0/0x1c0
	[<0000000072f5ab20>] ret_from_fork+0x35/0x40
	[<000000001d5c05d8>] 0xffffffffffffffff

Below is the log sequence which leads to memory leak. Here we get the
nested "Received PLOGI request" for same port and this request leads to
call the fc_rport_create() twice for the same rport.

	kernel: host1: rport fffce5: Received PLOGI request
	kernel: host1: rport fffce5: Received PLOGI in INIT state
	kernel: host1: rport fffce5: Port is Ready
	kernel: host1: rport fffce5: Received PRLI request while in state Ready
	kernel: host1: rport fffce5: PRLI rspp type 8 active 1 passive 0
	kernel: host1: rport fffce5: Received LOGO request while in state Ready
	kernel: host1: rport fffce5: Delete port
	kernel: host1: rport fffce5: Received PLOGI request
	kernel: host1: rport fffce5: Received PLOGI in state Delete - send busy

Link: https://lore.kernel.org/r/20200622101212.3922-2-jhasan@marvell.com
Reviewed-by: Girish Basrur <gbasrur@marvell.com>
Reviewed-by: Saurav Kashyap <skashyap@marvell.com>
Reviewed-by: Shyam Sundar <ssundar@marvell.com>
Signed-off-by: Javed Hasan <jhasan@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/libfc/fc_rport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libfc/fc_rport.c b/drivers/scsi/libfc/fc_rport.c
index 0e964ce75406b..a9137f64befa0 100644
--- a/drivers/scsi/libfc/fc_rport.c
+++ b/drivers/scsi/libfc/fc_rport.c
@@ -145,8 +145,10 @@ struct fc_rport_priv *fc_rport_create(struct fc_lport *lport, u32 port_id)
 	size_t rport_priv_size = sizeof(*rdata);
 
 	rdata = fc_rport_lookup(lport, port_id);
-	if (rdata)
+	if (rdata) {
+		kref_put(&rdata->kref, fc_rport_destroy);
 		return rdata;
+	}
 
 	if (lport->rport_priv_size > 0)
 		rport_priv_size = lport->rport_priv_size;
-- 
2.25.1

