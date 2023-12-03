Return-Path: <linux-scsi+bounces-477-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D60802753
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 21:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730D1B2084C
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 20:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FB21EB49
	for <lists+linux-scsi@lfdr.de>; Sun,  3 Dec 2023 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/zqBIA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F8135;
	Sun,  3 Dec 2023 11:33:39 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5d2d0661a8dso42512027b3.2;
        Sun, 03 Dec 2023 11:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632017; x=1702236817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVsELyxy68dmggeIG0kcyXEOpVBmGZtkau6ouEM1P78=;
        b=ii/zqBIAHYheanhiziJphVCTI7VGFXTkFir1bpoRbN1T5jmstS1tddY/OxI09JoFPO
         VNRfna0raZ6T5zY1sQW6jIvmPHzIsOjvuom6TJtw2b2ioGudmsM1sGr2mU8c+i5MtcpT
         1cDc+3IE0paDpy7aYjzQg9dHRoTQ5Bo2dZJ8IXr1Pp3Q/5u1aH11zERouv/0fT8x7J+r
         TIZDT+QKNdviP5PccV3P2NpBMhW6iXYSfKn54roIryAzpYJJEVfxnBSAt80myhHoWQiA
         FCoJ7E0bxbDCCpz0SpTIoTWAYqZ2ULvellPhdFUEVTgdkRqc9eYc6AZcFIfI65/lty9I
         52zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632017; x=1702236817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVsELyxy68dmggeIG0kcyXEOpVBmGZtkau6ouEM1P78=;
        b=r7DvBXMT7Evd9RBbq/r2DlgzJE0GwduGM8SIot6MV85Z7J+8rqwo5aymsNfNIdfczq
         ch7JOdbUUgNj48dNhwkHDk8TLw2H4Lu4gCRwvLF7tulXKEQrOkdA8vIOYxbjlIQhfRdP
         yYM7ueJxVVZGpC/zBBarnzYFr3ikMD+E4bFKJYJkjbzlsbpNyjA6AuQodxfjFM7tUFw9
         hWFlfH8jM3Do/zdZGKtfxlHrg4xgdAJSVtjbsAmRCTvwmLpYyf7qLUlDb808Vpu7lMss
         QD4rYXm+tn2NyhfJNEfadFo8laa0kI7MHH5IjL6ZttOiKAj4qxUzF/Zcykxkfi2x07n8
         bchQ==
X-Gm-Message-State: AOJu0YwToNBOiVQ1ESEkNQctZPw+4WuhNPUxDq1d9S0xccAt/QcROUf/
	RSE0bVqgfNx3K9+rEx0l1WGduonxqecQeQ==
X-Google-Smtp-Source: AGHT+IHGTpQ20NjZZmmBrSidymjFFAU/8VGXLo5ZUxOJVsbKX3p0rF0WJOFHweJj2Y1AyJtt1v9iaA==
X-Received: by 2002:a25:e695:0:b0:db7:dacf:59da with SMTP id d143-20020a25e695000000b00db7dacf59damr1371784ybh.78.1701632017094;
        Sun, 03 Dec 2023 11:33:37 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id a198-20020a25cacf000000b00da082362238sm1817172ybg.0.2023.12.03.11.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:33:35 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	linux-scsi@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 16/35] scsi: mpi3mr: switch to using atomic find_and_set_bit()
Date: Sun,  3 Dec 2023 11:32:48 -0800
Message-Id: <20231203193307.542794-15-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpi3mr_dev_rmhs_send_tm() and mpi3mr_send_event_ack() opencode
find_and_set_bit(). Switch them to using dedicated functions.

CC: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/scsi/mpi3mr/mpi3mr_os.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index 040031eb0c12..11139a2008fd 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -2276,13 +2276,9 @@ static void mpi3mr_dev_rmhs_send_tm(struct mpi3mr_ioc *mrioc, u16 handle,
 	if (drv_cmd)
 		goto issue_cmd;
 	do {
-		cmd_idx = find_first_zero_bit(mrioc->devrem_bitmap,
-		    MPI3MR_NUM_DEVRMCMD);
-		if (cmd_idx < MPI3MR_NUM_DEVRMCMD) {
-			if (!test_and_set_bit(cmd_idx, mrioc->devrem_bitmap))
-				break;
-			cmd_idx = MPI3MR_NUM_DEVRMCMD;
-		}
+		cmd_idx = find_and_set_bit(mrioc->devrem_bitmap, MPI3MR_NUM_DEVRMCMD);
+		if (cmd_idx < MPI3MR_NUM_DEVRMCMD)
+			break;
 	} while (retrycount--);
 
 	if (cmd_idx >= MPI3MR_NUM_DEVRMCMD) {
@@ -2417,14 +2413,9 @@ static void mpi3mr_send_event_ack(struct mpi3mr_ioc *mrioc, u8 event,
 	    "sending event ack in the top half for event(0x%02x), event_ctx(0x%08x)\n",
 	    event, event_ctx);
 	do {
-		cmd_idx = find_first_zero_bit(mrioc->evtack_cmds_bitmap,
-		    MPI3MR_NUM_EVTACKCMD);
-		if (cmd_idx < MPI3MR_NUM_EVTACKCMD) {
-			if (!test_and_set_bit(cmd_idx,
-			    mrioc->evtack_cmds_bitmap))
-				break;
-			cmd_idx = MPI3MR_NUM_EVTACKCMD;
-		}
+		cmd_idx = find_and_set_bit(mrioc->evtack_cmds_bitmap, MPI3MR_NUM_EVTACKCMD);
+		if (cmd_idx < MPI3MR_NUM_EVTACKCMD)
+			break;
 	} while (retrycount--);
 
 	if (cmd_idx >= MPI3MR_NUM_EVTACKCMD) {
-- 
2.40.1


