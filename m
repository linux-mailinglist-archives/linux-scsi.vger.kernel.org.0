Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F60626F063
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Sep 2020 04:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgIRCnU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 22:43:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:35978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgIRCKz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:10:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1300C21D92;
        Fri, 18 Sep 2020 02:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395054;
        bh=/6/ywuTfxFzeUl/jPNuDskh3E5Zhq0WW41vYUNDZ/jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07/nlAG6I3Susgp2pjnVIim31bbpr0jEtYba2A7lRjObCnzzI8nAF2LALkzoLhDE8
         0zVe4+Ty4k2NU26o12LYZbkgDGIEPOVhs6vj4TcsgfbfQNQXIZWEGmDjuRWR8IZFuu
         w4YohYZvvn+K3wepSGYRvDV34IQhynRFAPhnzcpA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nilesh Javali <njavali@marvell.com>, Lee Duncan <lduncan@suse.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 142/206] scsi: qedi: Fix termination timeouts in session logout
Date:   Thu, 17 Sep 2020 22:06:58 -0400
Message-Id: <20200918020802.2065198-142-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Nilesh Javali <njavali@marvell.com>

[ Upstream commit b9b97e6903032ec56e6dcbe137a9819b74a17fea ]

The destroy connection ramrod timed out during session logout.  Fix the
wait delay for graceful vs abortive termination as per the FW requirements.

Link: https://lore.kernel.org/r/20200408064332.19377-7-mrangankar@marvell.com
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Manish Rangankar <mrangankar@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_iscsi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_iscsi.c b/drivers/scsi/qedi/qedi_iscsi.c
index 751941a3ed303..aa451c8b49e56 100644
--- a/drivers/scsi/qedi/qedi_iscsi.c
+++ b/drivers/scsi/qedi/qedi_iscsi.c
@@ -1065,6 +1065,9 @@ static void qedi_ep_disconnect(struct iscsi_endpoint *ep)
 		break;
 	}
 
+	if (!abrt_conn)
+		wait_delay += qedi->pf_params.iscsi_pf_params.two_msl_timer;
+
 	qedi_ep->state = EP_STATE_DISCONN_START;
 	ret = qedi_ops->destroy_conn(qedi->cdev, qedi_ep->handle, abrt_conn);
 	if (ret) {
-- 
2.25.1

