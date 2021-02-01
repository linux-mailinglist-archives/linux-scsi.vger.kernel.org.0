Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C81730A87B
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Feb 2021 14:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBANSS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Feb 2021 08:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbhBANRg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 Feb 2021 08:17:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A45FC061788
        for <linux-scsi@vger.kernel.org>; Mon,  1 Feb 2021 05:16:16 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nm1so1966520pjb.3
        for <linux-scsi@vger.kernel.org>; Mon, 01 Feb 2021 05:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vrDPZcM/ODmZqsHUIrCraZi1utddj/sJkydFcBGXrlY=;
        b=fuYufXEvEAVItvnkxbu3AgnRn8KXIbOL+r0gKHUr1Zi8FdowxzqsBFsg3ZAhYx4+9E
         rLOphhhQxoKEXIyh8KNFp+gRYU8ZvSrshLoziWcMSBxszYBl/XpkeyxBPTQD9wNVgBrh
         z4VhTcRXmD7VCtrDI3C5oJk2cFhuwrC6sXYx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vrDPZcM/ODmZqsHUIrCraZi1utddj/sJkydFcBGXrlY=;
        b=bOm1BGIXq+gtqusBfiLLfE5CDLNSpTzyOn6pfz6Vpi6hpqo43pPxXcf5IjR97eDOBE
         lf1DmchiZfYNbseP2tcA9aYKz0G0UtTbO8bZMdX+eVt+HpuYKwIjRBoYM56X9nEkktdS
         YZCGm5lovrCZZUdNz4zFfvacpXDnazG1OGwTv+pjknCD8l0OrM6u/UCxpI+MbL7qiGvj
         dKUvvlBdgYX/HzJiQIjeH1lmPInlBxoJ54NPLL3Er3g+K/ejZHlGV9VAIMmpLhd6PNde
         fzOy/pLI1ob7Lnm2m40KHpSsCgce/+p9Gnn3Smt1D5AorBrRnFQxlYzonHp0MK98FflE
         3pXQ==
X-Gm-Message-State: AOAM532wLFKYXVPA8t/jPgbhxMU9HNniaH0T4naaf2GiXmo2aX21lK3W
        XaIFSiKm066/OZK48/xB1n/59fXkG3Sy4j/NzaS/rRRa273DG387UhaT2ortHIuNdZ42ie3YyO1
        4pl1CHX1An+fZSlangjHTt95hsCMmBdXx9MJ4EYEbR9Fzv52nuXxSk7tolyD8JOJ7cBZm9ODEz3
        M78JU+QtXh
X-Google-Smtp-Source: ABdhPJwJi1g2c2tRawM/0CohONEgpRkv1PcfaX6jYs9T/vH4xndn+dDIYo3OKXGduChQ5CQGLz5k5w==
X-Received: by 2002:a17:90a:d188:: with SMTP id fu8mr16809959pjb.77.1612185375506;
        Mon, 01 Feb 2021 05:16:15 -0800 (PST)
Received: from drv-bst-rhel8.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id h2sm18573898pfk.4.2021.02.01.05.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 05:16:15 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>, dgilbert@interlog.com,
        linux-block@vger.kernel.org
Subject: [PATCH v3 3/4] scsi_debug : iouring iopoll support
Date:   Mon,  1 Feb 2021 10:46:18 +0530
Message-Id: <20210201051619.19909-4-kashyap.desai@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20210201051619.19909-1-kashyap.desai@broadcom.com>
References: <20210201051619.19909-1-kashyap.desai@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a5fa3105ba462838"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000a5fa3105ba462838

Add support of iouring iopoll interface in scsi_debug.
This feature requires shared hosttag support in kernel and driver.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cc: dgilbert@interlog.com
Cc: linux-block@vger.kernel.org
---
 drivers/scsi/scsi_debug.c | 130 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d1b0cbe1b5f1..746eec521f79 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -829,6 +829,7 @@ static int sdeb_zbc_max_open = DEF_ZBC_MAX_OPEN_ZONES;
 static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
+static int poll_queues; /* iouring iopoll interface.*/
 static struct sdebug_queue *sdebug_q_arr;  /* ptr to array of submit queues */
 
 static DEFINE_RWLOCK(atomic_rw);
