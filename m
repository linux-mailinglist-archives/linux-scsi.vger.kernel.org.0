Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10ED1241378
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Aug 2020 00:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgHJW7a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Aug 2020 18:59:30 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:39662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbgHJW73 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Aug 2020 18:59:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B3E728378BB9;
        Mon, 10 Aug 2020 22:59:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1544:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3355:3867:3868:4321:4605:5007:6261:7903:10007:10848:11026:11473:11658:11914:12043:12296:12297:12555:12679:12683:12895:12986:13095:13894:14110:14181:14394:14721:21080:21220:21433:21451:21627:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: kite24_201368f26fde
X-Filterd-Recvd-Size: 5222
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Aug 2020 22:59:26 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] scsi: lpfc: Neaten logging macro #defines
Date:   Mon, 10 Aug 2020 15:59:19 -0700
Message-Id: <950ff7825aa294397725d9142b1a65298e8aa026.1597100152.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1597100152.git.joe@perches.com>
References: <cover.1597100152.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use kernel standard do {} while (0) logging macros

Miscellanea:

o Use ..., ##__VA_ARGS__
o Indent and align
o Add __printf(2, 3) to lpfc_dbg_print function declaration

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/lpfc/lpfc_logmsg.h | 85 +++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_logmsg.h b/drivers/scsi/lpfc/lpfc_logmsg.h
index 5660a8729462..c57adcdda258 100644
--- a/drivers/scsi/lpfc/lpfc_logmsg.h
+++ b/drivers/scsi/lpfc/lpfc_logmsg.h
@@ -48,49 +48,60 @@
 #define LOG_ALL_MSG	0x7fffffff	/* LOG all messages */
 
 void lpfc_dmp_dbg(struct lpfc_hba *phba);
+__printf(2, 3)
 void lpfc_dbg_print(struct lpfc_hba *phba, const char *fmt, ...);
 
 /* generate message by verbose log setting or severity */
-#define lpfc_vlog_msg(vport, level, mask, fmt, arg...) \
-{ if (((mask) & (vport)->cfg_log_verbose) || (level[1] <= '4')) \
-	dev_printk(level, &((vport)->phba->pcidev)->dev, "%d:(%d):" \
-		   fmt, (vport)->phba->brd_no, vport->vpi, ##arg); }
+#define lpfc_vlog_msg(vport, level, mask, fmt, ...)			\
+do {									\
+	if (((mask) & (vport)->cfg_log_verbose) || (level[1] <= '4'))	\
+		dev_printk(level, &((vport)->phba->pcidev)->dev,	\
+			   "%d:(%d):" fmt,				\
+			   (vport)->phba->brd_no, vport->vpi,		\
+			   ##__VA_ARGS__);				\
+} while (0)
 
-#define lpfc_log_msg(phba, level, mask, fmt, arg...) \
-do { \
-	{ uint32_t log_verbose = (phba)->pport ? \
-				 (phba)->pport->cfg_log_verbose : \
-				 (phba)->cfg_log_verbose; \
-	if (((mask) & log_verbose) || (level[1] <= '4')) \
-		dev_printk(level, &((phba)->pcidev)->dev, "%d:" \
-			   fmt, phba->brd_no, ##arg); \
-	} \
+#define lpfc_log_msg(phba, level, mask, fmt, ...)			\
+do {									\
+	uint32_t log_verbose = (phba)->pport ?				\
+		(phba)->pport->cfg_log_verbose :			\
+		(phba)->cfg_log_verbose;				\
+	if (((mask) & log_verbose) || (level[1] <= '4'))		\
+		dev_printk(level, &((phba)->pcidev)->dev,		\
+			   "%d:" fmt,					\
+			   phba->brd_no, ##__VA_ARGS__);		\
 } while (0)
 
-#define lpfc_printf_vlog(vport, level, mask, fmt, arg...) \
-do { \
-	{ if (((mask) & (vport)->cfg_log_verbose) || (level[1] <= '3')) { \
-		if ((mask) & LOG_TRACE_EVENT) \
-			lpfc_dmp_dbg((vport)->phba); \
-		dev_printk(level, &((vport)->phba->pcidev)->dev, "%d:(%d):" \
-			   fmt, (vport)->phba->brd_no, vport->vpi, ##arg);  \
-		} else if (!(vport)->cfg_log_verbose) \
-			lpfc_dbg_print((vport)->phba, "%d:(%d):" fmt, \
-				(vport)->phba->brd_no, (vport)->vpi, ##arg); \
-	} \
+#define lpfc_printf_vlog(vport, level, mask, fmt, ...)			\
+do {									\
+	if (((mask) & (vport)->cfg_log_verbose) || (level[1] <= '3')) { \
+		if ((mask) & LOG_TRACE_EVENT)				\
+			lpfc_dmp_dbg((vport)->phba);			\
+		dev_printk(level, &((vport)->phba->pcidev)->dev,	\
+			   "%d:(%d):" fmt,				\
+			   (vport)->phba->brd_no, vport->vpi,		\
+			   ##__VA_ARGS__);				\
+	} else if (!(vport)->cfg_log_verbose) {				\
+		lpfc_dbg_print((vport)->phba,				\
+			       "%d:(%d):" fmt,				\
+			       (vport)->phba->brd_no, (vport)->vpi,	\
+			       ##__VA_ARGS__);				\
+	}								\
 } while (0)
 
-#define lpfc_printf_log(phba, level, mask, fmt, arg...) \
-do { \
-	{ uint32_t log_verbose = (phba)->pport ? \
-				 (phba)->pport->cfg_log_verbose : \
-				 (phba)->cfg_log_verbose; \
-	if (((mask) & log_verbose) || (level[1] <= '3')) { \
-		if ((mask) & LOG_TRACE_EVENT) \
-			lpfc_dmp_dbg(phba); \
-		dev_printk(level, &((phba)->pcidev)->dev, "%d:" \
-			fmt, phba->brd_no, ##arg); \
-	} else  if (!(phba)->cfg_log_verbose)\
-		lpfc_dbg_print(phba, "%d:" fmt, phba->brd_no, ##arg); \
-	} \
+#define lpfc_printf_log(phba, level, mask, fmt, ...)			\
+do {									\
+	uint32_t log_verbose = (phba)->pport ?				\
+		(phba)->pport->cfg_log_verbose :			\
+		(phba)->cfg_log_verbose;				\
+	if (((mask) & log_verbose) || (level[1] <= '3')) {		\
+		if ((mask) & LOG_TRACE_EVENT)				\
+			lpfc_dmp_dbg(phba);				\
+		dev_printk(level, &((phba)->pcidev)->dev,		\
+			   "%d:" fmt,					\
+			   phba->brd_no, ##__VA_ARGS__);		\
+	} else if (!(phba)->cfg_log_verbose) {				\
+		lpfc_dbg_print(phba, "%d:" fmt,				\
+			       phba->brd_no, ##__VA_ARGS__);		\
+	}								\
 } while (0)
-- 
2.26.0

