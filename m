Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F973EDAF3
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Aug 2021 18:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhHPQaS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 16 Aug 2021 12:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhHPQaK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 16 Aug 2021 12:30:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4BCC0613CF
        for <linux-scsi@vger.kernel.org>; Mon, 16 Aug 2021 09:29:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so15006659pjb.3
        for <linux-scsi@vger.kernel.org>; Mon, 16 Aug 2021 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xFs9TDPAAb3W85boAp2WqymjVvjH6oFyl+012wMnC+o=;
        b=HAQPLMo/umUwf7V625UUcZ0kYo2VVGye0C4oYder0n0mD6ynU9ezuUqX2VGViDQ7w4
         Pwx8a5O8la5sfpmVVQZEAR3K1HN7GsV0QaXGT7QJJkcKmQGJhbknh/+8g2nf/axMvmwr
         rzbczfOpcdb2ZzSqW6UqlW2pRJcchwBTQbqVTd7D9IjpwgkWLNcihRAKVAKIDTaiwkGW
         uHn+dAEdV69XAx5igDpnSJCIgZbYAdvMAnG17IqEIJp7GbBa9+7AjWIH3KJFG02iUoco
         E4fHO4DObp7M+QYRmYU3cbSRr2lMn1kGWae71jHci0HV2mN/hZnPYP8kZ3zsIkLOM3Ig
         qKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xFs9TDPAAb3W85boAp2WqymjVvjH6oFyl+012wMnC+o=;
        b=edTspEoEatc2MWifXylCVTb5wl8lNRI+3eXcLoLTkmH32C6rckxuomW3etElXgKfLz
         Zze4UYESKvUMwudXpJSi32OOZf1rjsJgVR4zHU+jqcz236dT7QWMOUSAzFom0u4qwobM
         NjEtBYostYRgA+CfzXqgJkdvSgTG23MCau193j+GO3N0o4eAAdIMlIE4GWRWvCa0DOr0
         szuSiErQyHRTjdtjwN7hunliTGyS76pngUZAW0L6l8wdHt9ndNwjXIN5tyF/cjwtNsPb
         gFOhn+OJO5KmqFor6vp0HK09GR8YRnYwCBKbBXNrITd9gNY4KmB8GOuH6qugG8v9RECo
         Y8og==
X-Gm-Message-State: AOAM533TnuSAp5ON4YuHN6rhm4lqwEDHaGS9j6XzR6HjWkpvXE55qsN4
        qyDACnhk3IwixELcNYnRXJC5sj70vQA=
X-Google-Smtp-Source: ABdhPJwVEww+KOU5+UrpwNI9XnoqA2pif5yq+7AbcuBgVqO7+pHxQoDkfhaYSeJGzk4x5Aw0x9GEyA==
X-Received: by 2002:a65:67c9:: with SMTP id b9mr16590208pgs.430.1629131378513;
        Mon, 16 Aug 2021 09:29:38 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h5sm11257938pfv.131.2021.08.16.09.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 09:29:38 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH v3 11/16] lpfc: Add support for maintaining the cm statistics buffer
Date:   Mon, 16 Aug 2021 09:28:56 -0700
Message-Id: <20210816162901.121235-12-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210816162901.121235-1-jsmart2021@gmail.com>
References: <20210816162901.121235-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch adds the logic to move the congestion management and event
information into the cmd statistics buffer maintained for the adapter.
The update includes rolling up values for the last minute, hour, and
day information.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v3:
  Address krobot cross compile errors: "__aeabi_ldivmod"
    Use div_u64 instead of explicit divide.
---
 drivers/scsi/lpfc/lpfc_crtn.h |   2 +
 drivers/scsi/lpfc/lpfc_els.c  |  10 +
 drivers/scsi/lpfc/lpfc_init.c | 531 +++++++++++++++++++++++++++++++++-
 3 files changed, 542 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 3addb163c2cd..252670a14d13 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -83,8 +83,10 @@ void lpfc_cmf_stop(struct lpfc_hba *phba);
 void lpfc_init_congestion_stat(struct lpfc_hba *phba);
 void lpfc_init_congestion_buf(struct lpfc_hba *phba);
 int lpfc_sli4_cgn_params_read(struct lpfc_hba *phba);
