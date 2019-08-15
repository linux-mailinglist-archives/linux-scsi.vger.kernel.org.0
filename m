Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B258E7E5
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Aug 2019 11:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfHOJO6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Aug 2019 05:14:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37184 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbfHOJO6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Aug 2019 05:14:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hyBqQ-0000tX-SG; Thu, 15 Aug 2019 09:14:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fcoe: remove redundant call to skb_transport_header
Date:   Thu, 15 Aug 2019 10:14:54 +0100
Message-Id: <20190815091454.13430-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer fh is being assigned a return value from the call to
skb_transport_header however this value is never read and fh
is being re-assigned immediately afterwards with a new value.
Since there are side-effects from calling skb_transport_header
the call is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/fcoe/fcoe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 587d4bbb7d22..6fd61555120a 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1617,7 +1617,6 @@ static inline int fcoe_filter_frames(struct fc_lport *lport,
 	else
 		fr_flags(fp) |= FCPHF_CRC_UNCHECKED;
 
-	fh = (struct fc_frame_header *) skb_transport_header(skb);
 	fh = fc_frame_header_get(fp);
 	if (fh->fh_r_ctl == FC_RCTL_DD_SOL_DATA && fh->fh_type == FC_TYPE_FCP)
 		return 0;
-- 
2.20.1

