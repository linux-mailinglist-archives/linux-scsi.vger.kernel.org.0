Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B6741F4E9
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Oct 2021 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355811AbhJASWT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Oct 2021 14:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355782AbhJASWS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 Oct 2021 14:22:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AB3161AEE;
        Fri,  1 Oct 2021 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633112434;
        bh=oVblWWfO6ek+VWM1osZFWJhdhjdVnvVouR1+ysjWqQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YN+qSqK4ISQIWOJGmYub3ezDXcELO7ggGf7ozxscYU4jzO+jOc7NI4dIAgVWXHPAM
         xe4rJSDtbxkkMPGtx9r8QOqc94UsFy1uWZ4CcwcNmC1biBfugtlzWcbv8wXmAj9C7f
         FKN5gthXhJ6pTWyK44Wy6WAlwBpMk9pEm3VgzLJy4iKEURFRSGvxRxj/KDSnqGYRQd
         pnKJoOz8g7wyuVGvyD5SFw53uuHXQOPvDlmnW4ng8w7BeZlhlkZRsu16gM2YpHKCR3
         KjBQHuvsajRJA8DOoOL+rEWHYWKyiHXz5PM4Vb+d2eGt1j7OyqFuY6RuQzNaSxjbRm
         teVk/9xnSfxZw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>
Cc:     Bart Van Assche <bvanassche@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] scsi: ufs: Stop clearing unit attentions
Date:   Fri,  1 Oct 2021 11:20:15 -0700
Message-Id: <20211001182015.1347587-3-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
In-Reply-To: <20211001182015.1347587-1-jaegeuk@kernel.org>
References: <20211001182015.1347587-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@google.com>

Commit aa53f580e67b ("scsi: ufs: Minor adjustments to error handling")
introduced a ufshcd_clear_ua_wluns() call in
ufshcd_err_handling_unprepare(). As explained in detail by Adrian Hunter,
this can trigger a deadlock. Avoid that deadlock by removing the code that
clears the unit attention. This is safe because the only software that
relies on clearing unit attentions is the Android Trusty software and
because support for handling unit attentions has been added in the Trusty software.

See also https://lore.kernel.org/linux-scsi/20210930124224.114031-2-adrian.hunter@intel.com/

Note that, should apply "scsi: ufs: retry START_STOP on UNIT_ATTENTION" before
this patch, since this patch gives UNIT ATTENTION to scsi_execute(START_STOP).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Fixes: aa53f580e67b ("scsi: ufs: Minor adjustments to error handling")
Signed-off-by: Bart Van Assche <bvanassche@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 184 +-------------------------------------
 drivers/scsi/ufs/ufshcd.h |  14 ---
 2 files changed, 1 insertion(+), 197 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 7ec72de826e5..0743f54e55f9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -224,7 +224,6 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba);
 static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd);
 static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag);
 static void ufshcd_hba_exit(struct ufs_hba *hba);
-static int ufshcd_clear_ua_wluns(struct ufs_hba *hba);
 static int ufshcd_probe_hba(struct ufs_hba *hba, bool async);
 static int ufshcd_setup_clocks(struct ufs_hba *hba, bool on);
 static inline void ufshcd_add_delay_before_dme_cmd(struct ufs_hba *hba);
@@ -4108,8 +4107,6 @@ int ufshcd_link_recovery(struct ufs_hba *hba)
 	if (ret)
 		dev_err(hba->dev, "%s: link recovery failed, err %d",
 			__func__, ret);
-	else
-		ufshcd_clear_ua_wluns(hba);
 
 	return ret;
 }
@@ -5995,7 +5992,6 @@ static void ufshcd_err_handling_unprepare(struct ufs_hba *hba)
 	ufshcd_release(hba);
 	if (ufshcd_is_clkscaling_supported(hba))
 		ufshcd_clk_scaling_suspend(hba, false);
-	ufshcd_clear_ua_wluns(hba);
 	ufshcd_rpm_put(hba);
 }
 
