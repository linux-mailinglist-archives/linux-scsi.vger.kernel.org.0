Return-Path: <linux-scsi+bounces-22890-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDxiIDI52mnmzAgAu9opvQ
	(envelope-from <linux-scsi+bounces-22890-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 11 Apr 2026 14:06:10 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B763DFA86
	for <lists+linux-scsi@lfdr.de>; Sat, 11 Apr 2026 14:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2B3A306A8FF
	for <lists+linux-scsi@lfdr.de>; Sat, 11 Apr 2026 12:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439FA34C81E;
	Sat, 11 Apr 2026 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w9jHONHk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F113633F599;
	Sat, 11 Apr 2026 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775909167; cv=none; b=g6NlnsoYPfOe1Ib4VwO8ngoq/ky5bnTEzX9xbQQcM4r+GFANf8Emdz8gaOS97RYy4o1orjmans94nEGqg0CEZw++U+u1xikcr5zaavD2EXxQdTuDCF4wCWtTQ3pSbd7yk1TXUGn/+PaJW0oLAiD0S3qRHN+B+TxPp6PdithEpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775909167; c=relaxed/simple;
	bh=9937+ZYauyAiomgbXKuGMrwZHg05M67o5BvEglmDEyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQe/wXD1duU6mRXoaFNrBrYCl7uuzI2TbR27dZnYq/+WWFoQLLmf3hEDc+XReoHwHICmyfri78kLx1G5LAwGFxRjfquuG4/yb93B/wIDanTax6z/81l+WUFNMu8phs7KEo1gfmn01/kbx/vzxKIK92iBjg2uQ+QR/bfnV/pxOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w9jHONHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE47C4CEF7;
	Sat, 11 Apr 2026 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775909166;
	bh=9937+ZYauyAiomgbXKuGMrwZHg05M67o5BvEglmDEyA=;
	h=From:To:Cc:Subject:Date:From;
	b=w9jHONHke3XQHZGRbaBxX74riBzQ93V36pKnHD3oWorQSja55wF1VWVmGSGzfxTmP
	 ePIP66GX0aaNlqVxLVN7nbltzRUw6rfNUWrIsuB8q1N4ZesWh69OXuTO7PX6wv2tJ9
	 DcNX3rUC+kLvC6p1PtG8q7i9lMRIFNx5LU4rW4aA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] scsi: target: configfs: bound snprintf return in tg_pt_gp_members_show
Date: Sat, 11 Apr 2026 14:06:00 +0200
Message-ID: <2026041159-garter-theft-3be0@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 38
X-Developer-Signature: v=1; a=openpgp-sha256; l=1766; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=9937+ZYauyAiomgbXKuGMrwZHg05M67o5BvEglmDEyA=; b=owGbwMvMwCRo6H6F97bub03G02pJDJm3LNWnBFReFD518a2sR8G3ouoKxz6rD4w+ckXJwerCb tMyLRZ1xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwETkZRjmmf9e5yWUx/TtZOzc PnH5+Dlec9fIMixYf1Hiwsfev0qmLjOnMVw/Kp+g1/QEAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22890-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: E7B763DFA86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

target_tg_pt_gp_members_show() formats LUN paths with snprintf() into a
256-byte stack buffer, then will memcpy cur_len bytes from that buffer.
snprintf() returns the length the output would have had, which can
exceed the buffer size when the fabric WWN is long because iSCSI IQN
names can be up to 223 bytes.  The check at the memcpy site only guards
the destination page write, not the source read, so memcpy() will read
past the stack buffer and copy adjacent stack contents to the sysfs
reader, which when CONFIG_FORTIFY_SOURCE is enabled, fortify_panic()
will be triggered.

Commit 27e06650a5ea ("scsi: target: target_core_configfs: Add length
check to avoid buffer overflow") added the same bound to the
target_lu_gp_members_show() but the tg_pt_gp variant was missed so
resolve that here.

Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Fixes: c66ac9db8d4a ("[SCSI] target: Add LIO target core v4.0.0-rc6")
Assisted-by: gregkh_clanker_t1000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/target/target_core_configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index a1c91d4515bc..84124b222a99 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3227,7 +3227,7 @@ static ssize_t target_tg_pt_gp_members_show(struct config_item *item,
 			config_item_name(&lun->lun_group.cg_item));
 		cur_len++; /* Extra byte for NULL terminator */
 
-		if ((cur_len + len) > PAGE_SIZE) {
+		if (cur_len > TG_PT_GROUP_NAME_BUF || (cur_len + len) > PAGE_SIZE) {
 			pr_warn("Ran out of lu_gp_show_attr"
 				"_members buffer\n");
 			break;
-- 
2.53.0


