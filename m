Return-Path: <linux-scsi+bounces-26079-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LMDzNduEVWpVpgAAu9opvQ
	(envelope-from <linux-scsi+bounces-26079-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:37:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E1B74FE0C
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:37:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=StTVpgbv;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26079-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26079-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A7893008FD5
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 00:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB11DED5B;
	Tue, 14 Jul 2026 00:37:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794C78C9C
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 00:37:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989463; cv=none; b=hnjI35kPZF0B8APDyco3xpy8NrBMY0heto4ipgASgygsctqGiNTtcMM2l+rtfg8SFRPaLp1rs5GPYduA12e02g8DaWKSPUdHukXUhZgUw4kQammfk9rO7lwzoQN2JeNqy1U9aTWB/tMoj3Fg6MWxYbN81DreHkXEgIKif1uIX9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989463; c=relaxed/simple;
	bh=XDJSA9ARqSXKjDURqUbtMPI2B17diU6ylGKvLmSJAVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYsvThXbSGHBBclJ1DmUyvbVRHa13tiiBpqNjl82ufRMKySK9ajNQTdJrZURg8Z2m4ZleRpioNiq60IS5WQ8T9qBZY0r2Fud2MSimITHu4xMcZT3G1rpWpNCL3lMbl9L0XFU0tNbb8gY7H/5SDGtcd1gCp+9puXOsUSLeW8hQaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StTVpgbv; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9305a2121a1so56441985a.2
        for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 17:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783989461; x=1784594261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dmCG1d3AlAtiNH3LEYA0GcaDkoTjkg6k8fP4s7NLwiE=;
        b=StTVpgbv0ZmpsxFMOzWXWUv/zAZ7QFLpFjbm2czh5B3koS4QGnq5CHxDkQL4pSNvlO
         DNyUZ2zJSNAgy7WARjQjDQHtq1SqxIOLCbVCLNV8s+Y+BRptgto1u4384GlKpXWAkHnq
         MH76ogyMtzhat33IVwNDo76CVdi7YHmdP8FF1N4gEgkq7N1fVY2cf/QV71F91Y5v4ivG
         p9pyHjf9+4lCCjb0YR1yFuXHCFj/7blZY6a0UJeuTF1uxXCi4jt4ifCgEWlnZgCA+ehn
         cbqpYL6mxxL3+VtUMovMhe1p0W11/DEiNeGeRCAOD4WMwYUM+NIu4E3YD1+aiwPuxJuD
         XBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783989461; x=1784594261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dmCG1d3AlAtiNH3LEYA0GcaDkoTjkg6k8fP4s7NLwiE=;
        b=M9WVccM81OnGFIajnYPMuV72FYt7PxSrK4F1bIcBBG2wivDQxIG2C1pDGNYm0EmJkh
         8mPG2RnhVMfXeO75HlnunfDxnuGRZE1JnpB7eCf369mMwYalQPuUwUbS3p8UsRSZQM82
         MQHSi/jNBfffr7tl91g1OTlRy6v92qFDnR4p4t3DzBv2lbdXelj0nXeQclMH5TwT5efb
         TFbfbBOPZaS5DzK/NYkOlYbGoMSnWqRAT8yGhy7bRfyaKYuyjVBGgG6ZuYsH2lp5nAag
         MOzHcM0bL6zDsFH1SyNM4EUtJVuc+MWz6JhxJPboW1CaHoJpji2+1LHAmgk4onGqfgXs
         NbGg==
X-Gm-Message-State: AOJu0YyzHR1he1KqKKTo1QbboMsejD/uDMolLkdMbODLqbjucoWDSl5P
	6qBlqHTKbaG7zBOLFp4ktke1Lw+ehYa+9diyJmL2YbK+tyAtngdVAX1gZDKZqBh3SYY=
X-Gm-Gg: AfdE7cmjOL2gAtAmoTfdS2CLMC5xnnypCJn0w/Io0p+VQ1FXE379kcPha4Kigm7KiRS
	6Itt92ekS1HeGgM2Sn0rwr3nsWvSvkgVbZxs4qGPYzJn2/FPhOsanaZBn0eeeHdTkWZXRQ4zsWh
	ZIU5WGJIEN6TJj9GKgEsuFM0949Yjj+ktFSEacWk5sAG+sVXxqG93NobVixMZ7hHs2OaX0fqh1h
	ZODt/cAak1G6yJ9+Quyy4mk/dq1YG6zJt69znftiSjrdKcmtbV+i28aXfJRJinEQ8D31qxYuJqB
	dCkSFkLHnA8U9KmkzHYzoS9f/DKqmzlG8sH1r5vyNUkBFM6+XnqM0kSSRAsWiUZSZTVVtjI49jT
	BUXHiIrSRHxVPlZJrnvE6S/KBQJcNyJpKiAvwqvP/CzZv/70I1CiEzZO+CgzGDfc3Ho8CUwCVTT
	hJ9O4J1qHbhsPZxzYbB7GN0Ei9+Wpdu7s8X0C3LfyWbmwTuPs9fDmQTgWmwma+GnzzMBeYZ9e3v
	KdYTlf3aybDSHqwxbLgg2N2KxBawejnnsjEnbTMZcyLS/e/R639LA==
X-Received: by 2002:a05:620a:2941:b0:92e:cac7:9705 with SMTP id af79cd13be357-92ef2bb3bd5mr1280804985a.35.1783989461279;
        Mon, 13 Jul 2026 17:37:41 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1289899185a.46.2026.07.13.17.37.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 17:37:41 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart833426@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH v3 01/14] lpfc: Fix use-after-free in lpfc_cmpl_ct_cmd_vmid
Date: Mon, 13 Jul 2026 18:17:59 -0700
Message-Id: <20260714011812.106753-2-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20260714011812.106753-1-justintee8345@gmail.com>
References: <20260714011812.106753-1-justintee8345@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-26079-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-scsi@vger.kernel.org,m:jsmart833426@gmail.com,m:justin.tee@broadcom.com,m:justintee8345@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0E1B74FE0C

In lpfc_cmpl_ct_cmd_vmid, there is an early call to lpfc_ct_free_iocb when
cmd is SLI_CTAS_DALLAPP_ID.  Within lpfc_ct_free_iocb the
cmdiocb->rsp_dmabuf will be freed.  This means any ctrsp ptr dereference
for SLI_CT_RESPONSE_FS_RJT or even ctrsp->ReasonCode and ctrsp->Explanation
when handling a CT LS_RJT response is a use-after-free.

Remove the early lpfc_ct_free_iocb call for SLI_CTAS_DALLAPP_ID.  There
already is a free_res label that calls lpfc_ct_free_iocb so there doesn't
need to be an early lpfc_ct_free_iocb at the start of
lpfc_cmpl_ct_cmd_vmid.

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/scsi/lpfc/lpfc_ct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index c7853e7fe071..e14170550e69 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -3595,8 +3595,6 @@ lpfc_cmpl_ct_cmd_vmid(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	int i;
 
 	cmd = be16_to_cpu(ctcmd->CommandResponse.bits.CmdRsp);
-	if (cmd == SLI_CTAS_DALLAPP_ID)
-		lpfc_ct_free_iocb(phba, cmdiocb);
 
 	if (lpfc_els_chk_latt(vport) || get_job_ulpstatus(phba, rspiocb)) {
 		if (cmd != SLI_CTAS_DALLAPP_ID)
-- 
2.38.0


