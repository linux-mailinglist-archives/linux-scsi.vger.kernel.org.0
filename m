Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E584744377D
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Nov 2021 21:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhKBUvq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Nov 2021 16:51:46 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:43793 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbhKBUvo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Nov 2021 16:51:44 -0400
Received: by mail-pf1-f169.google.com with SMTP id o14so154259pfu.10
        for <linux-scsi@vger.kernel.org>; Tue, 02 Nov 2021 13:49:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XI9fbyH+lunmi434E8I0H0Fn5+/JQUme6ST6vOb1xa8=;
        b=pJxingBGLL8cKcljxVZIVZ+/XgSkopkyovGehM+YV0X4il28zNv1tlHRlqArxzEjaB
         T51w1ZoU8+L0dyKwtiI1oiwcjSZrRftcZlvM57hHYqODp34tyzu2OlFm92TMnZ49MwMF
         p1VFsegrpwHijEk5gSS9uPqaHJVWt0SzANf0D8yZGlQStZlxB98YtTk9fq5QnVQm809z
         JIEydZfLnWSjOAneVrmKEikr4+hTT81MaUiIzvcqNScfWHtZVz9yAls0ts6aA6kRCP79
         NAvFz2bBIFUmgZPI7kf21MiYibQ2V3ueB6Gle1faAdcM6eI3vQ7uJnXWl5KJdWoWUvXV
         CDVA==
X-Gm-Message-State: AOAM530i9+0be33H/bd6ZUCF+YFph9pD1bCqRK34cI3iXZyc4+dqKpoW
        HO1B0AO3VH7GYaqm265R9uIMjEel6WzsHA==
X-Google-Smtp-Source: ABdhPJyZYmruTrmxyiQyfxdFh6UdIc+h7S4rUCnm6FokUfwl3l/GNYLlO7ZGEH050d14tkdtW9D3qg==
X-Received: by 2002:a63:7542:: with SMTP id f2mr29590080pgn.147.1635886148113;
        Tue, 02 Nov 2021 13:49:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:55da:34a:7577:bc7])
        by smtp.gmail.com with ESMTPSA id a21sm59194pfv.67.2021.11.02.13.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 13:49:07 -0700 (PDT)
Subject: Re: [PATCH RFC] scsi: ufs-core: Do not use clk_scaling_lock in
 ufshcd_queuecommand()
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Luca Porzio <lporzio@micron.com>, linux-scsi@vger.kernel.org
References: <20211029133751.420015-1-adrian.hunter@intel.com>
 <24e21ff3-c992-c71e-70e3-e0c3926fbcda@acm.org>
 <c2d76154-b2ef-2e66-0a56-cd22ac8c652f@intel.com>
 <d3d70c8e-f260-ca2d-f4c1-2c9dd1a08c5d@acm.org>
 <3f4ef5e8-38e8-2e90-6da4-abc67aac9e4d@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <263538ad-51b5-4594-9951-8bcc2373da19@acm.org>
Date:   Tue, 2 Nov 2021 13:49:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3f4ef5e8-38e8-2e90-6da4-abc67aac9e4d@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/1/21 11:11 PM, Adrian Hunter wrote:
> On 01/11/2021 20:35, Bart Van Assche wrote:
>> On 11/1/21 2:16 AM, Adrian Hunter wrote:
>>> Also, there is the outstanding question of synchronization for the call to
>>> ufshcd_reset_and_restore() further down.
>>
>> Please clarify this comment further. I assume that you are referring to the
>> ufshcd_reset_and_restore() call guarded by if (needs_reset)? It is not clear
>> to me what the outstanding question is?
> 
> What is to stop it racing with BSG, sysfs, debugfs, abort, reset etc?

The patch below should address all feedback that has been provided so far.
Instead of removing the clock scaling lock entirely, it is only removed from
ufshcd_queuecommand().


Subject: [PATCH] scsi: ufs: Remove the clock scaling lock from the command queueing code

Remove the clock scaling lock from ufshcd_queuecommand() since it is a
performance bottleneck. Freeze request queues from inside
ufshcd_clock_scaling_prepare() to wait for ongoing SCSI and dev cmds.
Insert a rcu_read_lock() / rcu_read_unlock() pair in ufshcd_queuecommand().
Use synchronize_rcu() to wait for ongoing ufshcd_queuecommand() calls.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
  drivers/scsi/ufs/ufshcd.c | 97 ++++++++++-----------------------------
  drivers/scsi/ufs/ufshcd.h |  1 +
  2 files changed, 26 insertions(+), 72 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 35a1af70f705..9d964b979aa2 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1069,65 +1069,6 @@ static bool ufshcd_is_devfreq_scaling_required(struct ufs_hba *hba,
  	return false;
  }