+uint32_t lpfc_cgn_calc_crc32(void *bufp, uint32_t sz, uint32_t seed);
 int lpfc_config_cgn_signal(struct lpfc_hba *phba);
 int lpfc_issue_cmf_sync_wqe(struct lpfc_hba *phba, u32 ms, u64 total);
+void lpfc_cgn_update_stat(struct lpfc_hba *phba, uint32_t dtag);
 void lpfc_unblock_requests(struct lpfc_hba *phba);
 void lpfc_block_requests(struct lpfc_hba *phba);
 
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index d6e64a6c5c07..0ebe5d7a7697 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -3783,6 +3783,7 @@ lpfc_least_capable_settings(struct lpfc_hba *phba,
 	u32 rsp_sig_cap = 0, drv_sig_cap = 0;
 	u32 rsp_sig_freq_cyc = 0, rsp_sig_freq_scale = 0;
 	struct lpfc_cgn_info *cp;
+	u32 crc;
 	u16 sig_freq;
 
 	/* Get rsp signal and frequency capabilities.  */
@@ -3856,6 +3857,8 @@ lpfc_least_capable_settings(struct lpfc_hba *phba,
 		cp->cgn_alarm_freq = cpu_to_le16(sig_freq);
 		cp->cgn_warn_freq = cpu_to_le16(sig_freq);
 	}
+	crc = lpfc_cgn_calc_crc32(cp, LPFC_CGN_INFO_SZ, LPFC_CGN_CRC32_SEED);
+	cp->cgn_info_crc = cpu_to_le32(crc);
 	return;
 
 out_no_support:
@@ -9539,6 +9542,7 @@ lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 	const char *cgn_sev_str;
 	u32 cgn_sev;
 	uint16_t value;
+	u32 crc;
 	bool nm_log = false;
 	int rc = 1;
 
@@ -9601,6 +9605,11 @@ lpfc_els_rcv_fpin_cgn(struct lpfc_hba *phba, struct fc_tlv_desc *tlv)
 						LPFC_CGN_FPIN_WARN)
 						cp->cgn_warn_freq =
 							cpu_to_le16(value);
+					crc = lpfc_cgn_calc_crc32
+						(cp,
+						LPFC_CGN_INFO_SZ,
+						LPFC_CGN_CRC32_SEED);
+					cp->cgn_info_crc = cpu_to_le32(crc);
 				}
 
 				/* Don't deliver to upper layer since
@@ -9688,6 +9697,7 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 			/* If descriptor is bad, drop the rest of the data */
 			return;
 		}
