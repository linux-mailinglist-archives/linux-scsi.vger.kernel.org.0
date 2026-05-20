Return-Path: <linux-scsi+bounces-23932-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qImZFo9lDWquwgUAu9opvQ
	(envelope-from <linux-scsi+bounces-23932-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2026 09:41:03 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D8589103
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2026 09:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75D85301E989
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2026 07:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D90135A933;
	Wed, 20 May 2026 07:40:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3437D11F;
	Wed, 20 May 2026 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262830; cv=none; b=fBoXTv9KmAPAzp7tAwK8KSjZ5F3b+l9xgfpaZqx6mjZFPVgCNkHTkH+ZfPcvx5B5C0rpzE2v7ovi8NpLj9cXKz4+xqFEyj8OZS5+Z9T5DiiljBFg79aB/5Cbj0RHCJv2XuvR55ZALFUbGH2umm5+vVvz0qzsVuW5ekxsGAo7KkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262830; c=relaxed/simple;
	bh=rwuk3tWBg58u2S+sPWASPRpWb3ydo44qFDHOdF45JTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TV8e1G3+Yn0HdVcm/NAjqG4uOhdm0a0Il5Ne7afdtCTUo1mIeTShXvI2c2Xvbyfu43VjHVq5JZ+04IC3MIDwAqW0SYMWIzL5EmTQPJMuz0o5SxxRXDRy4PebUVoMYo5zB07g1hhJxc7Hanc1LvNXa8fQrYlXu4RUK+ba5T2002U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 27ce7452541f11f1aa26b74ffac11d73-20260520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6af60833-fb18-4fc9-997e-a65c6ac34c85,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:20cbe81dec72a753054e17f9cb86fcee,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 27ce7452541f11f1aa26b74ffac11d73-20260520
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 840314379; Wed, 20 May 2026 15:40:21 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: Kai.Makisara@kolumbus.fi,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	djeffery@redhat.com,
	jmeneghi@redhat.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>
Subject: [PATCH] scsi: st: Fix lock leak in st_ioctl()
Date: Wed, 20 May 2026 15:40:16 +0800
Message-Id: <20260520074016.51975-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-23932-lists,linux-scsi=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,126.com,kylinos.cn];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[zenghongling@kylinos.cn,linux-scsi@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:mid,kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5C8D8589103
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The default case in the switch statement returns directly from
st_common_ioctl() without releasing &STp->lock, causing a lock
imbalance. Fix by jumping to the out label to properly release
the lock.

Fixes: b37d70c0df85 ("scsi: st: Separate st-unique ioctl handling from SCSI common ioctl handling")
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 drivers/scsi/st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index f1c3c4946637..3b08992e1b10 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3628,7 +3628,8 @@ static long st_ioctl(struct file *file, unsigned int cmd_in, unsigned long arg)
 	case MTIOCTOP:
 		break;
 	default:
-		return st_common_ioctl(STp, STm, file, cmd_in, arg);
+		retval = st_common_ioctl(STp, STm, file, cmd_in, arg);
+		goto out;
 	}
 
 	cmd_type = _IOC_TYPE(cmd_in);
-- 
2.25.1


