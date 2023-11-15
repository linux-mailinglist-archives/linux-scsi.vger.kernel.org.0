Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB517EB8C9
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Nov 2023 22:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbjKNVm1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Nov 2023 16:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjKNVmX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Nov 2023 16:42:23 -0500
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136ACD3;
        Tue, 14 Nov 2023 13:42:20 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6be0277c05bso5538453b3a.0;
        Tue, 14 Nov 2023 13:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699998139; x=1700602939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1brJKUOnTkerz7z+3OAzXxKRYG42ebHtTV2go3o4hCs=;
        b=uC3S/r2tYt/terrLxpmRe+OI7luoWMuUb0nvTSzoGoXEZjJcB1M7Lwow6sLrFoOs8K
         HWQh2xxe4KmezaK5Zit9Cx3gPkI3XinW4SxAnrEC2K11vgZOVLh2qSIpFHzA6kOfHBFR
         FcJ43PruSLNlrpiJGe4uP5k0sjZdzdEW/Lv4ZkZMQFopaTVE+4OS4y6buD4kr6d6hORP
         5CjPgD7HR2rBakyt0Ia25MP1EmHwY2L2cVsezMZocqHZQwNTfMq6sM/MvIs3y+YXc0fL
         17dtwgrte5RKtz3HHEd5X4rgzEujn0RlpiLSAV/kxAd9VEUYUObUtLT7nIBQ/rOO1qCB
         jMbg==
X-Gm-Message-State: AOJu0Yyqi6xukS+8mOqUjxlUaW2vvdCGPr9jTN1vKpDqH6Hxab6F+UYn
        tUzNjANtD17MXNnSHXINvdk=
X-Google-Smtp-Source: AGHT+IGCUWloINjLev3h5lI5el4hMFehGt5P3BZLdvianci18WX/ytxLjQRRZsxARiaeDdxm0pQ0jw==
X-Received: by 2002:a05:6a20:4295:b0:181:6afb:b814 with SMTP id o21-20020a056a20429500b001816afbb814mr9968696pzj.6.1699998139402;
        Tue, 14 Nov 2023 13:42:19 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:2278:ad72:cefb:4d49])
        by smtp.gmail.com with ESMTPSA id o16-20020a170902d4d000b001c3267ae317sm6133926plg.165.2023.11.14.13.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:42:19 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Daejun Park <daejun7.park@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v4 10/15] scsi_debug: Support the block limits extension VPD page
Date:   Tue, 14 Nov 2023 13:41:05 -0800
Message-ID: <20231114214132.1486867-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231114214132.1486867-1-bvanassche@acm.org>
References: <20231114214132.1486867-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From SBC-5 r05:

"Reduced stream control:
a) reduces the maximum number of streams that the device server supports;
   and
b) increases the number of write commands that are able to specify a stream
   to be written in any write command that contains the GROUP NUMBER field
   in its CDB.

If the RSCS bit (see 6.6.5) is set to one, then the device server shall:
a) support per group stream identifier usage as described in 4.32.2;
b) support the IO Advice Hints Grouping mode page (see 6.5.7); and
c) set the MAXIMUM NUMBER OF STREAMS field (see 6.6.5) to a value that is
   less than 64.

Device servers that set the RSCS bit to one may support other features
(e.g., permanent streams (see 4.32.4)).

4.32.4 Permanent streams

A permanent stream is a stream for which the device server does not allow
closing or otherwise modifying the configuration of that stream. The PERM
bit (see 5.9.2.3) indicates whether a stream is a permanent stream. If a
STREAM CONTROL command (see 5.32) specifies the closing of a permanent
stream, the device server terminates that command with CHECK CONDITION
status instead of closing the specified stream. A permanent stream is always
an open stream. Device severs should assign the lowest numbered stream
identifiers to permanent streams."

Report that reduced stream control is supported.

Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 5cf337ba9c19..11c57aed73ce 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -1938,6 +1938,7 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 					arr[n++] = 0xb2;  /* LB Provisioning */
 				if (is_zbc)
 					arr[n++] = 0xb6;  /* ZB dev. char. */
+				arr[n++] = 0xb7;  /* Block limits extension */
 			}
 			arr[3] = n - 4;	  /* number of supported VPD pages */
 		} else if (0x80 == cmd[2]) { /* unit serial number */
@@ -1980,6 +1981,9 @@ static int resp_inquiry(struct scsi_cmnd *scp, struct sdebug_dev_info *devip)
 			arr[3] = inquiry_vpd_b2(&arr[4]);
 		} else if (is_zbc && cmd[2] == 0xb6) { /* ZB dev. charact. */
 			arr[3] = inquiry_vpd_b6(devip, &arr[4]);
+		} else if (cmd[2] == 0xb7) { /* block limits extension page */
+			arr[3] = 2; /* page length */
+			arr[5] = 1; /* Reduced stream control support (RSCS) */
 		} else {
 			mk_sense_invalid_fld(scp, SDEB_IN_CDB, 2, -1);
 			kfree(arr);
