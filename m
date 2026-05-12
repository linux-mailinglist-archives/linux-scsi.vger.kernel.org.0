Return-Path: <linux-scsi+bounces-23733-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN8BD52rAmrtvQEAu9opvQ
	(envelope-from <linux-scsi+bounces-23733-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 06:25:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCAC51991C
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 06:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629313028B4E
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 04:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A41310784;
	Tue, 12 May 2026 04:24:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36D3126BF;
	Tue, 12 May 2026 04:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.133.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778559878; cv=none; b=os0aYmOPNGvEBNc9EaT724hqIIcZ8D03yGWi0+RsEZtyBwp9BqyLw2Ill54Euw+1yE6xrjo8QXWQimkY8gGn1MAfGBuZToPjcVxOEw/AIhiFDgG2GTpme8IQ73t5JXnokt0pWEcY+Qj0S8rNIKCknsoTu1EK5MPAun5ZWiBWfKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778559878; c=relaxed/simple;
	bh=R6mAT2DfOSNb1VO7H38Jv0UhmmA7pUmRvjQXQDkptmA=;
	h=Message-Id:From:Date:Subject:To:Cc; b=r/FNUItoZUpcDLk8UcgWUO7tSL7vRO83yI0F77i0L0Ry3ivtX9moH+cYiuXQBzRHb/C2GAUwrAzId5MNxbwyKPIMATcU68LqeXb25eVX6pQhNXnd3DhCClVEoaVoheaLC889CZmGQew1RbzlJ5UK+2WuQZInBor3yMQIa4jLDcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=144.76.133.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 78627C8B;
	Tue, 12 May 2026 06:24:26 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 47CF96029AF0; Tue, 12 May 2026 06:24:26 +0200 (CEST)
Message-Id: <57f8a29ee7a75f81bd0a42f3fea54f0f1d3fe4e4.1778559000.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 12 May 2026 06:24:10 +0200
Subject: [PATCH] scsi: Drop pci_save_state() after pci_restore_state()
To: Ram Vegesna <ram.vegesna@broadcom.com>, Justin Tee <justin.tee@broadcom.com>, Paul Ely <paul.ely@broadcom.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, Mike Christie <michael.christie@oracle.com>, James Smart <jsmart2021@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: CCCAC51991C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,oracle.com,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-23733-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[wunner.de: no valid DMARC record];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.837];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FROM_NEQ_ENVFROM(0.00)[lukas@wunner.de,linux-scsi@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wunner.de:email,wunner.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Commit 383d89699c50 ("treewide: Drop pci_save_state() after
pci_restore_state()") sought to purge all superfluous invocations of
pci_save_state() from the tree.

Unfortunately the commit missed one invocation in the Broadcom
EFCT target driver and another one in the LPFC driver.  Drop them.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
I've combined removal from two drivers in a single patch because
they're both Broadcom devices and this is a fairly trivial change.
But if you prefer splitting the patch in two, please let me know.

 drivers/scsi/elx/efct/efct_driver.c | 7 -------
 drivers/scsi/lpfc/lpfc_init.c       | 5 -----
 2 files changed, 12 deletions(-)

diff --git a/drivers/scsi/elx/efct/efct_driver.c b/drivers/scsi/elx/efct/efct_driver.c
index fe45009..6d4f00b 100644
--- a/drivers/scsi/elx/efct/efct_driver.c
+++ b/drivers/scsi/elx/efct/efct_driver.c
@@ -696,13 +696,6 @@
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	/*
-	 * As the new kernel behavior of pci_restore_state() API call clears
-	 * device saved_state flag, need to save the restored state again.
-	 */
-
-	pci_save_state(pdev);
-
 	pci_set_master(pdev);
 
 	rc = efct_setup_msix(efct, efct->n_msix_vec);
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 968a2523..dc58085 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -15245,11 +15245,6 @@ static int lpfc_cpu_online(unsigned int cpu, struct hlist_node *node)
 	if (!hba_pci_err)
 		dev_info(&pdev->dev,
 			 "hba_pci_err was not set, recovering slot reset.\n");
-	/*
-	 * As the new kernel behavior of pci_restore_state() API call clears
-	 * device saved_state flag, need to save the restored state again.
-	 */
-	pci_save_state(pdev);
 
 	if (pdev->is_busmaster)
 		pci_set_master(pdev);
-- 
2.51.0