+		lpfc_cgn_update_stat(phba, dtag);
 		cnt = be32_to_cpu(tlv->desc_len);
 
 		/* Sanity check descriptor length. The desc_len value does not
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7db2e4858172..3711707deb36 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -5404,6 +5404,374 @@ lpfc_async_link_speed_to_read_top(struct lpfc_hba *phba, uint8_t speed_code)
 	return port_speed;
 }
 
+/**
+ * lpfc_cgn_update_stat - Save data into congestion stats buffer
+ * @phba: pointer to lpfc hba data structure.
+ * @dtag: FPIN descriptor received
+ *
+ * Increment the FPIN received counter/time when it happens.
+ */
+void
+lpfc_cgn_update_stat(struct lpfc_hba *phba, uint32_t dtag)
+{
+	struct lpfc_cgn_info *cp;
+	struct tm broken;
+	struct timespec64 cur_time;
+	u32 cnt;
+	u16 value;
+
+	/* Make sure we have a congestion info buffer */
+	if (!phba->cgn_i)
+		return;
+	cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
+	ktime_get_real_ts64(&cur_time);
+	time64_to_tm(cur_time.tv_sec, 0, &broken);
+
+	/* Update congestion statistics */
+	switch (dtag) {
+	case ELS_DTAG_LNK_INTEGRITY:
+		cnt = le32_to_cpu(cp->link_integ_notification);
+		cnt++;
+		cp->link_integ_notification = cpu_to_le32(cnt);
+
+		cp->cgn_stat_lnk_month = broken.tm_mon + 1;
+		cp->cgn_stat_lnk_day = broken.tm_mday;
+		cp->cgn_stat_lnk_year = broken.tm_year - 100;
+		cp->cgn_stat_lnk_hour = broken.tm_hour;
+		cp->cgn_stat_lnk_min = broken.tm_min;
+		cp->cgn_stat_lnk_sec = broken.tm_sec;
+		break;
+	case ELS_DTAG_DELIVERY:
+		cnt = le32_to_cpu(cp->delivery_notification);
+		cnt++;
+		cp->delivery_notification = cpu_to_le32(cnt);
+
+		cp->cgn_stat_del_month = broken.tm_mon + 1;
+		cp->cgn_stat_del_day = broken.tm_mday;
+		cp->cgn_stat_del_year = broken.tm_year - 100;
+		cp->cgn_stat_del_hour = broken.tm_hour;
+		cp->cgn_stat_del_min = broken.tm_min;
+		cp->cgn_stat_del_sec = broken.tm_sec;
+		break;
+	case ELS_DTAG_PEER_CONGEST:
+		cnt = le32_to_cpu(cp->cgn_peer_notification);
+		cnt++;
+		cp->cgn_peer_notification = cpu_to_le32(cnt);
+
+		cp->cgn_stat_peer_month = broken.tm_mon + 1;
+		cp->cgn_stat_peer_day = broken.tm_mday;
+		cp->cgn_stat_peer_year = broken.tm_year - 100;
+		cp->cgn_stat_peer_hour = broken.tm_hour;
+		cp->cgn_stat_peer_min = broken.tm_min;
+		cp->cgn_stat_peer_sec = broken.tm_sec;
+		break;
+	case ELS_DTAG_CONGESTION:
+		cnt = le32_to_cpu(cp->cgn_notification);
+		cnt++;
+		cp->cgn_notification = cpu_to_le32(cnt);
+
+		cp->cgn_stat_cgn_month = broken.tm_mon + 1;
+		cp->cgn_stat_cgn_day = broken.tm_mday;
+		cp->cgn_stat_cgn_year = broken.tm_year - 100;
+		cp->cgn_stat_cgn_hour = broken.tm_hour;
+		cp->cgn_stat_cgn_min = broken.tm_min;
+		cp->cgn_stat_cgn_sec = broken.tm_sec;
+	}
+	if (phba->cgn_fpin_frequency &&
+	    phba->cgn_fpin_frequency != LPFC_FPIN_INIT_FREQ) {
+		value = LPFC_CGN_TIMER_TO_MIN / phba->cgn_fpin_frequency;
+		cp->cgn_stat_npm = cpu_to_le32(value);
+	}
+	value = lpfc_cgn_calc_crc32(cp, LPFC_CGN_INFO_SZ,
+				    LPFC_CGN_CRC32_SEED);
+	cp->cgn_info_crc = cpu_to_le32(value);
+}
+
+/**
+ * lpfc_cgn_save_evt_cnt - Save data into registered congestion buffer
+ * @phba: pointer to lpfc hba data structure.
+ *
+ * Save the congestion event data every minute.
+ * On the hour collapse all the minute data into hour data. Every day
+ * collapse all the hour data into daily data. Separate driver
+ * and fabrc congestion event counters that will be saved out
+ * to the registered congestion buffer every minute.
+ */
+static void
+lpfc_cgn_save_evt_cnt(struct lpfc_hba *phba)
+{
+	struct lpfc_cgn_info *cp;
+	struct tm broken;
+	struct timespec64 cur_time;
+	uint32_t i, index;
+	uint16_t value, mvalue;
+	uint64_t bps;
+	uint32_t mbps;
+	uint32_t dvalue, wvalue, lvalue, avalue;
+	uint64_t latsum;
+	uint16_t *ptr;
+	uint32_t *lptr;
+	uint16_t *mptr;
+
+	/* Make sure we have a congestion info buffer */
+	if (!phba->cgn_i)
+		return;
+	cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
+
+	if (time_before(jiffies, phba->cgn_evt_timestamp))
+		return;
+	phba->cgn_evt_timestamp = jiffies +
+			msecs_to_jiffies(LPFC_CGN_TIMER_TO_MIN);
+	phba->cgn_evt_minute++;
+
+	/* We should get to this point in the routine on 1 minute intervals */
+
+	ktime_get_real_ts64(&cur_time);
+	time64_to_tm(cur_time.tv_sec, 0, &broken);
+
+	if (phba->cgn_fpin_frequency &&
+	    phba->cgn_fpin_frequency != LPFC_FPIN_INIT_FREQ) {
+		value = LPFC_CGN_TIMER_TO_MIN / phba->cgn_fpin_frequency;
+		cp->cgn_stat_npm = cpu_to_le32(value);
+	}
+
+	/* Read and clear the latency counters for this minute */
+	lvalue = atomic_read(&phba->cgn_latency_evt_cnt);
+	latsum = atomic64_read(&phba->cgn_latency_evt);
+	atomic_set(&phba->cgn_latency_evt_cnt, 0);
+	atomic64_set(&phba->cgn_latency_evt, 0);
+
+	/* We need to store MB/sec bandwidth in the congestion information.
+	 * block_cnt is count of 512 byte blocks for the entire minute,
+	 * bps will get bytes per sec before finally converting to MB/sec.
+	 */
+	bps = div_u64(phba->rx_block_cnt, LPFC_SEC_MIN) * 512;
+	phba->rx_block_cnt = 0;
+	mvalue = bps / (1024 * 1024); /* convert to MB/sec */
+
+	/* Every minute */
+	/* cgn parameters */
+	cp->cgn_info_mode = phba->cgn_p.cgn_param_mode;
+	cp->cgn_info_level0 = phba->cgn_p.cgn_param_level0;
+	cp->cgn_info_level1 = phba->cgn_p.cgn_param_level1;
+	cp->cgn_info_level2 = phba->cgn_p.cgn_param_level2;
+
+	/* Fill in default LUN qdepth */
+	value = (uint16_t)(phba->pport->cfg_lun_queue_depth);
+	cp->cgn_lunq = cpu_to_le16(value);
+
+	/* Record congestion buffer info - every minute
+	 * cgn_driver_evt_cnt (Driver events)
+	 * cgn_fabric_warn_cnt (Congestion Warnings)
+	 * cgn_latency_evt_cnt / cgn_latency_evt (IO Latency)
+	 * cgn_fabric_alarm_cnt (Congestion Alarms)
+	 */
+	index = ++cp->cgn_index_minute;
+	if (cp->cgn_index_minute == LPFC_MIN_HOUR) {
+		cp->cgn_index_minute = 0;
+		index = 0;
+	}
+
+	/* Get the number of driver events in this sample and reset counter */
+	dvalue = atomic_read(&phba->cgn_driver_evt_cnt);
+	atomic_set(&phba->cgn_driver_evt_cnt, 0);
+
+	/* Get the number of warning events - FPIN and Signal for this minute */
+	wvalue = 0;
+	if ((phba->cgn_reg_fpin & LPFC_CGN_FPIN_WARN) ||
+	    phba->cgn_reg_signal == EDC_CG_SIG_WARN_ONLY ||
+	    phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM)
+		wvalue = atomic_read(&phba->cgn_fabric_warn_cnt);
+	atomic_set(&phba->cgn_fabric_warn_cnt, 0);
+
+	/* Get the number of alarm events - FPIN and Signal for this minute */
+	avalue = 0;
+	if ((phba->cgn_reg_fpin & LPFC_CGN_FPIN_ALARM) ||
+	    phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM)
+		avalue = atomic_read(&phba->cgn_fabric_alarm_cnt);
+	atomic_set(&phba->cgn_fabric_alarm_cnt, 0);
+
+	/* Collect the driver, warning, alarm and latency counts for this
+	 * minute into the driver congestion buffer.
+	 */
+	ptr = &cp->cgn_drvr_min[index];
+	value = (uint16_t)dvalue;
+	*ptr = cpu_to_le16(value);
+
+	ptr = &cp->cgn_warn_min[index];
+	value = (uint16_t)wvalue;
+	*ptr = cpu_to_le16(value);
+
+	ptr = &cp->cgn_alarm_min[index];
+	value = (uint16_t)avalue;
+	*ptr = cpu_to_le16(value);
+
+	lptr = &cp->cgn_latency_min[index];
+	if (lvalue) {
+		lvalue = (uint32_t)div_u64(latsum, lvalue);
+		*lptr = cpu_to_le32(lvalue);
+	} else {
+		*lptr = 0;
+	}
+
+	/* Collect the bandwidth value into the driver's congesion buffer. */
+	mptr = &cp->cgn_bw_min[index];
+	*mptr = cpu_to_le16(mvalue);
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+			"2418 Congestion Info - minute (%d): %d %d %d %d %d\n",
+			index, dvalue, wvalue, *lptr, mvalue, avalue);
+
+	/* Every hour */
+	if ((phba->cgn_evt_minute % LPFC_MIN_HOUR) == 0) {
+		/* Record congestion buffer info - every hour
+		 * Collapse all minutes into an hour
+		 */
+		index = ++cp->cgn_index_hour;
+		if (cp->cgn_index_hour == LPFC_HOUR_DAY) {
+			cp->cgn_index_hour = 0;
+			index = 0;
+		}
+
+		dvalue = 0;
+		wvalue = 0;
+		lvalue = 0;
+		avalue = 0;
+		mvalue = 0;
+		mbps = 0;
+		for (i = 0; i < LPFC_MIN_HOUR; i++) {
+			dvalue += le16_to_cpu(cp->cgn_drvr_min[i]);
+			wvalue += le16_to_cpu(cp->cgn_warn_min[i]);
+			lvalue += le32_to_cpu(cp->cgn_latency_min[i]);
+			mbps += le16_to_cpu(cp->cgn_bw_min[i]);
+			avalue += le16_to_cpu(cp->cgn_alarm_min[i]);
+		}
+		if (lvalue)		/* Avg of latency averages */
+			lvalue /= LPFC_MIN_HOUR;
+		if (mbps)		/* Avg of Bandwidth averages */
+			mvalue = mbps / LPFC_MIN_HOUR;
+
+		lptr = &cp->cgn_drvr_hr[index];
+		*lptr = cpu_to_le32(dvalue);
+		lptr = &cp->cgn_warn_hr[index];
+		*lptr = cpu_to_le32(wvalue);
+		lptr = &cp->cgn_latency_hr[index];
+		*lptr = cpu_to_le32(lvalue);
+		mptr = &cp->cgn_bw_hr[index];
+		*mptr = cpu_to_le16(mvalue);
+		lptr = &cp->cgn_alarm_hr[index];
+		*lptr = cpu_to_le32(avalue);
+
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"2419 Congestion Info - hour "
+				"(%d): %d %d %d %d %d\n",
+				index, dvalue, wvalue, lvalue, mvalue, avalue);
+	}
+
+	/* Every day */
+	if ((phba->cgn_evt_minute % LPFC_MIN_DAY) == 0) {
+		/* Record congestion buffer info - every hour
+		 * Collapse all hours into a day. Rotate days
+		 * after LPFC_MAX_CGN_DAYS.
+		 */
+		index = ++cp->cgn_index_day;
+		if (cp->cgn_index_day == LPFC_MAX_CGN_DAYS) {
+			cp->cgn_index_day = 0;
+			index = 0;
+		}
+
+		/* Anytime we overwrite daily index 0, after we wrap,
+		 * we will be overwriting the oldest day, so we must
+		 * update the congestion data start time for that day.
+		 * That start time should have previously been saved after
+		 * we wrote the last days worth of data.
+		 */
+		if ((phba->hba_flag & HBA_CGN_DAY_WRAP) && index == 0) {
+			time64_to_tm(phba->cgn_daily_ts.tv_sec, 0, &broken);
+
+			cp->cgn_info_month = broken.tm_mon + 1;
+			cp->cgn_info_day = broken.tm_mday;
+			cp->cgn_info_year = broken.tm_year - 100;
+			cp->cgn_info_hour = broken.tm_hour;
+			cp->cgn_info_minute = broken.tm_min;
+			cp->cgn_info_second = broken.tm_sec;
+
+			lpfc_printf_log
+				(phba, KERN_INFO, LOG_CGN_MGMT,
+				"2646 CGNInfo idx0 Start Time: "
+				"%d/%d/%d %d:%d:%d\n",
+				cp->cgn_info_day, cp->cgn_info_month,
+				cp->cgn_info_year, cp->cgn_info_hour,
+				cp->cgn_info_minute, cp->cgn_info_second);
+		}
+
+		dvalue = 0;
+		wvalue = 0;
+		lvalue = 0;
+		mvalue = 0;
+		mbps = 0;
+		avalue = 0;
+		for (i = 0; i < LPFC_HOUR_DAY; i++) {
+			dvalue += le32_to_cpu(cp->cgn_drvr_hr[i]);
+			wvalue += le32_to_cpu(cp->cgn_warn_hr[i]);
+			lvalue += le32_to_cpu(cp->cgn_latency_hr[i]);
+			mbps += le32_to_cpu(cp->cgn_bw_hr[i]);
+			avalue += le32_to_cpu(cp->cgn_alarm_hr[i]);
+		}
+		if (lvalue)		/* Avg of latency averages */
+			lvalue /= LPFC_HOUR_DAY;
+		if (mbps)		/* Avg of Bandwidth averages */
+			mvalue = mbps / LPFC_HOUR_DAY;
+
+		lptr = &cp->cgn_drvr_day[index];
+		*lptr = cpu_to_le32(dvalue);
+		lptr = &cp->cgn_warn_day[index];
+		*lptr = cpu_to_le32(wvalue);
+		lptr = &cp->cgn_latency_day[index];
+		*lptr = cpu_to_le32(lvalue);
+		mptr = &cp->cgn_bw_day[index];
+		*mptr = cpu_to_le16(mvalue);
+		lptr = &cp->cgn_alarm_day[index];
+		*lptr = cpu_to_le32(avalue);
+
+		lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
+				"2420 Congestion Info - daily (%d): "
+				"%d %d %d %d %d\n",
+				index, dvalue, wvalue, lvalue, mvalue, avalue);
+
+		/* We just wrote LPFC_MAX_CGN_DAYS of data,
+		 * so we are wrapped on any data after this.
+		 * Save this as the start time for the next day.
+		 */
+		if (index == (LPFC_MAX_CGN_DAYS - 1)) {
+			phba->hba_flag |= HBA_CGN_DAY_WRAP;
+			ktime_get_real_ts64(&phba->cgn_daily_ts);
+		}
+	}
+
+	/* Use the frequency found in the last rcv'ed FPIN */
+	value = phba->cgn_fpin_frequency;
+	if (phba->cgn_reg_fpin & LPFC_CGN_FPIN_WARN)
+		cp->cgn_warn_freq = cpu_to_le16(value);
+	if (phba->cgn_reg_fpin & LPFC_CGN_FPIN_ALARM)
+		cp->cgn_alarm_freq = cpu_to_le16(value);
+
+	/* Frequency (in ms) Signal Warning/Signal Congestion Notifications
+	 * are received by the HBA
+	 */
+	value = phba->cgn_sig_freq;
+
+	if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ONLY ||
+	    phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM)
+		cp->cgn_warn_freq = cpu_to_le16(value);
+	if (phba->cgn_reg_signal == EDC_CG_SIG_WARN_ALARM)
+		cp->cgn_alarm_freq = cpu_to_le16(value);
+
+	lvalue = lpfc_cgn_calc_crc32(cp, LPFC_CGN_INFO_SZ,
+				     LPFC_CGN_CRC32_SEED);
+	cp->cgn_info_crc = cpu_to_le32(lvalue);
+}
+
 /**
  * lpfc_calc_cmf_latency - latency from start of rxate timer interval
  * @phba: The Hba for which this call is being executed.
@@ -5598,6 +5966,30 @@ lpfc_cmf_timer(struct hrtimer *timer)
 	}
 	phba->rx_block_cnt += div_u64(rcv, 512);  /* save 512 byte block cnt */
 
