Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF6B302017
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 02:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbhAYBx6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 24 Jan 2021 20:53:58 -0500
Received: from smtp.infotech.no ([82.134.31.41]:45861 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbhAYBxJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 24 Jan 2021 20:53:09 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id CB0BD204195;
        Mon, 25 Jan 2021 02:37:55 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GEY7eBnC0RNN; Mon, 25 Jan 2021 02:37:54 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        by smtp.infotech.no (Postfix) with ESMTPA id 049B320415B;
        Mon, 25 Jan 2021 02:37:52 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        kashyap.desai@broadcom.com
Subject: [PATCH] fio: add hipri option to sg engine
Date:   Sun, 24 Jan 2021 20:37:51 -0500
Message-Id: <20210125013751.269675-1-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Adds hipri option to the Linux sg driver engine. This turns on the
SGV4_FLAG_HIPRI flag in recent sg drivers (January 2021) on READ
and WRITE commands (and not on UNMAP (trim), VERIFY, etc). Uses
blk_poll() and the mq_poll() callback in SCSI LLDs. The mechanism
is also called "iopoll".

The Linux sg engine in fio uses the struct sg_io_hdr based interface
known as the sg driver "v3" interface.
Linux sg drivers in the kernel prior to January 2021 (sg version
4.0.12) will just ignore the SGV4_FLAG_HIPRI flag and do normal
completions where LLDs indicate command completion with a (software)
interrupt or similar mechanism.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 engines/sg.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/engines/sg.c b/engines/sg.c
index a1a6de4c..0c2d2c8b 100644
--- a/engines/sg.c
+++ b/engines/sg.c
@@ -60,6 +60,10 @@
 
 #ifdef FIO_HAVE_SGIO
 
+#ifndef SGV4_FLAG_HIPRI
+#define SGV4_FLAG_HIPRI 0x800
+#endif
+
 enum {
 	FIO_SG_WRITE		= 1,
 	FIO_SG_WRITE_VERIFY	= 2,
@@ -68,12 +72,22 @@ enum {
 
 struct sg_options {
 	void *pad;
+	unsigned int hipri;
 	unsigned int readfua;
 	unsigned int writefua;
 	unsigned int write_mode;
 };
 
 static struct fio_option options[] = {
+        {
+                .name   = "hipri",
+                .lname  = "High Priority",
+                .type   = FIO_OPT_STR_SET,
+                .off1   = offsetof(struct sg_options, hipri),
+                .help   = "Use polled IO completions",
+                .category = FIO_OPT_C_ENGINE,
+                .group  = FIO_OPT_G_SG,
+        },
 	{
 		.name	= "readfua",
 		.lname	= "sg engine read fua flag support",
@@ -527,6 +541,8 @@ static int fio_sgio_prep(struct thread_data *td, struct io_u *io_u)
 		else
 			hdr->cmdp[0] = 0x88; // read(16)
 
+		if (o->hipri)
+			hdr->flags |= SGV4_FLAG_HIPRI;
 		if (o->readfua)
 			hdr->cmdp[1] |= 0x08;
 
@@ -542,6 +558,8 @@ static int fio_sgio_prep(struct thread_data *td, struct io_u *io_u)
 				hdr->cmdp[0] = 0x2a; // write(10)
 			else
 				hdr->cmdp[0] = 0x8a; // write(16)
+			if (o->hipri)
+				hdr->flags |= SGV4_FLAG_HIPRI;
 			if (o->writefua)
 				hdr->cmdp[1] |= 0x08;
 			break;
@@ -865,6 +883,7 @@ static int fio_sgio_init(struct thread_data *td)
 {
 	struct sgio_data *sd;
 	struct sgio_trim *st;
+	struct sg_io_hdr *h3p;
 	int i;
 
 	sd = calloc(1, sizeof(*sd));
@@ -880,12 +899,13 @@ static int fio_sgio_init(struct thread_data *td)
 #ifdef FIO_SGIO_DEBUG
 	sd->trim_queue_map = calloc(td->o.iodepth, sizeof(int));
 #endif
-	for (i = 0; i < td->o.iodepth; i++) {
+	for (i = 0, h3p = sd->sgbuf; i < td->o.iodepth; i++, ++h3p) {
 		sd->trim_queues[i] = calloc(1, sizeof(struct sgio_trim));
 		st = sd->trim_queues[i];
 		st->unmap_param = calloc(td->o.iodepth + 1, sizeof(char[16]));
 		st->unmap_range_count = 0;
 		st->trim_io_us = calloc(td->o.iodepth, sizeof(struct io_u *));
+		h3p->interface_id = 'S';
 	}
 
 	td->io_ops_data = sd;
-- 
2.25.1

