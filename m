Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68941180F86
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2020 06:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgCKFNn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Mar 2020 01:13:43 -0400
Received: from smtprelay0005.hostedemail.com ([216.40.44.5]:36440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726044AbgCKFNn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 11 Mar 2020 01:13:43 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id D86001802E2A0
        for <linux-scsi@vger.kernel.org>; Wed, 11 Mar 2020 05:06:54 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 73E108410;
        Wed, 11 Mar 2020 05:06:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:967:973:982:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1543:1711:1730:1747:1777:1792:2393:2525:2560:2563:2682:2685:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3865:3866:3867:3870:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:4605:5007:6261:9025:9592:10004:10848:11026:11473:11658:11914:12043:12297:12438:12555:12679:12895:12986:13095:13894:14096:14181:14394:14721:21080:21433:21451:21627:21811:21939:30045:30046:30054:30075,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hose56_1ec53cd19b31a
X-Filterd-Recvd-Size: 4270
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:51 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Russell King <linux@armlinux.org.uk>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH -next 006/491] ARM/RISCPC ARCHITECTURE: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:20 -0700
Message-Id: <fb956ff22b89ac7a7f97489b29ecf13a32de8d06.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-rpc/riscpc.c |  2 +-
 drivers/scsi/arm/fas216.c  | 17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index ea2c842..d23970b 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -46,7 +46,7 @@ static int __init parse_tag_acorn(const struct tag *tag)
 	switch (tag->u.acorn.vram_pages) {
 	case 512:
 		vram_size += PAGE_SIZE * 256;
-		/* Fall through - ??? */
+		fallthrough;	/* ??? */
 	case 256:
 		vram_size += PAGE_SIZE * 256;
 	default:
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 6c68c230..bb18be 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -603,8 +603,7 @@ static void fas216_handlesync(FAS216_Info *info, char *msg)
 		msgqueue_flush(&info->scsi.msgs);
 		msgqueue_addmsg(&info->scsi.msgs, 1, MESSAGE_REJECT);
 		info->scsi.phase = PHASE_MSGOUT_EXPECT;
-		/* fall through */
-
+		fallthrough;
 	case async:
 		dev->period = info->ifcfg.asyncperiod / 4;
 		dev->sof    = 0;
@@ -916,8 +915,7 @@ static void fas216_disconnect_intr(FAS216_Info *info)
 			fas216_done(info, DID_ABORT);
 			break;
 		}
-		/* else, fall through */
-
+		fallthrough;
 	default:				/* huh?					*/
 		printk(KERN_ERR "scsi%d.%c: unexpected disconnect in phase %s\n",
 			info->host->host_no, fas216_target(info), fas216_drv_phase(info));
@@ -1413,8 +1411,7 @@ static void fas216_busservice_intr(FAS216_Info *info, unsigned int stat, unsigne
 	case STATE(STAT_STATUS, PHASE_DATAOUT): /* Data Out     -> Status       */
 	case STATE(STAT_STATUS, PHASE_DATAIN):  /* Data In      -> Status       */
 		fas216_stoptransfer(info);
-		/* fall through */
-
+		fallthrough;
 	case STATE(STAT_STATUS, PHASE_SELSTEPS):/* Sel w/ steps -> Status       */
 	case STATE(STAT_STATUS, PHASE_MSGOUT):  /* Message Out  -> Status       */
 	case STATE(STAT_STATUS, PHASE_COMMAND): /* Command      -> Status       */
@@ -1426,8 +1423,7 @@ static void fas216_busservice_intr(FAS216_Info *info, unsigned int stat, unsigne
 	case STATE(STAT_MESGIN, PHASE_DATAOUT): /* Data Out     -> Message In   */
 	case STATE(STAT_MESGIN, PHASE_DATAIN):  /* Data In      -> Message In   */
 		fas216_stoptransfer(info);
-		/* fall through */
-
+		fallthrough;
 	case STATE(STAT_MESGIN, PHASE_COMMAND):	/* Command	-> Message In	*/
 	case STATE(STAT_MESGIN, PHASE_SELSTEPS):/* Sel w/ steps -> Message In   */
 	case STATE(STAT_MESGIN, PHASE_MSGOUT):  /* Message Out  -> Message In   */
@@ -1581,8 +1577,7 @@ static void fas216_funcdone_intr(FAS216_Info *info, unsigned int stat, unsigned
 			fas216_message(info);
 			break;
 		}
-		/* else, fall through */
-
+		fallthrough;
 	default:
 		fas216_log(info, 0, "internal phase %s for function done?"
 			"  What do I do with this?",
@@ -1964,7 +1959,7 @@ static void fas216_kick(FAS216_Info *info)
 	switch (where_from) {
 	case TYPE_QUEUE:
 		fas216_allocate_tag(info, SCpnt);
-		/* fall through */
+		fallthrough;
 	case TYPE_OTHER:
 		fas216_start_command(info, SCpnt);
 		break;
-- 
2.24.0