+	/* Each minute save Fabric and Driver congestion information */
+	lpfc_cgn_save_evt_cnt(phba);
+
+	/* Since we need to call lpfc_cgn_save_evt_cnt every minute, on the
+	 * minute, adjust our next timer interval, if needed, to ensure a
+	 * 1 minute granularity when we get the next timer interrupt.
+	 */
+	if (time_after(jiffies + msecs_to_jiffies(LPFC_CMF_INTERVAL),
+		       phba->cgn_evt_timestamp)) {
+		timer_interval = jiffies_to_msecs(phba->cgn_evt_timestamp -
+						  jiffies);
+		if (timer_interval <= 0)
+			timer_interval = LPFC_CMF_INTERVAL;
+
+		/* If we adjust timer_interval, max_bytes_per_interval
+		 * needs to be adjusted as well.
+		 */
+		phba->cmf_link_byte_count = div_u64(phba->cmf_max_line_rate *
+						    timer_interval, 1000);
+		if (phba->cmf_active_mode == LPFC_CFG_MONITOR)
+			phba->cmf_max_bytes_per_interval =
+				phba->cmf_link_byte_count;
+	}
+
 	/* Since total_bytes has already been zero'ed, its okay to unblock
 	 * after max_bytes_per_interval is setup.
 	 */