@@ -5432,6 +5433,14 @@ static int schedule_resp(struct scsi_cmnd *cmnd, struct sdebug_dev_info *devip,
 	cmnd->host_scribble = (unsigned char *)sqcp;
 	sd_dp = sqcp->sd_dp;
 	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+
+	/* Do not complete IO from default completion path.
+	 * Let it to be on queue.
+	 * Completion should happen from mq_poll interface.
+	 */
+	if ((sqp - sdebug_q_arr) >= (submit_queues - poll_queues))
+		return 0;
+
 	if (!sd_dp) {
 		sd_dp = kzalloc(sizeof(*sd_dp), GFP_ATOMIC);
 		if (!sd_dp) {
@@ -5615,6 +5624,7 @@ module_param_named(sector_size, sdebug_sector_size, int, S_IRUGO);
 module_param_named(statistics, sdebug_statistics, bool, S_IRUGO | S_IWUSR);
 module_param_named(strict, sdebug_strict, bool, S_IRUGO | S_IWUSR);
 module_param_named(submit_queues, submit_queues, int, S_IRUGO);
+module_param_named(poll_queues, poll_queues, int, S_IRUGO);
 module_param_named(tur_ms_to_ready, sdeb_tur_ms_to_ready, int, S_IRUGO);
 module_param_named(unmap_alignment, sdebug_unmap_alignment, int, S_IRUGO);
 module_param_named(unmap_granularity, sdebug_unmap_granularity, int, S_IRUGO);
@@ -5677,6 +5687,7 @@ MODULE_PARM_DESC(opt_xferlen_exp, "optimal transfer length granularity exponent
 MODULE_PARM_DESC(opts, "1->noise, 2->medium_err, 4->timeout, 8->recovered_err... (def=0)");
 MODULE_PARM_DESC(per_host_store, "If set, next positive add_host will get new store (def=0)");
 MODULE_PARM_DESC(physblk_exp, "physical block exponent (def=0)");
+MODULE_PARM_DESC(poll_queues, "support for iouring iopoll queues (1 to max(submit_queues - 1)");
 MODULE_PARM_DESC(ptype, "SCSI peripheral type(def=0[disk])");
 MODULE_PARM_DESC(random, "If set, uniformly randomize command duration between 0 and delay_in_ns");
 MODULE_PARM_DESC(removable, "claim to have removable media (def=0)");
@@ -7201,6 +7212,104 @@ static int resp_not_ready(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 	return check_condition_result;
 }
 
+static int sdebug_map_queues(struct Scsi_Host *shost)
+{
+	int i, qoff;
+
+	if (shost->nr_hw_queues == 1)
+		return 0;
+
+	for (i = 0, qoff = 0; i < HCTX_MAX_TYPES; i++) {
+		struct blk_mq_queue_map *map = &shost->tag_set.map[i];
+
+		map->nr_queues  = 0;
+
+		if (i == HCTX_TYPE_DEFAULT)
+			map->nr_queues = submit_queues - poll_queues;
+		else if (i == HCTX_TYPE_POLL)
+			map->nr_queues = poll_queues;
+
+		if (!map->nr_queues) {
+			BUG_ON(i == HCTX_TYPE_DEFAULT);
+			continue;
+		}
+
+		map->queue_offset = qoff;
+		blk_mq_map_queues(map);
+
+		qoff += map->nr_queues;
+	}
+
+	return 0;
+
+}
+
+static int sdebug_blk_mq_poll(struct Scsi_Host *shost, unsigned int queue_num)
+{
+	int qc_idx;
+	int retiring = 0;
+	unsigned long iflags;
+	struct sdebug_queue *sqp;
+	struct sdebug_queued_cmd *sqcp;
+	struct scsi_cmnd *scp;
+	struct sdebug_dev_info *devip;
+	int num_entries = 0;
+
+	sqp = sdebug_q_arr + queue_num;
+
+	do {
+		spin_lock_irqsave(&sqp->qc_lock, iflags);
+		qc_idx = find_first_bit(sqp->in_use_bm, sdebug_max_queue);
+		if (unlikely((qc_idx < 0) || (qc_idx >= sdebug_max_queue)))
+			goto out;
+
+		sqcp = &sqp->qc_arr[qc_idx];
+		scp = sqcp->a_cmnd;
+		if (unlikely(scp == NULL)) {
+			pr_err("scp is NULL, queue_num=%d, qc_idx=%d from %s\n",
+			       queue_num, qc_idx, __func__);
+			goto out;
+		}
+		devip = (struct sdebug_dev_info *)scp->device->hostdata;
+		if (likely(devip))
+			atomic_dec(&devip->num_in_q);
+		else
+			pr_err("devip=NULL from %s\n", __func__);
+		if (unlikely(atomic_read(&retired_max_queue) > 0))
+			retiring = 1;
+
+		sqcp->a_cmnd = NULL;
+		if (unlikely(!test_and_clear_bit(qc_idx, sqp->in_use_bm))) {
+			pr_err("Unexpected completion sqp %p queue_num=%d qc_idx=%d from %s\n",
+				sqp, queue_num, qc_idx, __func__);
+			goto out;
+		}
+
+		if (unlikely(retiring)) {	/* user has reduced max_queue */
+			int k, retval;
+
+			retval = atomic_read(&retired_max_queue);
+			if (qc_idx >= retval) {
+				pr_err("index %d too large\n", retval);
+				goto out;
+			}
+			k = find_last_bit(sqp->in_use_bm, retval);
+			if ((k < sdebug_max_queue) || (k == retval))
+				atomic_set(&retired_max_queue, 0);
+			else
+				atomic_set(&retired_max_queue, k + 1);
+		}
+		spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+		scp->scsi_done(scp); /* callback to mid level */
+		num_entries++;
+	} while (1);
+
+out:
+	spin_unlock_irqrestore(&sqp->qc_lock, iflags);
+	return num_entries;
+}
+
+
 static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 				   struct scsi_cmnd *scp)
 {
@@ -7380,6 +7489,8 @@ static struct scsi_host_template sdebug_driver_template = {
 	.ioctl =		scsi_debug_ioctl,
 	.queuecommand =		scsi_debug_queuecommand,
 	.change_queue_depth =	sdebug_change_qdepth,
+	.map_queues =		sdebug_map_queues,
+	.mq_poll =		sdebug_blk_mq_poll,
 	.eh_abort_handler =	scsi_debug_abort,
 	.eh_device_reset_handler = scsi_debug_device_reset,
 	.eh_target_reset_handler = scsi_debug_target_reset,
@@ -7427,6 +7538,25 @@ static int sdebug_driver_probe(struct device *dev)
 	if (sdebug_host_max_queue)
 		hpnt->host_tagset = 1;
 
+	/* poll queues are possible for nr_hw_queues > 1 */
+	if (hpnt->nr_hw_queues == 1 || (poll_queues < 1)) {
+		pr_warn("%s: trim poll_queues to 0. poll_q/nr_hw = (%d/%d)\n",
+			 my_name, poll_queues, hpnt->nr_hw_queues);
+		poll_queues = 0;
+	}
+
+	/*
+	 * Poll queues don't need interrupts, but we need at least one I/O queue
+	 * left over for non-polled I/O.
+	 * If condition not met, trim poll_queues to 1 (just for simplicity).
+	 */
+	if (poll_queues >= submit_queues) {
+		pr_warn("%s: trim poll_queues to 1\n", my_name);
+		poll_queues = 1;
+	}
+	if (poll_queues)
+		hpnt->nr_maps = 3;
+
 	sdbg_host->shost = hpnt;
 	*((struct sdebug_host_info **)hpnt->hostdata) = sdbg_host;
 	if ((hpnt->this_id >= 0) && (sdebug_num_tgts > hpnt->this_id))
-- 
2.18.1


--000000000000a5fa3105ba462838
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
yfWKfxJx8FcWmsjkSlrwDu+oVuDUa2wqeKBU12HQ4JAVd+LOb5edsbbFQxgGHu+MPuc/1hl9kTkC
AwEAAaOCAdEwggHNMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYIKwYBBQUH
MAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxzaWduMnNo
YTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vZ3Nw
ZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEQGA1Ud
HwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNpZ24yc2hh
MmczLmNybDAlBgNVHREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAK
BggrBgEFBQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQU4dX1
Yg4eoWXbqyPW/N1ZD/LPIWcwDQYJKoZIhvcNAQELBQADggEBABBuHYKGUwHIhCjd3LieJwKVuJNr
YohEnZzCoNaOj33/j5thiA4cZehCh6SgrIlFBIktLD7jW9Dwl88Gfcy+RrVa7XK5Hyqwr1JlCVsW
pNj4hlSJMNNqxNSqrKaD1cR4/oZVPFVnJJYlB01cLVjGMzta9x27e6XEtseo2s7aoPS2l82koMr7
8S/v9LyyP4X2aRTWOg9RG8D/13rLxFAApfYvCrf0quIUBWw2BXlq3+e3r7pU7j40d6P04VV3Zxws
M+LbYxcXFT2gXvoYd2Ms8zsLrhO2M6pMzeNGWk2HWTof9s7EEHDjis/MRlbYSNaohV23IUzNlBw7
1FmvvW5GKK0xggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWdu
IG52LXNhMTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0g
RzMCDDSdoX7GqonhoE7TszANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQggqGG0zvD
/hTLAsaOEHJZefTi8RFhDTJS3l8IaY6Rk3cwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMjEwMjAxMTMxNjE2WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG
9w0BAQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADLDcTn25q92r02toPMOCDBPNxVL
TPIByuMZjylXCpCdvnEsdbYW+sdgHqllLGybssneqv5uSIBfu8cWqJhQf0/GVDSOoih4KRP5qQlP
ATfFEqyzsDlu78JV4BfjGaJVC33Tt3UppYjzPrjDmzhrwgFKvMcZ4VyaaTAWAqs5N+Ku+rJ5xJ22
Td0QLU6kM2vXyKsdomwvHDz+eAPcqFqDTQmEvpxKrPI4xqrfMgtNASjdvRdKnNqQmzzIIOU6Rvgw
6uOwBz19h5zg3bVrXklDFEahpOojdxRdJv50HfY7Ptk9LxxdfGInIoUhRK4RDg4cbCtlCnUJ6Kyz
Rj1SWm3CdBY=
--000000000000a5fa3105ba462838--
