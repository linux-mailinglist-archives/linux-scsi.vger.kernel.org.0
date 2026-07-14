Return-Path: <linux-scsi+bounces-26080-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tNtvK9qEVWpSpgAAu9opvQ
	(envelope-from <linux-scsi+bounces-26080-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:37:46 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFD674FE07
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 02:37:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=S+Wd7jMf;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26080-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26080-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B431B301667B
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 00:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F584757EA;
	Tue, 14 Jul 2026 00:37:45 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31B61A9F8D
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 00:37:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783989465; cv=none; b=fpyHjDfLFxg3W6F6PC7l494pfojH2PtcmIxOA53Gm3z1fu0YCSgcCpy2NO+HIvL0XTgZKP6EGIgJnPedP8KWMp+3ZRcqEny4w2mASTsMgX0cURmrdU2tqZtTk4nyCZI7/uNvSpi4D01Y0k6k/ACuVkuixtjvFsc4WVigwQYqzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783989465; c=relaxed/simple;
	bh=+3m0JMdiXpuvCHnm1FRh68WRusl50l4Rbyh/OO5Hrs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5VNByKpj4axK67VGhoqUVOPTs7HztxS+gxkw0dQKGFi3NG5CZhPPlhx++J16GmRD9xWZjtjzL6ZBUClzGGlWS3Msq/kSZKi/gBk4dS37YJOJAjN20hTXy1Vaag0mhZlinTDiNvmX9qJJQnVn14flO78/rNPaxGL49vF8v0q0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+Wd7jMf; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e7632b193so42779185a.2
        for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 17:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783989463; x=1784594263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4r68B/dC8VXpyqdhvL5gBI3YcpNd9ejYho5aID98pyU=;
        b=S+Wd7jMfwF1JgpOWRrcMoKhZNdzt7keCqGColLEW36RV4+h+n9DgEfA/WPPF32vBuc
         gbZuJi6O0V7whZqQn7rPlk4u3CFhkSOfEvXBe8l7UqLSOR8tyB0+zj91WvmR4Fzn/xLR
         DvGULguJY5cBhQ7ZcDde2gA3DHtwsjs/CS1cUgu5d2L8pWg3i4/hUwQdqTZ9z5aDydMI
         HxtMlErQrrxksvN9SMMuY87vYDlhBVi2LQz8lByx020FjzvqooYlaMNbFDz7VhpAKWi2
         51WHRuq7Lca6h5BaxykIydM7/6BEPVnXzvk0XHKI5FkdB7pZH+H3OWsZU5kuquRFFDhP
         92nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783989463; x=1784594263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4r68B/dC8VXpyqdhvL5gBI3YcpNd9ejYho5aID98pyU=;
        b=iqln/LcrdUZuyG1Wp/iq6S3wW2TF1UuCn5f6Yxe+sTEFzfDd9byp8ifaenRSIvbvo0
         Z8Jl3cRuL+M1A+DvEQ76KhQrT56edizcAT9u8LDBS/ga8Ul7B1br+VgqHMd4jO8LIrLc
         sFtV+70IG2Ph909c/vRq64VK6niYLbmdqal+TNDklVTNsoLN118fDdNGUluelw0cdP0x
         kfL8ZTMuz5tqWqAjimjCiHQkgkVLTwrNMbdb7Q7V/RmOLJwqXMSXSEozTr0KvVyhKt9r
         P9vRduxMz9desiWjgRzKJ6Ndfsj8sJxHENQZHBIB5RpwO6olQ0y1+Pn0W/0uTC2KvtBA
         CcBw==
X-Gm-Message-State: AOJu0Yw3jy9gyWnK95qSUwCtyxRkT+Kb7HXFdRFIyQUD02dEqrjMgmnV
	lvXeXaMRs27htGoFoXWghIZyCUAtGwlOW5st5IrS5j0TC+YtwTaLeyhIbZDWQtU/gOk=
X-Gm-Gg: AfdE7ckeqV7EzGe4AhD9UQDIHpzUUYZDB7F9O5WAs32VthEp6GfasT41Y9Nj2phYpZt
	NCDhCJIwHy/ZwapDgRei7cVCmPlZVU18nj1pjAma8qEo5NORim5Jtxi/CNrnP0RWGFaIBa2OnmE
	InkO+sVV497YA95Gl1JE9eiD2mRR6IH8KvV5ovuG3GXVmOiK/ykI5n/+lo07xxHl7boNk0/anIc
	no6HumvL/qwzlZruw4zBO3qdYFTbxpPlRzBJV0A9ItfAeWqR1yhBmwWL7vmWcEyA5cZqKmy6K2x
	fhqpqq5CEHN7qXFs1KUgruR0voEeI196lIG7Xm7Ly4asDhqbuRTvF8PI5b00d8pGSeLk5HL+6Ce
	hJLkxCycBmyO7h5kPPU6J8M76/NYv4x0XVr4Yz/Jpi3BQsg5HO5L0JmcRWVerzGDhmrzYvqOu5y
	uyY2HuBCXsqhDwZ+zwnpSRI9ZbZeHzPVKr1FI8Btu8vtwzh6vS02NBA1O3G/7u6T5vX/1mV3Xl3
	5dkW+8dbwrXTBIEMhHrx3nhO3/EQDfi
X-Received: by 2002:a05:620a:45ab:b0:915:6453:1ae with SMTP id af79cd13be357-92ef2b35176mr1153129385a.14.1783989462901;
        Mon, 13 Jul 2026 17:37:42 -0700 (PDT)
Received: from dhcp-10-231-55-133.dhcp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d6c28bsm1289899185a.46.2026.07.13.17.37.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2026 17:37:42 -0700 (PDT)
From: Justin Tee <justintee8345@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: jsmart833426@gmail.com,
	justin.tee@broadcom.com,
	Justin Tee <justintee8345@gmail.com>
Subject: [PATCH v3 02/14] lpfc: Early return out of lpfc_els_abort when HBA_SETUP flag is not set
Date: Mon, 13 Jul 2026 18:18:00 -0700
Message-Id: <20260714011812.106753-3-justintee8345@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-26080-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CFD674FE07

It is possible that a dev_loss_tmo callback fires during an hba reset.
The ELS pring structure is cleared by the hba reset path and the
dev_loss_tmo callback executing lpfc_els_abort could be using a stale ELS
pring pointer.  To prevent such a condition, check if HBA_SETUP flag is set
before proceeding to use the ELS pring pointer in lpfc_els_abort. There is
no point to issue aborts when the sli port is not setup anyways.

Signed-off-by: Justin Tee <justintee8345@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nportdisc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nportdisc.c b/drivers/scsi/lpfc/lpfc_nportdisc.c
index 9c449055a55e..2c8d995a45bf 100644
--- a/drivers/scsi/lpfc/lpfc_nportdisc.c
+++ b/drivers/scsi/lpfc/lpfc_nportdisc.c
@@ -227,6 +227,11 @@ lpfc_els_abort(struct lpfc_hba *phba, struct lpfc_nodelist *ndlp)
 	struct lpfc_iocbq *iocb, *next_iocb;
 	int retval = 0;
 
+	/* Exit early to prevent race with queue teardown. */
+	if (unlikely(phba->sli_rev == LPFC_SLI_REV4 &&
+		     !test_bit(HBA_SETUP, &phba->hba_flag)))
+		return;
+
 	pring = lpfc_phba_elsring(phba);
 
 	/* In case of error recovery path, we might have a NULL pring here */
-- 
2.38.0


