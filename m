Return-Path: <linux-scsi+bounces-21983-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFuAODt3s2mwWgAAu9opvQ
	(envelope-from <linux-scsi+bounces-21983-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 03:32:27 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4327CC74
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 03:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 213CD303264B
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 02:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB67342519;
	Fri, 13 Mar 2026 02:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="IbJp6RU8"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08F34165B;
	Fri, 13 Mar 2026 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773369062; cv=none; b=n4UcLwQcMgYFR12tYsI6gPe2l8KmdmSZxA7Ffyhy4F9XFV8sg5VWSPxNFUGZMzfaJQLaB5HHSrwgpG5vOezYeUC8lAHLcTLF8LrAI505/I0GnF2ijBEtv/JlC933IZVMspSImY99mLH9cK08eKeGPEIbea+B79lpLF9kJe6Rwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773369062; c=relaxed/simple;
	bh=QSgFLmZbcs3AxH4LX9EPBRvyEqKEn4ItxQktb4BIwqw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ftw3UwBtFrHTTJaDFJq8atiQKxG3nDhebOsstbtNQFPmGqTwSNKUZR63tdSQ2bMuPExnMHrnqNnoLjl3lGJFqa35Hk+XuXkFa2SbvWwef/WyPcevCgeiGFi/cr00LtpDxcXAFnJaZND0T9Nbnsa4J0a5CRTt1ZQQ1ifx2loWtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=IbJp6RU8; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q2Z4ziAJz6q8IEWHNC6BM4pKard5mvsTFr2JZeSofZw=;
	b=IbJp6RU8UyWg5dYkbi6TVQ2W0+/KRKmpTxtqqePj3Jt0lYEEaheofUIgdEtjGvtlu1sB2v+q5
	tyA3jRRBr/xkKsq6eI+0aNDS/HG91I7RKsJcP+opGtpo0/pjNjUbHBih8EBGwA1/0t/KC4UoqxO
	ki49gEzuKoLQYPI7O7cUP+U=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fX7d34YpZzpSw3;
	Fri, 13 Mar 2026 10:25:43 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B61A40561;
	Fri, 13 Mar 2026 10:30:58 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 13 Mar 2026 10:30:57 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>,
	<ranjan.kumar@broadcom.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liyihang9@huawei.com>, <liuyonglong@huawei.com>, <linuxarm@huawei.com>
Subject: [PATCH] scsi: Fix the maximum channel scanning issue
Date: Fri, 13 Mar 2026 10:30:57 +0800
Message-ID: <20260313023057.4151105-1-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemh200005.china.huawei.com (7.202.181.112)
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[liyihang9@huawei.com,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21983-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 5ED4327CC74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

After the commit 37c4e72b0651 ("scsi: Fix sas_user_scan() to handle
wildcard and multi-channel scans"), if the device supports multiple
channels (0 to shost->max_channel), user_scan() invokes updated
sas_user_scan() to perform the scan behavior for a specific transfer.
However, when the user specifies shost->max_channel, it will return
-EINVAL, which is not expected.

Fix and support specifying the scan shost->max_channel for scanning.

Fixes: 37c4e72b0651 ("scsi: Fix sas_user_scan() to handle wildcard and multi-channel scans")
Signed-off-by: Yihang Li <liyihang9@huawei.com>
---
 drivers/scsi/scsi_transport_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 12124f9d5ccd..13412702188e 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -1734,7 +1734,7 @@ static int sas_user_scan(struct Scsi_Host *shost, uint channel,
 		break;
 
 	default:
-		if (channel < shost->max_channel) {
+		if (channel <= shost->max_channel) {
 			res = scsi_scan_host_selected(shost, channel, id, lun,
 						      SCSI_SCAN_MANUAL);
 		} else {
-- 
2.33.0


