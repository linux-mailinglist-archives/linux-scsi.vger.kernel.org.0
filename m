Return-Path: <linux-scsi+bounces-24106-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LdcGpWuFWr2XwcAu9opvQ
	(envelope-from <linux-scsi+bounces-24106-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2026 16:30:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB95D7909
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2026 16:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63D84302224A
	for <lists+linux-scsi@lfdr.de>; Tue, 26 May 2026 14:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0263BB122;
	Tue, 26 May 2026 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYBu5gcu"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EDA3B9935
	for <linux-scsi@vger.kernel.org>; Tue, 26 May 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805258; cv=none; b=m56QKD3bP3KOZcwTfzT8K2sm8fSvAeOj5tXxzmUdEU+nhh6J0Etcj4YihrhFXdlcRm+0MUgStwh+ryC81TxcwlyC7ZIMmoqxjaSOGoK6aAORf5spYhYkil84tU6a1abXul9BCFEIigp4jsJPFWBe/AcDOfYbmBY7PXqNtcf+ofk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805258; c=relaxed/simple;
	bh=ZnNXN49JsLJG93x5V+J3hH7FPRjTSXEijvNIPGmGmi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M9bIaGPp6iJs1QvW/NUU/zcv/Z6P5l3dRVs3jB1Pad3IqnqCwLN33wRIoYQzFYwQyBrH2k8wlfpdJCktx1RoSDBGn8+A74l/YFk6LhPQ7RNMc48i7e/4+WL5bk9EptLion5Abcuw7yo5Cblz6cbi2WvaH27J5b2cwse3OL877dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYBu5gcu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779805255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IgIAO9DCZ18s2gUeChDFGfjpD/GZyehJLs4LnVrZfIY=;
	b=KYBu5gcu0dTQWSoYPGKEdnifkrBjT6a5VeYL0UoDAkUQ78jAl3jdAdi+Y70vPx8rmiVr0I
	WJOpcaiZUfA0OaoR5Sp56iUBR9slW086GL9J+ZvQkPTIE4+8d5k8/nOMYRYxQeFZ4FJt8K
	bGd6THKVg9VZuUSMJlej/h6aACjNRB0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-roSDKLc-M-CaW9WvvlJlyA-1; Tue,
 26 May 2026 10:20:50 -0400
X-MC-Unique: roSDKLc-M-CaW9WvvlJlyA-1
X-Mimecast-MFC-AGG-ID: roSDKLc-M-CaW9WvvlJlyA_1779805243
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 663711936195;
	Tue, 26 May 2026 14:19:55 +0000 (UTC)
Received: from nprabudo-thinkpadp16vgen1.rmtin.csb (unknown [10.74.80.96])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E63E919560AB;
	Tue, 26 May 2026 14:19:52 +0000 (UTC)
From: Nimal Prabudoss I <nprabudo@redhat.com>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	jmeneghi@redhat.com,
	nilesh.javali@marvell.com,
	Nimal Prabudoss I <nprabudo@redhat.com>
Subject: [PATCH] scsi: qedf: drop invalid skb_transport_header check to prevent panic
Date: Tue, 26 May 2026 10:19:50 -0400
Message-ID: <20260526141950.18394-1-nprabudo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24106-lists,linux-scsi=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nprabudo@redhat.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 73FB95D7909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

During intensive FCOE Tier 1 CTC boot tests, the qedf driver triggers a
warning assertion in include/linux/skbuff.h. This happens because the
driver attempts to access an uninitialized transport header offset via
skb_transport_header() under a CONFIG_DEBUG_NET environment.

Remove the invalid helper call within qedf_recv_frame() to eliminate the
warning assertion and prevent the subsequent system panic.

Link: https://issues.redhat.com/browse/RHEL-177545
Signed-off-by: Nimal Prabudoss I <nprabudo@redhat.com>
---
 drivers/scsi/qedf/qedf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index da429b3a4283..f2bc0ac684e0 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2496,7 +2496,6 @@ static void qedf_recv_frame(struct qedf_ctx *qedf,
 
 	/* Pull the header */
 	hp = (struct fcoe_hdr *)skb->data;
-	fh = (struct fc_frame_header *) skb_transport_header(skb);
 	skb_pull(skb, sizeof(struct fcoe_hdr));
 	fr_len = skb->len - sizeof(struct fcoe_crc_eof);
 
-- 
2.54.0


