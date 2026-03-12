Return-Path: <linux-scsi+bounces-21946-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMIkM9ots2ksSwAAu9opvQ
	(envelope-from <linux-scsi+bounces-21946-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:19:22 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6737F279EDB
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 22:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C78E317FC65
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 21:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3973C5532;
	Thu, 12 Mar 2026 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rrf/EtlP"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B67336895
	for <linux-scsi@vger.kernel.org>; Thu, 12 Mar 2026 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773350241; cv=none; b=qUTXqOwRxkX4uiZpVUGwO2jkwTHHfGp0HF6iuItPiRFx82yH2KGVjHSdANuWhe2rzIbI9aqLBW7B2LGpMIS0EzVrvkrt+/Vmo3c0gyDYgA9SdVHYXg086kYcAbfAJYpTjTTk+aJqqoHwHICX8iwqKIhs4R7WC21X69VubncHXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773350241; c=relaxed/simple;
	bh=V12Pc5OMX1UvVv3hRPpz6eFRvy1OPNOixc+HWskkBxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZTbkDaAlhkFwqwlehW8Z19ZE3fPHEG4AbhQCjMc2jygXoxsi5X7wmsCyfc1busxztsr55jbxV2jcS/12+u/bDVXkgYN1yG6pmQ9UZe15WSp6MI/KPB8YRGG9m0okw196akRgSklvXzGnwAx8x1WUKOdYFcZr84vHN5Ia7qE1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rrf/EtlP; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fX0nD05cnzlfl5W;
	Thu, 12 Mar 2026 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773350237; x=1775942238; bh=7QCpp
	/jc4hIAmCgYIIxH8fAFq+e/dPOfLojEBHq/Ti8=; b=rrf/EtlPT9ZrSUMFigLZ/
	EIyQySBkoerr6B5fTtmdgTpBFKoC2nuM/DqEeT2Qfgq8pC001//Hbk8nSqUznR96
	JBBLnZChEprCVGO6QbQPc0AFuDwmCifg4P/VYPLUiOVgGjQbVjONzCAsfnpFBfGV
	ND6rgdEzLU4sh4LUc4WiaJygyFgbgCmno4WKgdQwHZgJ52FEnsvkTkzRZqIfo4OD
	cbxBbFOP3hBo2YxBTvCDb7lLLnE19CKFjY+5Jm/pIDM5oMS65MHQ46/rPJrDDELx
	p1c/05DbQN4Jg+AnczCV3zgZWPITtUytgjs2E5jZIesvDnUk2ybOerLcw0T+tWXW
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rznxmH-eRjqD; Thu, 12 Mar 2026 21:17:17 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fX0n8479jzlfl5V;
	Thu, 12 Mar 2026 21:17:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Khalid Aziz <khalid@gonehiking.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH 06/36] scsi: BusLogic: Prepare for enabling lock context analysis
Date: Thu, 12 Mar 2026 14:15:17 -0700
Message-ID: <20260312211636.3245119-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260312211636.3245119-1-bvanassche@acm.org>
References: <20260312211636.3245119-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21946-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6737F279EDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document locking requirements with __must_hold().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/BusLogic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index e3790ff24e56..bb5a63baf897 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2879,6 +2879,7 @@ static int blogic_hostreset(struct scsi_cmnd *SCpnt=
)
 */
=20
 static enum scsi_qc_status blogic_qcmd_lck(struct scsi_cmnd *command)
+	__must_hold(command->device->host->host_lock)
 {
 	void (*comp_cb)(struct scsi_cmnd *) =3D scsi_done;
 	struct blogic_adapter *adapter =3D
@@ -3183,6 +3184,7 @@ static int blogic_abort(struct scsi_cmnd *command)
 */
=20
 static int blogic_resetadapter(struct blogic_adapter *adapter, bool hard=
_reset)
+	__must_hold(adapter->scsi_host->host_lock)
 {
 	struct blogic_ccb *ccb;
 	int tgt_id;

