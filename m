Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B8168C2
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfEGRGq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44961 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id z16so8603145pgv.11
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dcCoZiF26ORknzMxcBW3zcM05iT1n+AfBsRDn09t5Cc=;
        b=eRBVUXSjj4Z/E2/HV3KdB0kOpSmy9N2O1oD8MLhNIz3WATdlEne8ne6yz71uwott3j
         2xR25P2oqf+jpQwPV32IF7x1R7nF9gHqV6CN5WtlxaZz1s+BtatR9fU+0ygcYXGbU10f
         wbFxDiP5TTEHt5RJV2CcI/PPTZX1bBSmywWhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dcCoZiF26ORknzMxcBW3zcM05iT1n+AfBsRDn09t5Cc=;
        b=ezFRi725cZKIRvUIwguz6AO0k3wFsDsLaOcH7lHjA4xEHFjFJTuPbHIN/DtNwkcLRa
         8vf0cgk0e90lAih1iFvrhl/uJzALCZuS/m/n2gt7l1bxURUXVwUahkScvtvDZ699MhXE
         RVQh/s5WWz18lniUX/Vs1huaALOHTyIRWHQb1QlIRPIBhcvAgXyLM2QI5n0GlW+qTzwg
         P7nlhQk+3QSmjTznvPZtxlKEavVeavMUG5d9BUm53MOnuQnA/eksDZJ3TMYnXsq+ONfC
         /XSbmCw94N5BH6mlpzRyl2alMMHLzGU8wYAV+wbO1E6CtCKhNOp+rp1lapK1tH1DnKCG
         LjiQ==
X-Gm-Message-State: APjAAAVGleFwfLJ7+UATXE2PLoJ80xhytViPkYljpERnsTqWAf5YLA4D
        2vioB8/3shVjxGAmz2WtexRZ3V//pbdEWtm58c4nWfFHl6jXbRC+8paw17I8WmIfHMgXDntDUNe
        BL5zt3gqjkstHZjstXit9+HUM6yBufAj3l9Ms9u0qfvn8nHkWIsRmqC0qWf1HvC+PsVRNyWP4nW
        U0IcoE1J86A0SVKD2J7R5e
X-Google-Smtp-Source: APXvYqxAYIxvuUzFL8M3pa7Cdu2RJJ2TrCj/9W29SdD6HzjCjHq5UW8UKBVDLQArIFz+qIP9g4S8lg==
X-Received: by 2002:a62:1897:: with SMTP id 145mr42897858pfy.122.1557248804975;
        Tue, 07 May 2019 10:06:44 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:44 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 10/21] megaraid_sas: Add formatting option for megasas_dump
Date:   Tue,  7 May 2019 10:05:39 -0700
Message-Id: <1557248750-4099-11-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add option to format the buffer that is being dumped.
Currently, the IO frame and chain frame dumped in the syslog is
getting split across multiple lines based on the formatting.
Fix this by using KERN_CONT in printk.

Signed-off-by: Sumit Saxena <sumit.saxena@broadcom.com>
Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index 7449df36a092..d0fd307e30af 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -2838,22 +2838,28 @@ blk_eh_timer_return megasas_reset_timer(struct scsi_cmnd *scmd)
 }
 
 /**
- * megasas_dump -	This function will provide hexdump
- * @ptr:		Pointer starting which memory should be dumped
- * @size:		Size of memory to be dumped
+ * megasas_dump -	This function will print hexdump of provided buffer.
+ * @buf:		Buffer to be dumped
+ * @sz:		Size in bytes
+ * @format:		Different formats of dumping e.g. format=n will
+ *			cause only 'n' 32 bit words to be dumped in a single
+ *			line.
  */
 inline void
-megasas_dump(void *ptr, int sz)
+megasas_dump(void *buf, int sz, int format)
 {
 	int i;
-	__le32 *loc = (__le32 *)ptr;
+	__le32 *buf_loc = (__le32 *)buf;
 
-	for (i = 0; i < sz / sizeof(__le32); i++) {
-		if (i && ((i % 8) == 0))
-			printk("\n\t");
-		printk("%08x ", le32_to_cpu(loc[i]));
+	for (i = 0; i < (sz / sizeof(__le32)); i++) {
+		if ((i % format) == 0) {
+			if (i != 0)
+				printk(KERN_CONT "\n");
+			printk(KERN_CONT "%08x: ", (i * 4));
+		}
+		printk(KERN_CONT "%08x ", le32_to_cpu(buf_loc[i]));
 	}
-	printk("\n");
+	printk(KERN_CONT "\n");
 }
 
 /**
@@ -2887,10 +2893,10 @@ megasas_dump_fusion_io(struct scsi_cmnd *scmd)
 
 		printk(KERN_INFO "IO request frame:\n");
 		megasas_dump(cmd->io_request,
-			     MEGA_MPI2_RAID_DEFAULT_IO_FRAME_SIZE);
+			     MEGA_MPI2_RAID_DEFAULT_IO_FRAME_SIZE, 8);
 		printk(KERN_INFO "Chain frame:\n");
 		megasas_dump(cmd->sg_frame,
-			     instance->max_chain_frame_sz);
+			     instance->max_chain_frame_sz, 8);
 	}
 
 }
-- 
2.16.1

