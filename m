Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB9337023
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 11:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhCKKhw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 05:37:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53822 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhCKKhW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Mar 2021 05:37:22 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lKIgv-0007Zv-Og; Thu, 11 Mar 2021 10:37:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Doug Gilbert <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: sg: Fix use of pointer sfp after it has been kfree'd
Date:   Thu, 11 Mar 2021 10:37:17 +0000
Message-Id: <20210311103717.7523-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently SG_LOG is referencing sfp after it has been kfree'd which
is probably a bad thing to do. Fix this by kfree'ing sfp after
SG_LOG.

Addresses-Coverity: ("Use after free")
Fixes: af1fc95db445 ("scsi: sg: Replace rq array with xarray")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 2d4bbc1a1727..79f05afa4407 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -3799,10 +3799,10 @@ sg_add_sfp(struct sg_device *sdp)
 	if (rbuf_len > 0) {
 		srp = sg_build_reserve(sfp, rbuf_len);
 		if (IS_ERR(srp)) {
-			kfree(sfp);
 			err = PTR_ERR(srp);
 			SG_LOG(1, sfp, "%s: build reserve err=%ld\n", __func__,
 			       -err);
+			kfree(sfp);
 			return ERR_PTR(err);
 		}
 		if (srp->sgat_h.buflen < rbuf_len) {
-- 
2.30.2

