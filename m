Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EC287BC0
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Oct 2020 20:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbgJHScq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Oct 2020 14:32:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37439 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbgJHScq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Oct 2020 14:32:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kQaiW-0004ET-2h; Thu, 08 Oct 2020 18:32:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Pavel Machek <pavel@denx.de>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: fix return of uninitialized value in rval
Date:   Thu,  8 Oct 2020 19:32:39 +0100
Message-Id: <20201008183239.200358-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A previous change removed the initialization of rval and there is
now an error where an uninitialized rval is being returned on an
error return path. Fix this by returning -ENODEV.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: b994718760fa ("scsi: qla2xxx: Use constant when it is known")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index ae47e0eb0311..1f9005125313 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -561,7 +561,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	vha = fcport->vha;
 
 	if (!(fcport->nvme_flag & NVME_FLAG_REGISTERED))
-		return rval;
+		return -ENODEV;
 
 	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags) ||
 	    (qpair && !qpair->fw_started) || fcport->deleted)
-- 
2.27.0

