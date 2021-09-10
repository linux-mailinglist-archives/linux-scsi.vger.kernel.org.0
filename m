Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151E2406181
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Sep 2021 02:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhIJAnC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Sep 2021 20:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:46468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233536AbhIJAUS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Sep 2021 20:20:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92469611BD;
        Fri, 10 Sep 2021 00:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631233139;
        bh=NS44uFGRA29WqPoF5FZLcPOiN6tldwDQo+OPx4WmLws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTnmPIxypprPG9eCuPvdaZT/MbGnpWz/0HEFY6rVeGRVEbvHLIRP0g0N/+HN4hI6+
         1DrOzGnWk7SwkNCTaxixU8XgU2Cu5qkGcP0Q9Ga+MSjG9tnYnkw6zwSUk/TfhhHoSZ
         P4AwdmLMdwR6QYgfJPSb1/JEIWn408rCsgvIGKURBcCBenToSS4qZEjyYW32rHFoAy
         dtgxi+YgwGvS5AxWwq51ACAf/4nI30ueCDMoiPHWlveZfYxei9vALkZpenT3ohPihH
         NiBTQOwCooD60eTbbOrZoFiYb41HnTNbQS4aNkAKe5Ajs7djNlV/tT1jK9e4+DDzZs
         L8s5ek/VI00XQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 5.13 26/88] scsi: ufs: Request sense data asynchronously
Date:   Thu,  9 Sep 2021 20:17:18 -0400
Message-Id: <20210910001820.174272-26-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210910001820.174272-1-sashal@kernel.org>
References: <20210910001820.174272-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit ac1bc2ba060f9609972fb486073ebd9eab1ef3b6 ]

Clearing a unit attention synchronously from inside the UFS error handler
may trigger the following deadlock:

 - ufshcd_err_handler() calls ufshcd_err_handling_unprepare() and the
   latter function calls ufshcd_clear_ua_wluns().

 - ufshcd_clear_ua_wluns() submits a REQUEST SENSE command and that command
   activates the SCSI error handler.

 - The SCSI error handler calls ufshcd_host_reset_and_restore().

 - ufshcd_host_reset_and_restore() executes the following code:
   ufshcd_schedule_eh_work(hba); flush_work(&hba->eh_work);

This sequence results in a deadlock (circular wait). Fix this by requesting
sense data asynchronously.

Link: https://lore.kernel.org/r/20210722033439.26550-16-bvanassche@acm.org
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Stanley Chu <stanley.chu@mediatek.com>
Cc: Can Guo <cang@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Cc: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 64 ++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 469a7be270d6..1f0980a70e3f 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7784,8 +7784,39 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_request_sense_done(struct request *rq, blk_status_t error)
+{
+	if (error != BLK_STS_OK)
+		pr_err("%s: REQUEST SENSE failed (%d)", __func__, error);
+	blk_put_request(rq);
+}
+
 static int
-ufshcd_send_request_sense(struct ufs_hba *hba, struct scsi_device *sdp);
+ufshcd_request_sense_async(struct ufs_hba *hba, struct scsi_device *sdev)
+{
+	/*
+	 * From SPC-6: the REQUEST SENSE command with any allocation length
+	 * clears the sense data.
+	 */
+	static const u8 cmd[6] = {REQUEST_SENSE, 0, 0, 0, 0, 0};
+	struct scsi_request *rq;
+	struct request *req;
+
+	req = blk_get_request(sdev->request_queue, REQ_OP_DRV_IN, /*flags=*/0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	rq = scsi_req(req);
+	rq->cmd_len = ARRAY_SIZE(cmd);
+	memcpy(rq->cmd, cmd, rq->cmd_len);
+	rq->retries = 3;
+	req->timeout = 1 * HZ;
+	req->rq_flags |= RQF_PM | RQF_QUIET;
+
+	blk_execute_rq_nowait(/*bd_disk=*/NULL, req, /*at_head=*/true,
+			      ufshcd_request_sense_done);
+	return 0;
+}
 
 static int ufshcd_clear_ua_wlun(struct ufs_hba *hba, u8 wlun)
 {
@@ -7813,7 +7844,7 @@ static int ufshcd_clear_ua_wlun(struct ufs_hba *hba, u8 wlun)
 	if (ret)
 		goto out_err;
 
-	ret = ufshcd_send_request_sense(hba, sdp);
+	ret = ufshcd_request_sense_async(hba, sdp);
 	scsi_device_put(sdp);
 out_err:
 	if (ret)
@@ -8407,35 +8438,6 @@ static void ufshcd_hba_exit(struct ufs_hba *hba)
 	}
 }
 
-static int
-ufshcd_send_request_sense(struct ufs_hba *hba, struct scsi_device *sdp)
-{
-	unsigned char cmd[6] = {REQUEST_SENSE,
-				0,
-				0,
-				0,
-				UFS_SENSE_SIZE,
-				0};
-	char *buffer;
-	int ret;
-
-	buffer = kzalloc(UFS_SENSE_SIZE, GFP_KERNEL);
-	if (!buffer) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	ret = scsi_execute(sdp, cmd, DMA_FROM_DEVICE, buffer,
-			UFS_SENSE_SIZE, NULL, NULL,
-			msecs_to_jiffies(1000), 3, 0, RQF_PM, NULL);
-	if (ret)
-		pr_err("%s: failed with err %d\n", __func__, ret);
-
-	kfree(buffer);
-out:
-	return ret;
-}
-
 /**
  * ufshcd_set_dev_pwr_mode - sends START STOP UNIT command to set device
  *			     power mode
-- 
2.30.2

