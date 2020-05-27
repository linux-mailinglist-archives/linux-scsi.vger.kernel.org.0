Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0338F1E4071
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2020 13:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgE0Lww (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 27 May 2020 07:52:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57742 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE0Lwt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 27 May 2020 07:52:49 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jduby-0002aZ-Sb; Wed, 27 May 2020 11:52:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     QLogic-Storage-Upstream@cavium.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qedf: remove redundant initialization of variable rc
Date:   Wed, 27 May 2020 12:52:42 +0100
Message-Id: <20200527115242.172344-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/qedf/qedf_fip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_fip.c b/drivers/scsi/qedf/qedf_fip.c
index bb82f0875eca..ad6a56ce72a8 100644
--- a/drivers/scsi/qedf/qedf_fip.c
+++ b/drivers/scsi/qedf/qedf_fip.c
@@ -20,7 +20,7 @@ void qedf_fcoe_send_vlan_req(struct qedf_ctx *qedf)
 #define MY_FIP_ALL_FCF_MACS        ((__u8[6]) { 1, 0x10, 0x18, 1, 0, 2 })
 	static u8 my_fcoe_all_fcfs[ETH_ALEN] = MY_FIP_ALL_FCF_MACS;
 	unsigned long flags = 0;
-	int rc = -1;
+	int rc;
 
 	skb = dev_alloc_skb(sizeof(struct fip_vlan));
 	if (!skb) {
-- 
2.25.1