@@ -6503,7 +6895,8 @@ static void
 lpfc_cgn_params_parse(struct lpfc_hba *phba,
 		      struct lpfc_cgn_param *p_cgn_param, uint32_t len)
 {
-	uint32_t oldmode;
+	struct lpfc_cgn_info *cp;
+	uint32_t crc, oldmode;
 
 	/* Make sure the FW has encoded the correct magic number to
 	 * validate the congestion parameter in FW memory.
@@ -6541,6 +6934,17 @@ lpfc_cgn_params_parse(struct lpfc_hba *phba,
 		memcpy(&phba->cgn_p, p_cgn_param,
 		       sizeof(struct lpfc_cgn_param));
 
+		/* Update parameters in congestion info buffer now */
+		if (phba->cgn_i) {
+			cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
+			cp->cgn_info_mode = phba->cgn_p.cgn_param_mode;
+			cp->cgn_info_level0 = phba->cgn_p.cgn_param_level0;
+			cp->cgn_info_level1 = phba->cgn_p.cgn_param_level1;
+			cp->cgn_info_level2 = phba->cgn_p.cgn_param_level2;
+			crc = lpfc_cgn_calc_crc32(cp, LPFC_CGN_INFO_SZ,
+						  LPFC_CGN_CRC32_SEED);
+			cp->cgn_info_crc = cpu_to_le32(crc);
+		}
 		spin_unlock_irq(&phba->hbalock);
 
 		phba->cmf_active_mode = phba->cgn_p.cgn_param_mode;
@@ -12855,14 +13259,71 @@ lpfc_sli4_hba_unset(struct lpfc_hba *phba)
 		phba->pport->work_port_events = 0;
 }
 