-static int ufshcd_wait_for_doorbell_clr(struct ufs_hba *hba,
-					u64 wait_timeout_us)
-{
-	unsigned long flags;
-	int ret = 0;
-	u32 tm_doorbell;
-	u32 tr_doorbell;
-	bool timeout = false, do_last_check = false;
-	ktime_t start;
-
-	ufshcd_hold(hba, false);
-	spin_lock_irqsave(hba->host->host_lock, flags);
-	/*
-	 * Wait for all the outstanding tasks/transfer requests.
-	 * Verify by checking the doorbell registers are clear.
-	 */
-	start = ktime_get();
-	do {
-		if (hba->ufshcd_state != UFSHCD_STATE_OPERATIONAL) {
-			ret = -EBUSY;
-			goto out;
-		}
-
-		tm_doorbell = ufshcd_readl(hba, REG_UTP_TASK_REQ_DOOR_BELL);
-		tr_doorbell = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
-		if (!tm_doorbell && !tr_doorbell) {
-			timeout = false;
-			break;
-		} else if (do_last_check) {
-			break;
-		}
-
-		spin_unlock_irqrestore(hba->host->host_lock, flags);
-		schedule();
-		if (ktime_to_us(ktime_sub(ktime_get(), start)) >
-		    wait_timeout_us) {
-			timeout = true;
-			/*
-			 * We might have scheduled out for long time so make
-			 * sure to check if doorbells are cleared by this time
-			 * or not.
-			 */
-			do_last_check = true;
-		}
-		spin_lock_irqsave(hba->host->host_lock, flags);
-	} while (tm_doorbell || tr_doorbell);
-
-	if (timeout) {
-		dev_err(hba->dev,
-			"%s: timedout waiting for doorbell to clear (tm=0x%x, tr=0x%x)\n",
-			__func__, tm_doorbell, tr_doorbell);
-		ret = -EBUSY;
-	}
-out:
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
-	ufshcd_release(hba);
-	return ret;
-}
-
  /**
   * ufshcd_scale_gear - scale up/down UFS gear
   * @hba: per adapter instance
@@ -1175,20 +1116,29 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)

  static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)
  {
-	#define DOORBELL_CLR_TOUT_US		(1000 * 1000) /* 1 sec */
  	int ret = 0;
+
  	/*
-	 * make sure that there are no outstanding requests when
-	 * clock scaling is in progress
+	 * Make sure that there are no outstanding requests while clock scaling
+	 * is in progress. Since the error handler may submit TMFs, limit the
+	 * time during which to block hba->tmf_queue in order not to block the
+	 * UFS error handler.
+	 *
+	 * Since ufshcd_exec_dev_cmd() and ufshcd_issue_devman_upiu_cmd() lock
+	 * the clk_scaling_lock before calling blk_get_request(), lock
+	 * clk_scaling_lock before freezing the request queues to prevent a
+	 * deadlock.
  	 */
-	ufshcd_scsi_block_requests(hba);
  	down_write(&hba->clk_scaling_lock);
-
+	blk_freeze_queue_start(hba->cmd_queue);
+	blk_freeze_queue_start(hba->tmf_queue);
  	if (!hba->clk_scaling.is_allowed ||
-	    ufshcd_wait_for_doorbell_clr(hba, DOORBELL_CLR_TOUT_US)) {
+	    blk_mq_freeze_queue_wait_timeout(hba->cmd_queue, HZ) <= 0 ||
+	    blk_mq_freeze_queue_wait_timeout(hba->tmf_queue, HZ / 10) <= 0) {
  		ret = -EBUSY;
+		blk_mq_unfreeze_queue(hba->tmf_queue);
+		blk_mq_unfreeze_queue(hba->cmd_queue);
  		up_write(&hba->clk_scaling_lock);
-		ufshcd_scsi_unblock_requests(hba);
  		goto out;
  	}

@@ -1201,11 +1151,12 @@ static int ufshcd_clock_scaling_prepare(struct ufs_hba *hba)

  static void ufshcd_clock_scaling_unprepare(struct ufs_hba *hba, bool writelock)
  {
+	blk_mq_unfreeze_queue(hba->tmf_queue);
+	blk_mq_unfreeze_queue(hba->cmd_queue);
  	if (writelock)
  		up_write(&hba->clk_scaling_lock);
  	else
  		up_read(&hba->clk_scaling_lock);
-	ufshcd_scsi_unblock_requests(hba);
  	ufshcd_release(hba);
  }

@@ -2698,8 +2649,11 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)

  	WARN_ONCE(tag < 0, "Invalid tag %d\n", tag);

-	if (!down_read_trylock(&hba->clk_scaling_lock))
-		return SCSI_MLQUEUE_HOST_BUSY;
+	/*
+	 * Allows the UFS error handler to wait for prior ufshcd_queuecommand()
+	 * calls.
+	 */
+	rcu_read_lock();

  	switch (hba->ufshcd_state) {
  	case UFSHCD_STATE_OPERATIONAL:
@@ -2785,7 +2739,7 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)

  	ufshcd_send_command(hba, tag);
  out:
-	up_read(&hba->clk_scaling_lock);
+	rcu_read_unlock();

  	if (ufs_trigger_eh()) {
  		unsigned long flags;
@@ -5991,8 +5945,7 @@ static void ufshcd_err_handling_prepare(struct ufs_hba *hba)
  	}
  	ufshcd_scsi_block_requests(hba);
  	/* Drain ufshcd_queuecommand() */
-	down_write(&hba->clk_scaling_lock);
-	up_write(&hba->clk_scaling_lock);
+	synchronize_rcu();
  	cancel_work_sync(&hba->eeh_work);
  }

diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index a911ad72de7a..c8c2bddb1d33 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -778,6 +778,7 @@ struct ufs_hba_monitor {
   * @clk_list_head: UFS host controller clocks list node head
   * @pwr_info: holds current power mode
   * @max_pwr_info: keeps the device max valid pwm
+ * @clk_scaling_lock: used to serialize device commands and clock scaling
   * @desc_size: descriptor sizes reported by device
   * @urgent_bkops_lvl: keeps track of urgent bkops level for device
   * @is_urgent_bkops_lvl_checked: keeps track if the urgent bkops level for
