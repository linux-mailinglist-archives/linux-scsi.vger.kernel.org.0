Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4F2F384B
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 19:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406647AbhALSOw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Jan 2021 13:14:52 -0500
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:50280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404683AbhALSOw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 12 Jan 2021 13:14:52 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 06BA2100E7B42;
        Tue, 12 Jan 2021 18:14:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:968:973:988:989:1260:1311:1314:1345:1437:1515:1534:1541:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:3138:3139:3140:3141:3142:3352:3865:3870:4250:4321:5007:6119:6261:7807:9592:10004:10848:11026:11232:11473:11658:11914:12043:12297:12438:12555:12895:13069:13311:13357:13894:14096:14181:14384:14394:14721:21067:21080:21220:21627:21990:30030:30054:30055:30080,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: veil79_2b0dccb27517
X-Filterd-Recvd-Size: 1934
Received: from joe-laptop.perches.com (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 12 Jan 2021 18:14:09 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: mpt3sas: Again output non-intel branding
Date:   Tue, 12 Jan 2021 10:14:07 -0800
Message-Id: <0d7a6df3210f114db1caba414b2fb9c864ee8612.1610475094.git.joe@perches.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

commit 989e43c7ec34 ("mpt3sas: Added OEM Gen2 PnP ID branding names")
consolidated individual functions for OEM branding into a single function
but left a test for intel only at the top so no other vendor branding
was output.  Remove the test.

Signed-off-by: Joe Perches <joe@perches.com>
---

If no one noticed in the last 5 years, maybe the whole branding output
should be deleted instead...

 drivers/scsi/mpt3sas/mpt3sas_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 1ffed396d91f..2faea35806b2 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4195,9 +4195,6 @@ _base_display_OEMs_branding(struct MPT3SAS_ADAPTER *ioc)
 	const char *b = NULL;	/* brand */
 	const char *v = NULL;	/* vendor */
 
-	if (ioc->pdev->subsystem_vendor != PCI_VENDOR_ID_INTEL)
-		return;
-
 	switch (ioc->pdev->subsystem_vendor) {
 	case PCI_VENDOR_ID_INTEL:
 		switch (ioc->pdev->device) {
-- 
2.30.0

