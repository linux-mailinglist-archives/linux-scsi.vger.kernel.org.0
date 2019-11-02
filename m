Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D622ECD2A
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Nov 2019 06:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfKBFBv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 2 Nov 2019 01:01:51 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49948 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFBu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 2 Nov 2019 01:01:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0233860FBB; Sat,  2 Nov 2019 05:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572670908;
        bh=3jrpzDJ3un/OnOp4reXw1SVjx+Aq9j/kB2TL+7OU6WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PL0wqpXRehSrxIoUNFs+oMSNxcwqF1htCO70LuD1PcxuiwMgZvNOq/jTYDTFzi2sk
         OjUaMKXfN4Zrp8f2nBQbs0LN0T6vv8qBY3nmjOSHdz0+5aZkwnCpSZUeUV1Iod/WZO
         Nwhm0P/C2m3tzPcPTEEyxSAHNtE3OGAhNiq6k/TY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB756614A3;
        Sat,  2 Nov 2019 05:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572670907;
        bh=3jrpzDJ3un/OnOp4reXw1SVjx+Aq9j/kB2TL+7OU6WU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRMzXg58P/yMnLCb1FmT+AgGyUgzZoO+iHQmKWkHVkvklOMYNspST3jisHq2GQWaE
         bw6I4FkToKB0uGTBi6QnS4YmArFTE56NyaXS9hhNbWU36dCgTVXXOWJ4WbvGGVdT9V
         zAAEIEnIVGoNNn49H/yC0giQllO2K7fsU7pMyz3s=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB756614A3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/5] scsi: Adjust DBD setting in mode sense for caching mode page per LLD
Date:   Fri,  1 Nov 2019 22:01:34 -0700
Message-Id: <1572670898-750-2-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572670898-750-1-git-send-email-cang@codeaurora.org>
References: <1572670898-750-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Host sends MODE_SENSE_10 with caching mode page, to check if the device
supports the cache feature.
UFS JEDEC standards require DBD field to be set to 1.

This patch allows LLD to define the setting of DBD if required.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/sd.c        | 2 +-
 include/scsi/scsi_host.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index aab4ed8..a9cca2f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2660,7 +2660,7 @@ static int sd_try_rc16_first(struct scsi_device *sdp)
 		dbd = 8;
 	} else {
 		modepage = 8;
-		dbd = 0;
+		dbd = sdp->host->set_dbd_for_caching ? 8 : 0;
 	}
 
 	/* cautiously ask */
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 2c3f0c5..3900987 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -650,6 +650,12 @@ struct Scsi_Host {
 	unsigned no_scsi2_lun_in_cdb:1;
 
 	/*
+	 * Set "DBD" field in mode_sense caching mode page in case it is
+	 * mandatory by LLD standard.
+	 */
+	unsigned set_dbd_for_caching:1;
+
+	/*
 	 * Optional work queue to be utilized by the transport
 	 */
 	char work_q_name[20];
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