@@ -7953,8 +7949,6 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 
-	ufshcd_clear_ua_wluns(hba);
-
 	/* Initialize devfreq after UFS device is detected */
 	if (ufshcd_is_clkscaling_supported(hba)) {
 		memcpy(&hba->clk_scaling.saved_pwr_info.info,
@@ -7980,116 +7974,6 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	return ret;
 }
 
-static void ufshcd_request_sense_done(struct request *rq, blk_status_t error)
-{
-	if (error != BLK_STS_OK)
-		pr_err("%s: REQUEST SENSE failed (%d)\n", __func__, error);
-	kfree(rq->end_io_data);
-	blk_put_request(rq);
-}
-
-static int
-ufshcd_request_sense_async(struct ufs_hba *hba, struct scsi_device *sdev)
-{
-	/*
-	 * Some UFS devices clear unit attention condition only if the sense
-	 * size used (UFS_SENSE_SIZE in this case) is non-zero.
-	 */
-	static const u8 cmd[6] = {REQUEST_SENSE, 0, 0, 0, UFS_SENSE_SIZE, 0};
-	struct scsi_request *rq;
-	struct request *req;
-	char *buffer;
-	int ret;
-
-	buffer = kzalloc(UFS_SENSE_SIZE, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	req = blk_get_request(sdev->request_queue, REQ_OP_DRV_IN,
-			      /*flags=*/BLK_MQ_REQ_PM);
-	if (IS_ERR(req)) {
-		ret = PTR_ERR(req);
-		goto out_free;
-	}
-
-	ret = blk_rq_map_kern(sdev->request_queue, req,
-			      buffer, UFS_SENSE_SIZE, GFP_NOIO);
-	if (ret)
-		goto out_put;
-
-	rq = scsi_req(req);
-	rq->cmd_len = ARRAY_SIZE(cmd);
-	memcpy(rq->cmd, cmd, rq->cmd_len);
-	rq->retries = 3;
-	req->timeout = 1 * HZ;
-	req->rq_flags |= RQF_PM | RQF_QUIET;
-	req->end_io_data = buffer;
-
-	blk_execute_rq_nowait(/*bd_disk=*/NULL, req, /*at_head=*/true,
-			      ufshcd_request_sense_done);
-	return 0;
-
-out_put:
-	blk_put_request(req);
-out_free:
-	kfree(buffer);
-	return ret;
-}
-
-static int ufshcd_clear_ua_wlun(struct ufs_hba *hba, u8 wlun)
-{
-	struct scsi_device *sdp;
-	unsigned long flags;
-	int ret = 0;
-
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	if (wlun == UFS_UPIU_UFS_DEVICE_WLUN)
-		sdp = hba->sdev_ufs_device;
-	else if (wlun == UFS_UPIU_RPMB_WLUN)
-		sdp = hba->sdev_rpmb;
-	else
-		BUG();
-	if (sdp) {
-		ret = scsi_device_get(sdp);
-		if (!ret && !scsi_device_online(sdp)) {
-			ret = -ENODEV;
-			scsi_device_put(sdp);
-		}
-	} else {
-		ret = -ENODEV;
-	}
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	if (ret)
-		goto out_err;
-
-	ret = ufshcd_request_sense_async(hba, sdp);
-	scsi_device_put(sdp);
-out_err:
-	if (ret)
-		dev_err(hba->dev, "%s: UAC clear LU=%x ret = %d\n",
-				__func__, wlun, ret);
-	return ret;
-}
-
-static int ufshcd_clear_ua_wluns(struct ufs_hba *hba)
-{
-	int ret = 0;
-
-	if (!hba->wlun_dev_clr_ua)
-		goto out;
-
-	ret = ufshcd_clear_ua_wlun(hba, UFS_UPIU_UFS_DEVICE_WLUN);
-	if (!ret)
-		ret = ufshcd_clear_ua_wlun(hba, UFS_UPIU_RPMB_WLUN);
-	if (!ret)
-		hba->wlun_dev_clr_ua = false;
-out:
-	if (ret)
-		dev_err(hba->dev, "%s: Failed to clear UAC WLUNS ret = %d\n",
-				__func__, ret);
-	return ret;
-}
-
 /**
  * ufshcd_probe_hba - probe hba to detect device and initialize it
  * @hba: per-adapter instance
@@ -8140,8 +8024,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba, bool init_dev_params)
 	/* UFS device is also active now */
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
-	hba->wlun_dev_clr_ua = true;
-	hba->wlun_rpmb_clr_ua = true;
 
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
@@ -8701,8 +8583,6 @@ static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
 	 * handling context.
 	 */
 	hba->host->eh_noresume = 1;
-	if (hba->wlun_dev_clr_ua)
-		ufshcd_clear_ua_wlun(hba, UFS_UPIU_UFS_DEVICE_WLUN);
 
 	cmd[4] = pwr_mode << 4;
 
@@ -9768,10 +9648,6 @@ void ufshcd_resume_complete(struct device *dev)
 		ufshcd_rpm_put(hba);
 		hba->complete_put = false;
 	}
-	if (hba->rpmb_complete_put) {
-		ufshcd_rpmb_rpm_put(hba);
-		hba->rpmb_complete_put = false;
-	}
 }
 EXPORT_SYMBOL_GPL(ufshcd_resume_complete);
 
