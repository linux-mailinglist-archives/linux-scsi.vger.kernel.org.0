Return-Path: <linux-scsi+bounces-26115-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ooIUOuvqVWpsvwAAu9opvQ
	(envelope-from <linux-scsi+bounces-26115-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 09:53:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E156E752161
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 09:53:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=knnFjUOL;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26115-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26115-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF220301AE7D
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 07:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD963EEAF0;
	Tue, 14 Jul 2026 07:37:02 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3909E3F075A
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 07:36:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014621; cv=none; b=uv3RdY8t2S5K6Pnw3++T++lACysMecNE5uBbDTCz02Bonzni29nljZ5Qj2Vu8/aLDHjRfYoM8X4ZJ8+QnUQN2zdXfr9GTTTJhO9qlJtNF9u7b3CORNGNXxM/KA2cTJyIOTP/Cw6Oy9FzAHs2QofPecB/zk8tjWAMMvk7QQ9xPbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014621; c=relaxed/simple;
	bh=XD8dmnDn9DEsDWuychVmn3KpB1RjOppHzuB5zqBo6ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=DxLzUJjFmPSABZa961xgML11twyUcII/BY4IUWVLZB4qkjTEvAJU9ZzH9WiCCVCagGb06HMHfm271A1LJIy3J4qvsKFxwyu7Xcsg+KBkRcq/C7g4CVxhKan9j1PtNPHSsueERsBMXI5ER7kkI/wgjtu12uNAXDLsPeiu2mDrxF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knnFjUOL; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47de008b020so335865f8f.1
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 00:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784014616; x=1784619416; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:content-type:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ApZjn7xytwk2Zv5kSJldvGb4QFyiTuyC5Qq2jVIAl08=;
        b=knnFjUOLZLv9UPn8Wyxxs16/fxU7EumyjvuuukVqsIxjQP8l5+LgjF2GxAlKmiVoOU
         3Cp6Duk0uD62NPMa14ki0msnKaOvjDZGDGS/wpEJ/4rhfl6xvw/R9s4DRiGN2HMx0ksv
         lf1vJSxAHoyOiIf5RDvwP/tAKUMcpWv32PFN3IH4M7RQb7Bdps2heDLLFy9Um3vB0uds
         BVDs6eS4Ggw2fcMh53gM3xvSINcczlFnX7F1hXJ1TGFcTVR8eSMGCEE1Sa1MO0pB7Llm
         cXIEr2rACgviz0neS6TiJUHMO/3isu2Jdi/vBDf75K997upICZqZPY+PMnErDqyWvgpi
         lwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784014616; x=1784619416;
        h=content-transfer-encoding:content-type:content-type:mime-version
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ApZjn7xytwk2Zv5kSJldvGb4QFyiTuyC5Qq2jVIAl08=;
        b=ahB71xYU+5kAPaFL0mXcHR5DJo+3p9fd4ekZLFKQOQ1lGW0nu4X3JsuwYzW5x+dDRk
         FARll+Ja8ePwRgJjQ94h1y/cmGAbzfsSF78rfjwpAx3gMIa8pe+QIvCt51hhV4WZOas7
         8fzOBLjEt4JTNgBnvVFwVLejFxHO8f7d4Ub9k16LGStrplz5yDgGIZqKbzVuHOr2Ibda
         7ndi+movV3cQrqnC/hmL85z1Vc38BrQBNylI/oKbI9XNd8TtwwNi3+K6OsUbVbgnhxmF
         ao7Ofgi9+WMwwOGDNArsJrTNZvdYBZZXI/eW8+JUI7EA0g19C1ihfRj40JOtY1fEnWe8
         Pvsg==
X-Forwarded-Encrypted: i=1; AHgh+Rqrif572esRPd2asOLlwJ6v1kSjIp+G4xJWnLEvWe4WHqpA0s4snSlzuLIpUyzuxuGErXqBznUo9KTN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb36mgfkg4KkqdDpVkUBvLEtsFqRinJ2ibb1hbeQyBBbgxDIJl
	iGxmYpSZsvySfGNEbgMnRvQiDEz00y2V8/0l7Dqj02KAVpdMV1G4ZFVShjWdcXwr
X-Gm-Gg: AfdE7cnfcXsfdOcEDRmUS6UYrfgRjycHgllszXOO/O2yoJxLuB2AqzMy+5L9Fpvr/iE
	1ZBXKl3o7QzTyFLvB2O3mrfGpovjaT+DXAz8H7Vpb/5GlLZ/njJCgY4w5h1nhCFtkjZjsmPX+6K
	dh4NMT9V4USHxuDt/RJTFnGRVcwDdmSO76JWIuKmhEzjblWHtHTwC35l0br37HGK+vJZK7xyRcb
	iPMFNYkpt1o4a7atUziM+bb4rfQ62P/YSSeXG6858aSHAHPJI84jFEjtPhtPUwxQaf3bWOuAFgh
	C4P04yREwsw63SQxMGB5Cc3Yky1qm8554CYmvFMJiH08yAo9WvkyEUhOpDlDbre4WfDeFF0xaKw
	wIklywsiwrKURPclW4Rr/4Avr9VW/PluAoM4WJWR05p4+SaxQITyVolIEVnL5jhPi5HTRdNMGtm
	dp84RcdGnHpHk=
X-Received: by 2002:a05:6000:22ca:b0:47e:4379:a4ed with SMTP id ffacd0b85a97d-47f2dcd9e36mr15046072f8f.30.1784014616041;
        Tue, 14 Jul 2026 00:36:56 -0700 (PDT)
Received: from localhost ([5.83.201.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a96cfsm6344230f8f.20.2026.07.14.00.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:36:55 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Ali Akcaagac <aliakc@web.de>,
	Jamie Lenehan <lenehan@twibble.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: dc395x: remove unused variable fact
Date: Tue, 14 Jul 2026 08:35:10 +0100
Message-ID: <20260714073510.43289-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [4.84 / 15.00];
	MULTIPLE_UNIQUE_HEADERS(7.00)[Content-Type];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-26115-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:oliver@neukum.org,m:aliakc@web.de,m:lenehan@twibble.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER(0.00)[coliniking@gmail.com,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[neukum.org,web.de,twibble.org,HansenPartnership.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coliniking@gmail.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E156E752161

The variable fact was used for debug but this was removed
in commit 62b434b0db2c ("scsi: dc395x: Remove DEBUG conditional
compilation"). The variable is now redundant and can be removed.

Cleans up clang scan build warning:
drivers/scsi/dc395x.c: In function ‘msgin_set_sync’:
drivers/scsi/dc395x.c:2185:13: warning: variable ‘fact’ set but not used [-Wunused-but-set-variable]
 2185 |         int fact;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/scsi/dc395x.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 6183ce05d8cf..ba490174a417 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -2182,7 +2182,6 @@ static void msgin_set_sync(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb)
 {
 	struct DeviceCtlBlk *dcb = srb->dcb;
 	u8 bval;
-	int fact;
 
 	if (srb->msgin_buf[4] > 15)
 		srb->msgin_buf[4] = 15;
@@ -2205,11 +2204,6 @@ static void msgin_set_sync(struct AdapterCtlBlk *acb, struct ScsiReqBlk *srb)
 	dcb->sync_period |= ALT_SYNC | bval;
 	dcb->min_nego_period = srb->msgin_buf[3];
 
-	if (dcb->sync_period & WIDE_SYNC)
-		fact = 500;
-	else
-		fact = 250;
-
 	if (!(srb->state & SRB_DO_SYNC_NEGO)) {
 		/* Reply with corrected SDTR Message */
 
-- 
2.53.0