+static uint32_t
+lpfc_cgn_crc32(uint32_t crc, u8 byte)
+{
+	uint32_t msb = 0;
+	uint32_t bit;
+
+	for (bit = 0; bit < 8; bit++) {
+		msb = (crc >> 31) & 1;
+		crc <<= 1;
+
+		if (msb ^ (byte & 1)) {
+			crc ^= LPFC_CGN_CRC32_MAGIC_NUMBER;
+			crc |= 1;
+		}
+		byte >>= 1;
+	}
+	return crc;
+}
+
+static uint32_t
+lpfc_cgn_reverse_bits(uint32_t wd)
+{
+	uint32_t result = 0;
+	uint32_t i;
+
+	for (i = 0; i < 32; i++) {
+		result <<= 1;
+		result |= (1 & (wd >> i));
+	}
+	return result;
+}
+
+/*
+ * The routine corresponds with the algorithm the HBA firmware
+ * uses to validate the data integrity.
+ */
+uint32_t
+lpfc_cgn_calc_crc32(void *ptr, uint32_t byteLen, uint32_t crc)
+{
+	uint32_t  i;
+	uint32_t result;
+	uint8_t  *data = (uint8_t *)ptr;
+
+	for (i = 0; i < byteLen; ++i)
+		crc = lpfc_cgn_crc32(crc, data[i]);
+
+	result = ~lpfc_cgn_reverse_bits(crc);
+	return result;
+}
+
 void
 lpfc_init_congestion_buf(struct lpfc_hba *phba)
 {
+	struct lpfc_cgn_info *cp;
+	struct timespec64 cmpl_time;
+	struct tm broken;
+	uint16_t size;
+	uint32_t crc;
+
 	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
 			"6235 INIT Congestion Buffer %p\n", phba->cgn_i);
 
 	if (!phba->cgn_i)
 		return;
