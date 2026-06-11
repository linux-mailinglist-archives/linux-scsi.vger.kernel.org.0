Return-Path: <linux-scsi+bounces-24693-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Op8qN6ZSKmqdnQMAu9opvQ
	(envelope-from <linux-scsi+bounces-24693-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 08:16:06 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B1E66EF3B
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 08:16:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=HS3b8kIR;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24693-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24693-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 753CC30DBBE1
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 06:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC5D35F8C9;
	Thu, 11 Jun 2026 06:16:00 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEE130F957;
	Thu, 11 Jun 2026 06:15:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158560; cv=none; b=fXYQbbWEDhWGmwTUsbkKbfF5PUYII9faVsJ6I2mYzN+bgZnYkkQbdP6H74r3kYzB0kUkGZNDbMb7lfz5jJEswQD0xPZxebknbeRyG8aUhdejreHrZYd5Mn1XoQtbW9gb5jjkislALnwhQJGavQiuYe7TiR4PdxCo/yWpLKQUlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158560; c=relaxed/simple;
	bh=vlcyG20a44xK5NP4c5hbAi30HisFbU79Yg9eRc0mvbk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjzdBXBnqEIxovqdRQ8cG1RYl+tBZjOK/KTyGtIbeDSMIO57/bXoSpIpNBLlitznuBpDuxQ240vm84S5AstnF5104+HUhhinCM7Azn92AzdF2SA1yDGqAgDs8r/67jejElIvOZTm1CNaoXccS7h2X/cO2uqieDJkKjO94QkS2/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=HS3b8kIR; arc=none smtp.client-ip=113.46.200.226
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gEIvW/6wtZnScM7ws+i7IkXSapQJNZN2tini6VXnhhg=;
	b=HS3b8kIRVbrL4V5eFfTDFb0GXN+X3pbxUAibaEKzR3qmy9BXYZC7YENkizK8Q0lh6WrXEMyLN
	mK/ZdGdtJoAowq2GktW+yvwqj+szmf4/NH8ylXh3fYw52lBWPbjtwK2TPsGnqKMM/enK6KSRS2/
	3ubRxCXlQ+vmX4trNHlhujE=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gbXHv6nS6zKm5D;
	Thu, 11 Jun 2026 14:07:55 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E47A402AB;
	Thu, 11 Jun 2026 14:15:53 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 11 Jun 2026 14:15:52 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <liyihang9@h-partners.com>, <yangxingui@huawei.com>,
	<liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v7 1/2] scsi: libsas: refactor sas_ex_to_ata() using new helper sas_ex_to_dev()
Date: Thu, 11 Jun 2026 14:15:50 +0800
Message-ID: <20260611061551.1171058-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611061551.1171058-1-yangxingui@huawei.com>
References: <20260611061551.1171058-1-yangxingui@huawei.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-24693-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,oracle.com:email,huawei.com:email,huawei.com:mid,huawei.com:from_mime,h-partners.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49B1E66EF3B

The sas_ex_to_ata() function checks for an attached ATA device on an
expander phy. Refactor it to use a new helper function sas_ex_to_dev()
which returns any device type attached to an expander phy, improving code
reuse and allowing other code paths to find attached devices regardless
of type.

No functional changes intended.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 12 ++++++++----
 drivers/scsi/libsas/sas_internal.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index f471ab464a78..f55ae9a979cd 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -345,11 +345,9 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
 		 SAS_ADDR(phy->attached_sas_addr), type);
 }
 
-/* check if we have an existing attached ata device on this expander phy */
-struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id)
+struct domain_device *sas_ex_to_dev(struct domain_device *ex_dev, int phy_id)
 {
 	struct ex_phy *ex_phy = &ex_dev->ex_dev.ex_phy[phy_id];
-	struct domain_device *dev;
 	struct sas_rphy *rphy;
 
 	if (!ex_phy->port)
@@ -359,7 +357,13 @@ struct domain_device *sas_ex_to_ata(struct domain_device *ex_dev, int phy_id)
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


