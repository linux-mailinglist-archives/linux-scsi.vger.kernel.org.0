Return-Path: <linux-scsi+bounces-26202-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NbAPCbFXVmrK3gAAu9opvQ
	(envelope-from <linux-scsi+bounces-26202-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 17:37:21 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC37567F1
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 17:37:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="DxjpDvw/";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26202-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26202-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A81903022A43
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EFE35E952;
	Tue, 14 Jul 2026 15:22:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B2271456
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 15:22:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042570; cv=none; b=NBdwTCtAOYWg/DzOxgFUmUjPXuKwlIpUQtLsejqL+3wX2+d6m+h60FoIKXnok5G+KU2tHUrpjZHHR0sfHl7H/GRTcODbVdzQrO6N2FIhCI/tCrKnyD/C1xbFwyn1aM1PcGAkd3p+5QFpKSPCPgAlcmSCriqMWwjfKc32dHth0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042570; c=relaxed/simple;
	bh=MiZNs3K5dRllkjW5iOz2ZQ3thz2YRxLQomtAaKNKzGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t1dC2UPRGnS8z6tR3UWXixcWRDYnrYUYtABzzbu6uazKtEGJsKQeSx2LzB3ilwm+SNiIneyqGxPhO9Vsn7cibrC/wnoPTzSyK4oSXiQdq+M7yVBd06ptlqWC9jDmmvPSyuu0Uq/IkBX0nozSnCHLV8Zrh/zbc5ezhsYQS/+Anj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DxjpDvw/; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784042568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zSmydwKOKw+iuaVJZHAYyikSta/hRg+7yhoWUJYhBkU=;
	b=DxjpDvw/le0rVDhrjaJWADLONmsjNZk6FjiW9Wrw62ZHVZnHUtU3KfAzE2X9IzK8hzLiO6
	0Z+irSdx9VkVU4yvLLRYyMgSZrKkmTZAVf4VLJFXLFh6OqgI3GGylqv10S+IC5M2BUV+C5
	TacfCpjzPUHHECADTJCMPKAgFTMH5aQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-S6EkA1ByOQ-FCVWye7DB7A-1; Tue,
 14 Jul 2026 11:22:44 -0400
X-MC-Unique: S6EkA1ByOQ-FCVWye7DB7A-1
X-Mimecast-MFC-AGG-ID: S6EkA1ByOQ-FCVWye7DB7A_1784042562
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A6CBD1800598;
	Tue, 14 Jul 2026 15:22:41 +0000 (UTC)
Received: from jtaubepe-thinkpadx1carbongen12.ibmlowe.csb (unknown [10.17.17.152])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CED8118005AE;
	Tue, 14 Jul 2026 15:22:39 +0000 (UTC)
From: Jesse Taube <jtaubepe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>,
	Jesse Taube <mr.bossman075@gmail.com>,
	Jesse Taube <jtaubepe@redhat.com>
Subject: [PATCH] scsi: qla2xxx: Fix flex array member not at end
Date: Tue, 14 Jul 2026 11:22:38 -0400
Message-ID: <20260714152238.541704-1-jtaubepe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26202-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,HansenPartnership.com,oracle.com,kernel.org,infradead.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:njavali@marvell.com,m:GR-QLogic-Storage-Upstream@marvell.com,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:gustavoars@kernel.org,m:kees@kernel.org,m:hch@infradead.org,m:jmeneghi@redhat.com,m:cleech@redhat.com,m:mr.bossman075@gmail.com,m:jtaubepe@redhat.com,m:mrbossman075@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jtaubepe@redhat.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtaubepe@redhat.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 16DC37567F1

In qla_edif_bsg.h: `struct fc_bsg_reply` and `struct fc_bsg_request`
have flexible array members, thus they must be the last member of
the parent structure. Contininging in the effort to add
`-Wflex-array-member-not-at-end`, move the structs to the end of
the parent structures, `struct qla_bsg_auth_els_reply` and
`struct qla_bsg_auth_els_request `.

Suggested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
---
 drivers/scsi/qla2xxx/qla_edif_bsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif_bsg.h b/drivers/scsi/qla2xxx/qla_edif_bsg.h
index 514c265ba86e..bcc35d149c1f 100644
--- a/drivers/scsi/qla2xxx/qla_edif_bsg.h
+++ b/drivers/scsi/qla2xxx/qla_edif_bsg.h
@@ -36,16 +36,16 @@ struct extra_auth_els {
 } __packed;
 
 struct qla_bsg_auth_els_request {
-	struct fc_bsg_request r;
 	struct extra_auth_els e;
+	struct fc_bsg_request r;
 };
 
 struct qla_bsg_auth_els_reply {
-	struct fc_bsg_reply r;
 	uint32_t rx_xchg_address;
 	uint8_t version;
 	uint8_t pad[VND_CMD_PAD_SIZE];
 	uint8_t reserved[VND_CMD_APP_RESERVED_SIZE];
+	struct fc_bsg_reply r;
 };
 
 struct app_id {
-- 
2.54.0


