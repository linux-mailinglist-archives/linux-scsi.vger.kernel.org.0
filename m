Return-Path: <linux-scsi+bounces-25178-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pgLML+XyOWoqzQcAu9opvQ
	(envelope-from <linux-scsi+bounces-25178-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 04:43:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 363156B394C
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 04:43:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=irRNCazI;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25178-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25178-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 114E43040962
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C638735E;
	Tue, 23 Jun 2026 02:43:11 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709E23BD06;
	Tue, 23 Jun 2026 02:43:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782182591; cv=none; b=GlGDk6i6McCgf0ZrX3GQJBoLzCs3vb7H5LVV9xbhmRvU+e32OyU6m0vtgpeA1IM2bN+HGH6B3FcLGippGzyWoj0WHLW1GT9owQlj2e3S6BknK0XGXx4QbpQg6P0QtpaeGaZXVpiagEljdrC5vSlbgI+TaJGOcAuTEtL4CYzowAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782182591; c=relaxed/simple;
	bh=6M+FwioNSh33vD24Nkbbg03/wbosNatONOMme+5Xq5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqQoGB4KszuZ/IYOox23I9qFJseFQkzP6TSGT034wxcLfrWdi+fYBIDmwQucG5FsFMn6wpRfcDkMTdn/cQJVLWf/iB7Xkv7DKFQ20UWpFbV8ULWxxfVXsD1jbtjAXiHRLJqLU647cg00rUhaHF2fUiiIybtBTH4eLp+GrWOLSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=irRNCazI; arc=none smtp.client-ip=113.46.200.226
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=HW3S65B5az59s2WVMskiPhsafx88KZhGe3pvAKJVCZQ=;
	b=irRNCazI9iUZVYUn5AI0pTfj/DyDLCOUkx+Va3FTdAepF6aypcGnsxgUyIzUBybHKgh9tfu0N
	ma2ZOwEfozSfMAtDZ5QjPdylKU5YZLVagDZWR8cublOecupEH2aG6jbdQdYMcmCwYs5pDxrcBVS
	fL3A7IRGwaSLuXhdKM2Bha4=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gkq0j11XZzKm57;
	Tue, 23 Jun 2026 10:35:01 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id A2A7240561;
	Tue, 23 Jun 2026 10:43:05 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 23 Jun 2026 10:43:05 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <yangxingui@huawei.com>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v8 1/2] scsi: libsas: refactor sas_ex_to_ata() using new helper sas_ex_to_dev()
Date: Tue, 23 Jun 2026 10:43:03 +0800
Message-ID: <20260623024304.714582-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623024304.714582-1-yangxingui@huawei.com>
References: <20260623024304.714582-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-25178-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:john.g.garry@oracle.com,m:yanaijie@huawei.com,m:jejb@linux.ibm.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:liyihang9@h-partners.com,m:yangxingui@huawei.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,h-partners.com:dkim,vger.kernel.org:from_smtp,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 363156B394C

Introduce sas_ex_to_dev() to return any device type attached to an
expander phy. The new helper is then used by sas_ex_to_ata() to reduce
code duplication.

Also add a defensive NULL check for ex_dev to guard against callers
passing a NULL device.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 18 +++++++++++++-----
 drivers/scsi/libsas/sas_internal.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index f471ab464a78..cb9d3b748222 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -345,13 +345,15 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
 		 SAS_ADDR(phy->attached_sas_addr), type);
 }
 
-/* check if we have an existing attached ata device on this expander phy */
-struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id)
+struct domain_device *sas_ex_to_dev(struct domain_device *ex_dev, int phy_id)
 {
-	struct ex_phy *ex_phy = &ex_dev->ex_dev.ex_phy[phy_id];
-	struct domain_device *dev;
+	struct ex_phy *ex_phy;
 	struct sas_rphy *rphy;
 
+	if (!ex_dev)
+		return NULL;
+
+	ex_phy = &ex_dev->ex_dev.ex_phy[phy_id];
 	if (!ex_phy->port)
 		return NULL;
 
@@ -359,7 +361,13 @@ struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id)
 	if (!rphy)
 		return NULL;
 
-	dev = sas_find_dev_by_rphy(rphy);
+	return sas_find_dev_by_rphy(rphy);
+}
+
+/* check if we have an existing attached ata device on this expander phy */
+struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id)
+{
+	struct domain_device *dev = sas_ex_to_dev(ex_dev, phy_id);
 
 	if (dev && dev_is_sata(dev))
 		return dev;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 7dce0f587149..350a70484bde 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -91,6 +91,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy);
 
 void sas_device_set_phy(struct domain_device *dev, struct sas_port *port);
 struct domain_device *sas_find_dev_by_rphy(struct sas_rphy *rphy);
+struct domain_device *sas_ex_to_dev(struct domain_device *ex_dev, int phy_id);
 struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id);
 int sas_ex_phy_discover(struct domain_device *dev, int single);
 int sas_get_report_phy_sata(struct domain_device *dev, int phy_id,
-- 
2.43.0


