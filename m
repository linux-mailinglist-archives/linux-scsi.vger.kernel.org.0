Return-Path: <linux-scsi+bounces-23522-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMOULWee82lJ5QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23522-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:24:39 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4264A6E27
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 20:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9CE30315E1
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 18:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31404477E43;
	Thu, 30 Apr 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="d8pd7sCY"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251E39D6DE
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573402; cv=none; b=iqLTz8Q7GMexNt/nBiTRZido2aLJ+NDjqZ1bZH/XbNDbFjdgfX39OXW+oVkWx2vKEAXrabc2/c3UGkvxNfvnspY8bEVpngY0EhCjiBVYAfgO4oJCD2jTUtxYiWzRl//sxgJbwnJZwsF9jyGjq6jVScK8zHVYr3dvgOIupZ/yA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573402; c=relaxed/simple;
	bh=JGPuIyysDyaqVHQqhXHi0htNmLW6ILwWM7dGBH7g3y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mut6/zlu7Ll2x6/2Xbd/IFtg0nQ9k3rc0xygppmM4FrG+hb1WRZlyJRLYPg1xxp/EFsi7VWIGtJelxztIJL3EklBr3T3IpoaX5VvalHKSvgQOc4ZqThbQpyd7IxCddBcNp8giuGpX2p4CdCr7H1hlVZwKI+h7q2eInOMHp++JEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=d8pd7sCY; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g62br50MKzlfdfc;
	Thu, 30 Apr 2026 18:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received; s=mr01; t=1777573398; x=
	1780165399; bh=JGPuIyysDyaqVHQqhXHi0htNmLW6ILwWM7dGBH7g3y4=; b=d
	8pd7sCYijEKOK0vdZi7dBj09w5JpyYtsw5uArpybucwmp7xnBTLSWb2xUTBgw6z2
	wos/REfchiokDlpU9tHBrQ5Wil4LVoPchzOh+qQjICdtu4hgYLTws7gan9JXuVkU
	1kce97yxUaTnccnayZbWOGiBwLRNtBp9LKqgsQZug3FY0mR8S1NnfEmN3cvI0+Dq
	0gFnepdze1ry5trpaYHp936YLEgCjkt+qk9rElulqgBJLTan6nVw+0zyQaKM4SVt
	/WuxdGKaN9oR7t16N62j118WZav7ar8AsFh6Aa5SVAB5pl33Cd776dDLFhiypOdf
	DALUT69LS/A9rgUEWFfYA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qP7ju42g78kM; Thu, 30 Apr 2026 18:23:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g62bm4HfLzlffts;
	Thu, 30 Apr 2026 18:23:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Ram Vegesna <ram.vegesna@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v2 23/56] scsi: elx: Enable lock context analysis
Date: Thu, 30 Apr 2026 11:19:53 -0700
Message-ID: <20260430182130.1978347-24-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260430182130.1978347-1-bvanassche@acm.org>
References: <20260430182130.1978347-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A4264A6E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23522-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:dkim,acm.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/elx/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/elx/Makefile b/drivers/scsi/elx/Makefile
index a8537d7a2a6e..0ed508e379fb 100644
--- a/drivers/scsi/elx/Makefile
+++ b/drivers/scsi/elx/Makefile
@@ -4,6 +4,7 @@
 # * =E2=80=9CBroadcom=E2=80=9D refers to Broadcom Inc. and/or its subsid=
iaries.
 # */
=20
+CONTEXT_ANALYSIS :=3D y
=20
 obj-$(CONFIG_SCSI_EFCT) :=3D efct.o
=20

