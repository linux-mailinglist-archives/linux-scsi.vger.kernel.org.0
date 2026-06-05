Return-Path: <linux-scsi+bounces-24495-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRK9AzkLI2oWhAEAu9opvQ
	(envelope-from <linux-scsi+bounces-24495-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 19:45:29 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992C64A4AB
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 19:45:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gocC16Pd;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24495-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24495-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10708300C259
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 17:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F2C1A683A;
	Fri,  5 Jun 2026 17:45:19 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F10362130
	for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2026 17:45:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780681518; cv=none; b=ZJ+segxNQRaVxQHAnj7YcFRDy4N/dAHSWMYUiTyOes+gPB1aTHznsULGTJrdA3Jz6N8x762QSDzXpPutCUqz64CPxUFgEq8KyEfiIQZNDVGvTTEFTVQm2eHliKi8pM/qmTpr8yDB+FD7FiCDe8tgkyYLs1q+kvtbm3NiJKzw6tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780681518; c=relaxed/simple;
	bh=XDJSA9ARqSXKjDURqUbtMPI2B17diU6ylGKvLmSJAVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vq5ii2Eg/IasQmYQDKPEKF8em42MT6XOlPhl7szYWrEPgWyQ5IOp965UL8Z/h6S56R4Ui7Tqfu29rrDn2vteOkSQEj4ghE6FnkT6gLMVUt24cd5Vfpm8uj31cZw9RZgEa7GgQiW2RmcjNAWaOrO0kHE/15066cVlC6FpsN7W+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gocC16Pd; arc=none smtp.client-ip=74.125.82.169
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-30759632453so1631139eec.1
        for <linux-scsi@vger.kernel.org>; Fri, 05 Jun 2026 10:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780681505; x=1781286305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmCG1d3AlAtiNH3LEYA0GcaDkoTjkg6k8fP4s7NLwiE=;
        b=gocC16PdtJAGDz5ce+Dlq8i9RgIsrmV9Nh/uyHYbH4PMmmZEMDfKfz2MAEnONdYtaI
         VXNAbcpSGefd6rfPwffb0HlnQSGGWMtFf/stYJtXEfqHYLd9Zf6V9vPds2i9bUFkeMsB
         yzlOtMFzZ6No0JZ+Y2ZMOt7auOYHWd9QN4PzAI0FXC00h+B3z5XatIlqJFDeilPpJ+PV
         fGYnmitCc4iSuDrd2b/kPz27Ectuk847zhehzOgtX+gcqtM1UfTbw2e5JvTjb40n96jW
         1jnNhcftRv3ZdP9H2rHZ7OOMsvKR1usgojzFJ19sxZxQxDvOt3DYznSh6CShdg58dbNt
         QqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780681505; x=1781286305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dmCG1d3AlAtiNH3LEYA0GcaDkoTjkg6k8fP4s7NLwiE=;
        b=iM22ZKJXgl+0mz3NVvKRv3q3lZ6QI66Qr86p18nIxZiswLEgKdgjx9WtuFatyOuig2
         8bty6q7ZM3fzc5cH4c5Nw0YNHa5Fos4u7nNg+UwxSgO5Xfo3agAy6G/Qr0XZAo3o5qOo
         fmNiWIP6ce2thyavEDPG/N6cZ6QlP3Ldtqf39NdVs0Tog8cDb/YvjuozbxE+q4PKlzHB
         P6B2Gc5dMD4OnDU84Pr7Q0pE0g+yg5IACvAVFy0v3NCUxH+I899kIxp8I962KeXigucg
         yf4CsYxLhAAAJUQWJG7Ilb2dEThdggq6ys03qdVwRxBAfwKvptxxjMq60u7SO7MqMI/q
         BX/A==
X-Gm-Message-State: AOJu0Yz4k6iCtRbOT0GSnzFLd3ko40EqCheNMXmCNcgtaOO1Wa2DUtdB
	Rq0c5n9jJJzin0edJHVpbh6W8fSvGn7E23LGdOvQzHNwX8BjaW4PDSWDBVjE+6i9
X-Gm-Gg: Acq92OG2GH36yZCGmz/j3rmvHwbcws07uq4ImHTRc/JTPW4GaTzslS8Yk1rAUQ4IvDH
	OSTccdWV1owwQQxVOoMUKBJXW1f0nZAlOc7UnsL8xaSbYRp7IKMWO86eybrjFVdiDVtLhbuX3JE
	2tcu/W+AmDBbJtkA4YCxjv6FFMo8AFq8RDXg9Fwg4OwHqytmBknDs8Y0XnPVu4+C/3KhBa4PaZu
	you+0iOuSqquzvuU93oJfeKVd8sx+ygY/FeZ4t7l3a9Z0dyJlQemixVQRrLafkU1UCybAIz83C9
	jGLIqtH2bILwsfKB1oLiOSBub1+PC5uAIS8Ngok5776L8Rx+0ZNuBcVmWsJInV1tCN44YatnbK5
	tbg3fLpvBEAMwp0Xkk1UokHJMMiJW/2L+2OF7KsD0GVC0MY0g8Ai63XVRPfVW5SsxlMvCn9yct8
	1EU2VKP6jA7GOSxfMuhqNpiPxl0dk4SEmgol7eShjChZUmLYn1afWyMGiIXAD55rmLbh4b4S95C
	T+mmOwVqiEycfHoxkym/laF0PSl6xjEUNJfzcAcdhewboiHMAGibA==
X-Received: by 2002:ac8:59d6:0:b0:50b:38c1:c6a with SMTP id d75a77b69052e-517959fdda5mr66006841cf.19.1780681494607;
        Fri, 05 Jun 2026 10:44:54 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51789407da8sm53376171cf.19.2026.06.05.10.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2026 10:44:54 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart833426@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH v2 01/14] lpfc: Fix use-after-free in lpfc_cmpl_ct_cmd_vmid
Date: Fri,  5 Jun 2026 11:23:23 -0700
Message-Id: <20260605182336.134919-2-justintee8345@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20260605182336.134919-1-justintee8345@gmail.com>
References: <20260605182336.134919-1-justintee8345@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-24495-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8992C64A4AB

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