@@ -9794,10 +9670,6 @@ int ufshcd_suspend_prepare(struct device *dev)
 		}
 		hba->complete_put = true;
 	}
-	if (hba->sdev_rpmb) {
-		ufshcd_rpmb_rpm_get_sync(hba);
-		hba->rpmb_complete_put = true;
-	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ufshcd_suspend_prepare);
@@ -9866,49 +9738,6 @@ static struct scsi_driver ufs_dev_wlun_template = {
 	},
 };
 
-static int ufshcd_rpmb_probe(struct device *dev)
-{
-	return is_rpmb_wlun(to_scsi_device(dev)) ? 0 : -ENODEV;
-}
-
-static inline int ufshcd_clear_rpmb_uac(struct ufs_hba *hba)
-{
-	int ret = 0;
-
-	if (!hba->wlun_rpmb_clr_ua)
-		return 0;
-	ret = ufshcd_clear_ua_wlun(hba, UFS_UPIU_RPMB_WLUN);
-	if (!ret)
-		hba->wlun_rpmb_clr_ua = 0;
-	return ret;
-}
-
-#ifdef CONFIG_PM
-static int ufshcd_rpmb_resume(struct device *dev)
-{
-	struct ufs_hba *hba = wlun_dev_to_hba(dev);
-
-	if (hba->sdev_rpmb)
-		ufshcd_clear_rpmb_uac(hba);
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops ufs_rpmb_pm_ops = {
-	SET_RUNTIME_PM_OPS(NULL, ufshcd_rpmb_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(NULL, ufshcd_rpmb_resume)
-};
-
-/* ufs_rpmb_wlun_template - Describes UFS RPMB WLUN. Used only to send UAC. */
-static struct scsi_driver ufs_rpmb_wlun_template = {
-	.gendrv = {
-		.name = "ufs_rpmb_wlun",
-		.owner = THIS_MODULE,
-		.probe = ufshcd_rpmb_probe,
-		.pm = &ufs_rpmb_pm_ops,
-	},
-};
-
 static int __init ufshcd_core_init(void)
 {
 	int ret;
@@ -9917,24 +9746,13 @@ static int __init ufshcd_core_init(void)
 
 	ret = scsi_register_driver(&ufs_dev_wlun_template.gendrv);
 	if (ret)
-		goto debugfs_exit;
-
-	ret = scsi_register_driver(&ufs_rpmb_wlun_template.gendrv);
-	if (ret)
-		goto unregister;
-
-	return ret;
-unregister:
-	scsi_unregister_driver(&ufs_dev_wlun_template.gendrv);
-debugfs_exit:
-	ufs_debugfs_exit();
+		ufs_debugfs_exit();
 	return ret;
 }
 
 static void __exit ufshcd_core_exit(void)
 {
 	ufs_debugfs_exit();
-	scsi_unregister_driver(&ufs_rpmb_wlun_template.gendrv);
 	scsi_unregister_driver(&ufs_dev_wlun_template.gendrv);
 }
 
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index ed960d206260..782bbe6d5a52 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -875,9 +875,6 @@ struct ufs_hba {
 	struct ufs_vreg_info vreg_info;
 	struct list_head clk_list_head;
 
-	bool wlun_dev_clr_ua;
-	bool wlun_rpmb_clr_ua;
-
 	/* Number of requests aborts */
 	int req_abort_count;
 
@@ -924,7 +921,6 @@ struct ufs_hba {
 #endif
 	u32 luns_avail;
 	bool complete_put;
-	bool rpmb_complete_put;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -1408,14 +1404,4 @@ static inline int ufshcd_rpm_put(struct ufs_hba *hba)
 	return pm_runtime_put(&hba->sdev_ufs_device->sdev_gendev);
 }
 
-static inline int ufshcd_rpmb_rpm_get_sync(struct ufs_hba *hba)
-{
-	return pm_runtime_get_sync(&hba->sdev_rpmb->sdev_gendev);
-}
-
-static inline int ufshcd_rpmb_rpm_put(struct ufs_hba *hba)
-{
-	return pm_runtime_put(&hba->sdev_rpmb->sdev_gendev);
-}
-
 #endif /* End of Header */
-- 
2.33.0.800.g4c38ced690-goog