+	cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
 
 	atomic_set(&phba->cgn_fabric_warn_cnt, 0);
 	atomic_set(&phba->cgn_fabric_alarm_cnt, 0);
@@ -12875,6 +13336,47 @@ lpfc_init_congestion_buf(struct lpfc_hba *phba)
 	atomic_set(&phba->cgn_latency_evt_cnt, 0);
 	atomic64_set(&phba->cgn_latency_evt, 0);
 	phba->cgn_evt_minute = 0;
+	phba->hba_flag &= ~HBA_CGN_DAY_WRAP;
+
+	memset(cp, 0xff, LPFC_CGN_DATA_SIZE);
+	cp->cgn_info_size = cpu_to_le16(LPFC_CGN_INFO_SZ);
+	cp->cgn_info_version = LPFC_CGN_INFO_V3;
+
+	/* cgn parameters */
+	cp->cgn_info_mode = phba->cgn_p.cgn_param_mode;
+	cp->cgn_info_level0 = phba->cgn_p.cgn_param_level0;
+	cp->cgn_info_level1 = phba->cgn_p.cgn_param_level1;
+	cp->cgn_info_level2 = phba->cgn_p.cgn_param_level2;
+
+	ktime_get_real_ts64(&cmpl_time);
+	time64_to_tm(cmpl_time.tv_sec, 0, &broken);
+
+	cp->cgn_info_month = broken.tm_mon + 1;
+	cp->cgn_info_day = broken.tm_mday;
+	cp->cgn_info_year = broken.tm_year - 100; /* relative to 2000 */
+	cp->cgn_info_hour = broken.tm_hour;
+	cp->cgn_info_minute = broken.tm_min;
+	cp->cgn_info_second = broken.tm_sec;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT | LOG_INIT,
+			"2643 CGNInfo Init: Start Time "
+			"%d/%d/%d %d:%d:%d\n",
+			cp->cgn_info_day, cp->cgn_info_month,
+			cp->cgn_info_year, cp->cgn_info_hour,
+			cp->cgn_info_minute, cp->cgn_info_second);
+
+	/* Fill in default LUN qdepth */
+	if (phba->pport) {
+		size = (uint16_t)(phba->pport->cfg_lun_queue_depth);
+		cp->cgn_lunq = cpu_to_le16(size);
+	}
+
+	/* last used Index initialized to 0xff already */
+
+	cp->cgn_warn_freq = LPFC_FPIN_INIT_FREQ;
+	cp->cgn_alarm_freq = LPFC_FPIN_INIT_FREQ;
+	crc = lpfc_cgn_calc_crc32(cp, LPFC_CGN_INFO_SZ, LPFC_CGN_CRC32_SEED);
+	cp->cgn_info_crc = cpu_to_le32(crc);
 
 	phba->cgn_evt_timestamp = jiffies +
 		msecs_to_jiffies(LPFC_CGN_TIMER_TO_MIN);
