Return-Path: <linux-scsi+bounces-25353-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LgFoMM2iQ2oOeAoAu9opvQ
	(envelope-from <linux-scsi+bounces-25353-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 13:04:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 253006E351C
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 13:04:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RJE2rCy7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25353-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25353-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A39F83236D96
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04958403B1F;
	Tue, 30 Jun 2026 10:54:30 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4297403AF8;
	Tue, 30 Jun 2026 10:54:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816869; cv=none; b=Fh/RL2OKi6UjrXKL7GBuQjNsx/64pGf5UwTOlXsOxjYGsDX8t16DInkFZczCq8NCEi4LNp0O1lZirD+lg7orAc+nTNtfSXM4yDe6mmmZJtvyUSsGtrhlnsI+bnz514S5ZHO2vAjFxtzcBc2vtSBa6hV5m/nJtQQ1cj62HOTBRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816869; c=relaxed/simple;
	bh=lZl3pHReeTA4PBsfdv9T3/Murxcq0XUtd1bdKzlK6cA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrQxv/sH+O/wgz3b8kQD+c/+2LYk/A/G+mYAUgKh1vBsty+6RrVU4wJjiDa+aPupnouDJhZD2Sj9WK+2bk59RM6N8GFExVtCEBb1IBYbJNqj8Fvx0iHnzcUtUueEN8ilwzKwgjbdm5KKGc/1HAUTvPWs8wbhresddqi1Wuq6YRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJE2rCy7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BB21F000E9;
	Tue, 30 Jun 2026 10:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816868;
	bh=305VH6OUix40v7/Cr6ljvxi18Oyq/nvdnChwFnVwVXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RJE2rCy7Arqo6bbDH+p8izGeNvi9sDYWDv3cAyD5NIV2YpMNtN63lEN+vEGc2Nw87
	 yi59zz6dEg25JB7hHQsk3lzyiblRdvvgKrwW/b6iekZzAN7iQ96q459V59kHvDgUhy
	 9J+YJ1bPTvRzZvdMlNscfSc+kP8CM1037BvOuhifT7phPEJtVJ4xRCOtjMT0Sq/ydP
	 22nv23K4tfPr4FUFhV14ETFspsKhAvt3gIPHn4s95pA9VIwJBacdP2l90xcmdJ3je4
	 1EtrHZo9bUd3kV9VHGWHSIqF8aznRprqA1Gnl6b+oqiD1hXHcEHI8FNV2Zxi/qL8ba
	 d843Q/TXn1+3Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:54:19 +0300
Subject: [PATCH 2/4] scsi: proc: use kmalloc() in proc writers
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-scsi-v1-2-494fb37ebe7b@kernel.org>
References: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
In-Reply-To: <20260630-b4-scsi-v1-0-494fb37ebe7b@kernel.org>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Brian King <brking@us.ibm.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25353-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:brking@us.ibm.com,m:James.Bottomley@HansenPartnership.com,m:willy@infradead.org,m:rppt@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 253006E351C

proc_scsi_host_write(), proc_scsi_write() and proc_scsi_devinfo_write()
allocate temporary buffers for /proc writes using __get_free_page().

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Replace use of __get_free_page() with kmalloc().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/scsi/scsi_devinfo.c | 4 ++--
 drivers/scsi/scsi_proc.c    | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 15ffbe93ac72..6dd342fe9a69 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -691,7 +691,7 @@ static ssize_t proc_scsi_devinfo_write(struct file *file,
 
 	if (!buf || length>PAGE_SIZE)
 		return -EINVAL;
-	if (!(buffer = (char *) __get_free_page(GFP_KERNEL)))
+	if (!(buffer = kmalloc(PAGE_SIZE, GFP_KERNEL)))
 		return -ENOMEM;
 	if (copy_from_user(buffer, buf, length)) {
 		err =-EFAULT;
@@ -708,7 +708,7 @@ static ssize_t proc_scsi_devinfo_write(struct file *file,
 	scsi_dev_info_list_add_str(buffer);
 
 out:
-	free_page((unsigned long)buffer);
+	kfree(buffer);
 	return err;
 }
 
diff --git a/drivers/scsi/scsi_proc.c b/drivers/scsi/scsi_proc.c
index 1799dcae775c..fdc355d783da 100644
--- a/drivers/scsi/scsi_proc.c
+++ b/drivers/scsi/scsi_proc.c
@@ -28,6 +28,7 @@
 #include <linux/mutex.h>
 #include <linux/gfp.h>
 #include <linux/uaccess.h>
+#include <linux/slab.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
@@ -74,7 +75,7 @@ static ssize_t proc_scsi_host_write(struct file *file, const char __user *buf,
 	if (!shost->hostt->write_info)
 		return -EINVAL;
 
-	page = (char *)__get_free_page(GFP_KERNEL);
+	page = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (page) {
 		ret = -EFAULT;
 		if (copy_from_user(page, buf, count))
@@ -82,7 +83,7 @@ static ssize_t proc_scsi_host_write(struct file *file, const char __user *buf,
 		ret = shost->hostt->write_info(shost, page, count);
 	}
 out:
-	free_page((unsigned long)page);
+	kfree(page);
 	return ret;
 }
 
@@ -412,7 +413,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 	if (!buf || length > PAGE_SIZE)
 		return -EINVAL;
 
-	buffer = (char *)__get_free_page(GFP_KERNEL);
+	buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -467,7 +468,7 @@ static ssize_t proc_scsi_write(struct file *file, const char __user *buf,
 		err = length;
 
  out:
-	free_page((unsigned long)buffer);
+	kfree(buffer);
 	return err;
 }
 

-- 
2.53.0