@@ -12883,11 +13385,38 @@ lpfc_init_congestion_buf(struct lpfc_hba *phba)
 void
 lpfc_init_congestion_stat(struct lpfc_hba *phba)
 {
+	struct lpfc_cgn_info *cp;
+	struct timespec64 cmpl_time;
+	struct tm broken;
+	uint32_t crc;
+
 	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT,
 			"6236 INIT Congestion Stat %p\n", phba->cgn_i);
 
 	if (!phba->cgn_i)
 		return;
+
+	cp = (struct lpfc_cgn_info *)phba->cgn_i->virt;
+	memset(&cp->cgn_stat_npm, 0, LPFC_CGN_STAT_SIZE);
+
+	ktime_get_real_ts64(&cmpl_time);
+	time64_to_tm(cmpl_time.tv_sec, 0, &broken);
+
+	cp->cgn_stat_month = broken.tm_mon + 1;
+	cp->cgn_stat_day = broken.tm_mday;
+	cp->cgn_stat_year = broken.tm_year - 100; /* relative to 2000 */
+	cp->cgn_stat_hour = broken.tm_hour;
+	cp->cgn_stat_minute = broken.tm_min;
+
+	lpfc_printf_log(phba, KERN_INFO, LOG_CGN_MGMT | LOG_INIT,
+			"2647 CGNstat Init: Start Time "
+			"%d/%d/%d %d:%d\n",
+			cp->cgn_stat_day, cp->cgn_stat_month,
+			cp->cgn_stat_year, cp->cgn_stat_hour,
+			cp->cgn_stat_minute);
+
+	crc = lpfc_cgn_calc_crc32(cp, LPFC_CGN_INFO_SZ, LPFC_CGN_CRC32_SEED);
+	cp->cgn_info_crc = cpu_to_le32(crc);
 }
 
 /**
-- 
2.26.2

